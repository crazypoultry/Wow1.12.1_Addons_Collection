DMGCALC_DEBUG = false

DmgCalc_SavedVariables = 
{ 
};

--Color
DMGCALC_COLOR_BONUS     = {};
DMGCALC_COLOR_BONUS[DMGCALC_PARSING_WORD_EQUIP] = "|cff008888";
DMGCALC_COLOR_BONUS[DMGCALC_PARSING_WORD_USE]   = "|cff888800";

DMGCALC_ALL_KEYS = { DMGCALC_PARSING_KEY_ARCANE,
										 DMGCALC_PARSING_KEY_FIRE,
										 DMGCALC_PARSING_KEY_NATURE,
										 DMGCALC_PARSING_KEY_FROST,
										 DMGCALC_PARSING_KEY_SHADOW,
										 DMGCALC_PARSING_KEY_CRITICAL,
										 DMGCALC_PARSING_KEY_HEALING,
                     DMGCALC_PARSING_KEY_HIT,
                     DMGCALC_PARSING_KEY_MANAREGEN,
										 DMGCALC_PARSING_KEY_MAGICAL } 

DmgCalc = {

  MAX_INVENTORY_SLOTS = 19;
  MAX_TOOLTIPS_INFOS  = 30;
  CLASS_DAMAGE_ONLY   = "MAGE,WARLOCK";

  DamageClass         = false;
  DmgTable						= {};
  CurrentItem					= {};

  SetsBonusProcessed  = {};
  ToolTips            = {};

  DebugVars = function ( aMsg, arg1, arg2, arg3 ) 
    if DMGCALC_DEBUG then
      if aMsg == nil then
        aMsg = "<nil>";
      end 
      if arg1 == nil then
        arg1 = "<nil>";
      end 
      if arg2 == nil then
        arg2 = "<nil>";
      end 
      if arg3 == nil then
        arg3 = "<nil>";
      end 
      DmgCalc.ChatMsg(DMGCALC_COLOR_DEBUG .. DMGCALC_SUBPROMPT .. aMsg .. 
                        " A1:" .. arg1 .. " A2:" .. arg2 .. " A3:" .. arg3);
    end
  end;

  Debug = function ( aMsg ) 
    if DMGCALC_DEBUG then
      if aMsg == nil then
        aMsg = "<nil>";
      end 
      DmgCalc.ChatMsg(DMGCALC_COLOR_DEBUG .. DMGCALC_SUBPROMPT .. aMsg);
    end
  end;

  ErrMsg = function ( aMsg ) 
    if aMsg == nil then
      aMsg = "<nil>";
    end 
    if (DmgCalc_SavedVariables.EnableErrMsg) then
      DmgCalc.ChatMsg(DMGCALC_COLOR_ERR .. DMGCALC_SUBPROMPT .. aMsg);
    end
  end;

  ChatMsg = function ( aMsg ) 
    if( DEFAULT_CHAT_FRAME and aMsg ~= nil) then
        DEFAULT_CHAT_FRAME:AddMessage(aMsg,1.00,1.00,1.00);
    end
  end;

  GetSetName = function()
    local name = "DmgCalc_TooltipText";
    for k=1,DmgCalc.MAX_TOOLTIPS_INFOS do
      local line = getglobal(name.."Left"..k)
--      DmgCalc.DebugVars("Line:",line);
      local text = line:GetText()
      if text ~= nil then
--        local color = line:GetColors();
--        DmgCalc.DebugVars("Line:",text);
	
			  for setName,oneof,totalof in string.gfind(string.lower(text),DMGCALC_PARSING_SETS) do
			    if setName ~= nil then
--	      DmgCalc.DebugVars("Set:",setName,oneof,totalof);
            return(setName);
			    end
	  	  end
      end
		end
  end;

  isSetAlreadyProcessed = function (aText,aInventoryID)
    local getSetName = DmgCalc.GetSetName(aInventoryID);
     
    if getSetName ~= nil then
      if DmgCalc.SetsBonusProcessed[getSetName .. aText] ~= nil then
        return true;
      else
        DmgCalc.SetsBonusProcessed[getSetName .. aText] = true;
      end 
    end

    return false;
  end;

  Trim = function (aStr)    
    return (string.gsub(aStr, "^%s*(.-)%s*$", "%1"))
  end;

  ParseString = function (aText,aInventoryID)

    if aText == nil then
      return
    end

    if DmgCalc_LocalizationParse ~= nil then
      DmgCalc_LocalizationParse(aText,aInventoryID);
    end

  end;

  -- Thank allakhazam for this
	GetItemInfoFromLink = function (link)
    if link ~= nil then
		  for itemid, enchant, subid, itemname in string.gfind(link, "|c%x+|Hitem:(%d+):(%d+):(%d+):%d+|h%[(.-)%]|h|r") do
		    return itemname;
		  end
    end
	end;

  AddTooltipsInner = function (aItem,aKey,aValue,aItemBySchool)
    if aItemBySchool[aKey] == nil then
      aItemBySchool[aKey] = {}
      aItemBySchool[aKey][DMGCALC_PARSING_WORD_USE] = {}
      aItemBySchool[aKey][DMGCALC_PARSING_WORD_EQUIP] = {}
    end

    if aValue.Type ~= DMGCALC_PARSING_WORD_USE and DMGCALC_PARSING_WORD_EQUIP ~= aValue.Type then
      DmgCalc.DebugVars("Bad aKet/aValue.Type",aKey,aValue.Type);
    else
      table.insert(aItemBySchool[aKey][aValue.Type],aValue.Dmg);
    end
  end;
  
  AddTooltips = function(aItem)

    local textBonus = { DMGCALC_PARSING_WORD_USE = nil , DMGCALC_PARSING_WORD_EQUIP = nil};
    local itemBySchool = {};

    for k,v in DmgCalc.CurrentItem do
      if v.Key == DMGCALC_PARSING_KEY_MAGICAL then
        for id=1,5 do 
          DmgCalc.AddTooltipsInner(aItem,DMGCALC_ALL_KEYS[id],v,itemBySchool);
        end
      else 
        DmgCalc.AddTooltipsInner(aItem,v.Key,v,itemBySchool);
      end       
    end

    local text;

    for k,v in itemBySchool do

      text = nil
      textBonus = {};

      for k1,v1 in itemBySchool[k] do
        for k2,v2 in itemBySchool[k][k1] do
--          DmgCalc.DebugVars("Inner:",k,k1,k2);
          if textBonus[k1] ~= nil then
            textBonus[k1] = textBonus[k1] .. DMGCALC_COLOR_TEXT .. "+" .. DMGCALC_COLOR_BONUS[k1] .. v2;
          else
            textBonus[k1] = DMGCALC_COLOR_BONUS[k1] .. v2;
          end
        end  
      end

	    if textBonus[DMGCALC_PARSING_WORD_EQUIP] ~= nil then
	      text = DMGCALC_COLOR_TEXT .. textBonus[DMGCALC_PARSING_WORD_EQUIP]
	    end;
	
	    if textBonus[DMGCALC_PARSING_WORD_USE] ~= nil then
	      if text ~= nil then 
	        text = text .. DMCALC_COLOR_TEXT .. "+" .. textBonus[DMGCALC_PARSING_WORD_USE]
	      else
	        text = DMGCALC_COLOR_BONUS[DMGCALC_PARSING_WORD_USE] .. textBonus[DMGCALC_PARSING_WORD_USE]
	      end
	    end;
	   
	    if text == nil then
	      text = DMGCALC_COLOR_TEXT .. DMGCALC_PARSING_WORD_FROM .. aItem;
      else
	      text = text .. " " .. DMGCALC_COLOR_TEXT .. DMGCALC_PARSING_WORD_ON .. aItem;
	    end;
      
      if DmgCalc.ToolTips[k] == nil then 
        DmgCalc.ToolTips[k] = {};
      end

      table.insert(DmgCalc.ToolTips[k],text);
    end
  end;

  AddItemDmg = function(aKey,aType,aDmg)  
--    DmgCalc.DebugVars("AddItemDmg",aKey,aType,aDmg);  
    if DmgCalc.DmgTable[aKey] ~= nil then
	    if DmgCalc.DmgTable[aKey][aType] ~= nil then
	      DmgCalc.DmgTable[aKey][aType] = DmgCalc.DmgTable[aKey][aType] + aDmg
        table.insert(DmgCalc.CurrentItem,{ Key = aKey , Type = aType, Dmg = aDmg });
	    else
	      DmgCalc.DebugVars("Sub Item not processed",aKey,aType);
	    end    
    else
      DmgCalc.DebugVars("Item not processed",aKey,aType);
    end
  end;

  Calc = function()

    local text,name
    name = "DmgCalc_TooltipText";
    
    DmgCalc.SetsBonusProcessed = {};
    DmgCalc.DmgTable = {};
    DmgCalc.ToolTips = {};

    for index,key in DMGCALC_ALL_KEYS do
--      DmgCalc.DebugVars(key,DMGCALC_PARSING_WORD_EQUIP,DMGCALC_PARSING_WORD_USE);
      DmgCalc.DmgTable[key] = { }
      DmgCalc.DmgTable[key][DMGCALC_PARSING_WORD_EQUIP] = 0
      DmgCalc.DmgTable[key][DMGCALC_PARSING_WORD_USE] = 0
    end

--RangedSlot
--      for i=GetInventorySlotInfo("Trinket0Slot"),GetInventorySlotInfo("Trinket0Slot") do
--      for i=GetInventorySlotInfo("RangedSlot"),GetInventorySlotInfo("RangedSlot") do
--		for i=GetInventorySlotInfo("MainHandSlot"),GetInventorySlotInfo("MainHandSlot") do
    for i=1,DmgCalc.MAX_INVENTORY_SLOTS do

      local texture = GetInventoryItemTexture("player", i)
      if texture ~= nil then
        DmgCalc.DebugVars("Item:",DmgCalc.GetItemInfoFromLink(GetInventoryItemLink("player", i)));
				DmgCalc_Tooltip:SetInventoryItem("player",i)
	
        DmgCalc.CurrentItem = {};

				for k=1,DmgCalc.MAX_TOOLTIPS_INFOS do
	        text = getglobal(name.."Left"..k):GetText()
          DmgCalc.DebugVars("text:",text);
			    DmgCalc.ParseString(text,i);
				end

        DmgCalc.AddTooltips(DmgCalc.GetItemInfoFromLink(GetInventoryItemLink("player", i)));
            
      end
	  end

    DmgCalc.ShowText(DMGCALC_PARSING_WORD_EQUIP);
  end;

  ShowText = function (aMode)

    DmgCalcFrameDmg1TextBottom:SetText(DmgCalc.DmgTable[DMGCALC_PARSING_KEY_MAGICAL][aMode] + 
                                       DmgCalc.DmgTable[DMGCALC_PARSING_KEY_ARCANE][aMode]);
    DmgCalcFrameDmg2TextBottom:SetText(DmgCalc.DmgTable[DMGCALC_PARSING_KEY_MAGICAL][aMode] + 
                                       DmgCalc.DmgTable[DMGCALC_PARSING_KEY_FIRE][aMode]);
    DmgCalcFrameDmg3TextBottom:SetText(DmgCalc.DmgTable[DMGCALC_PARSING_KEY_MAGICAL][aMode] + 
                                       DmgCalc.DmgTable[DMGCALC_PARSING_KEY_NATURE][aMode]);
    DmgCalcFrameDmg4TextBottom:SetText(DmgCalc.DmgTable[DMGCALC_PARSING_KEY_MAGICAL][aMode] + 
                                       DmgCalc.DmgTable[DMGCALC_PARSING_KEY_FROST][aMode]);
    DmgCalcFrameDmg5TextBottom:SetText(DmgCalc.DmgTable[DMGCALC_PARSING_KEY_MAGICAL][aMode] + 
                                       DmgCalc.DmgTable[DMGCALC_PARSING_KEY_SHADOW][aMode]);

    DmgCalcFrameDmg6TextBottom:SetText(DmgCalc.DmgTable[DMGCALC_PARSING_KEY_CRITICAL][aMode]);

    if not DmgCalc.DamageClass then
	    DmgCalcFrameDmg7TextBottom:SetText(DmgCalc.DmgTable[DMGCALC_PARSING_KEY_HEALING][aMode]);
    end    

    DmgCalcFrameDmg8TextBottom:SetText(DmgCalc.DmgTable[DMGCALC_PARSING_KEY_HIT][aMode]);
    
    DmgCalcFrameDmg9TextBottom:SetText(DmgCalc.DmgTable[DMGCALC_PARSING_KEY_MANAREGEN][aMode]);
  end;

  Init = function ()
    local _,class = UnitClass("player");
    local pos = string.find(DmgCalc.CLASS_DAMAGE_ONLY,class);
--  DmgCalc.DebugVars(pos,class,DmgCalc.CLASS_DAMAGE_ONLY);

    DmgCalc.DamageClass = (pos ~= nil) and (not DMGCALC_DEBUG);

	  if DmgCalc.DamageClass then
	    DmgCalcFrameDmg7:Hide();
	  end
  end;
};

function DmgCalcFrame_OnLoad()
  
  SLASH_DMGCALC1 = "/" .. DMGCALC_COMMAND_SHORT;
  SLASH_DMGCALC2 = "/" .. DMGCALC_COMMAND;

  SlashCmdList["DMGCALC"] = DmgCalc_SlashCommandHandler;

  this:RegisterEvent("UNIT_INVENTORY_CHANGED");
  this:RegisterEvent("PLAYER_ENTERING_WORLD"); -- Will be called 1 time for init

  DmgCalc.ChatMsg(DMGCALC_WELCOME);  
 
  for i=1,9 do
    getglobal("DmgCalcFrameDmg"..i.."TextBottom"):SetTextColor(1,1,0);
  end

--  DmgCalcFrameDmg6TextBottom:SetTextColor(0,0,1);
--  DmgCalcFrameDmg7TextBottom:SetTextColor(0,0,1);
--  DmgCalcFrameDmg8TextBottom:SetTextColor(0,0,1);

--[[
  DmgCalcFrameDmg1TextBottom:SetTextColor(1,0,0);
  DmgCalcFrameDmg2TextBottom:SetTextColor(0,1,0);
  DmgCalcFrameDmg3TextBottom:SetTextColor(0,0,1);
  DmgCalcFrameDmg4TextBottom:SetTextColor(1,0,1);
  DmgCalcFrameDmg5TextBottom:SetTextColor(1,1,0);
]]--
end;


function DmgCalcFrame_OnEvent()
  if( event == "PLAYER_ENTERING_WORLD" ) then
    DmgCalc.Init();
    this:UnregisterEvent("PLAYER_ENTERING_WORLD");
  end
  if ( DmgCalcFrame:IsVisible() ) then
    if( event == "VARIABLES_LOADED" ) then
    elseif ( event == "UNIT_INVENTORY_CHANGED" ) then
      if (arg1 == "player" and DmgCalcFrame:IsVisible()) then
        DmgCalc.Calc();
      end
    end
  end
end;

function DmgCalc_SlashCommandHandler(slashMsg)
   DmgCalc.Debug(slashMsg);
   if( slashMsg ) then
      local DmgCalc_command = string.lower(slashMsg);
      if( DmgCalc_command == "reset" ) then

      elseif( DmgCalc_command == "calc" ) then
      else
        table.foreach(DMGCALC_HELP,function(x,y) DmgCalc.ChatMsg(y) end);
      end
   end
end

function DmgCalcDmg_Tooltips(aFlip)
  if (aFlip) then
	  local frame_name = this:GetName();

    for id in string.gfind(frame_name,"DmgCalcFrameDmg(%d+)") do
       
      id = id + 0;
--      DmgCalc.DebugVars(id,DMGCALC_TOOLTIPS_TITLE[id],test,DMGCALC_TOOLTIPS_TITLE[1]);
			GameTooltip:SetOwner(this, "ANCHOR_RIGHT");	

      local equipDmg, useDmg, title, addDmg;    
      if id <= 5 then
        equipDmg = DmgCalc.DmgTable[DMGCALC_PARSING_KEY_MAGICAL][DMGCALC_PARSING_WORD_EQUIP]+
                   DmgCalc.DmgTable[DMGCALC_ALL_KEYS[id]][DMGCALC_PARSING_WORD_EQUIP];
        useDmg   = DmgCalc.DmgTable[DMGCALC_PARSING_KEY_MAGICAL][DMGCALC_PARSING_WORD_USE]+
                   DmgCalc.DmgTable[DMGCALC_ALL_KEYS[id]][DMGCALC_PARSING_WORD_USE];
      else
        equipDmg = DmgCalc.DmgTable[DMGCALC_ALL_KEYS[id]][DMGCALC_PARSING_WORD_EQUIP];
        useDmg   = DmgCalc.DmgTable[DMGCALC_ALL_KEYS[id]][DMGCALC_PARSING_WORD_USE];
      end
     
      title = DMGCALC_COLOR_TITLE .. DMGCALC_TOOLTIPS_TITLE[id] 
      
--      DmgCalc.DebugVars("EQ:", equipDmg,useDmg);

      addDmg = nil;
      if equipDmg ~= nil then
        addDmg = DMGCALC_COLOR_TEXT .. " (" .. DMGCALC_PROMPT_EQUIP .. DMGCALC_COLOR_BONUS[DMGCALC_PARSING_WORD_EQUIP] .. equipDmg;
      end
      
      if useDmg ~= nil then
        if addDmg ~= nil then
          addDmg = addDmg .. DMGCALC_COLOR_TEXT .. "+" .. DMGCALC_PROMPT_USE .. DMGCALC_COLOR_BONUS[DMGCALC_PARSING_WORD_USE] .. useDmg;
        else
          addDmg = DMGCALC_COLOR_TEXT .. "(" .. DMGCALC_PROMPT_USE .. DMGCALC_COLOR_BONUS[DMGCALC_PARSING_WORD_USE] .. useDmg;
        end
      end

      if addDmg ~= nil then
        title = title .. addDmg .. DMGCALC_COLOR_TEXT .. ")";
      end
  
			GameTooltip:AddLine(title);
      
      if DmgCalc.ToolTips[DMGCALC_ALL_KEYS[id]] ~= nil then
	      for key,value in DmgCalc.ToolTips[DMGCALC_ALL_KEYS[id]] do
					GameTooltip:AddLine(value);
	      end
      end

			GameTooltip:Show()
    end

  else
  	GameTooltip:Hide()
  end
end

function DmgCalc_Tooltips(aFlip)
  if (aFlip) then
	  local tooltip_name = this:GetName();
	  if DmgCalcToolTips[tooltip_name] ~= nil then
			GameTooltip_SetDefaultAnchor(GameTooltip,this)
			GameTooltip:AddLine(DmgCalcToolTips[tooltip_name].title)
			GameTooltip:AddLine(DmgCalcToolTips[tooltip_name].text,.8,.8,.8,1)
			GameTooltip:Show()
	  end
  else
  	GameTooltip:Hide()
  end
end

function DmgCalc_PaperDollFrame_OnShow()
  DmgCalc_OldPaperDollFrame_OnShow();

  this:RegisterEvent("UNIT_INVENTORY_CHANGED");
  DmgCalc.Calc();
  DmgCalcFrame:Show();
end

function DmgCalc_PaperDollFrame_OnHide()
  DmgCalc_OldPaperDollFrame_OnHide();

  this:UnregisterEvent("UNIT_INVENTORY_CHANGED");
  DmgCalcFrame:Hide();
end

function DmgCalcFrame_OnDragStart()
	SunderThis:StartMoving();
end

function DmgCalcFrame_OnDragStop()
  SunderThis:StopMovingOrSizing();
end

DmgCalc_OldPaperDollFrame_OnShow = PaperDollFrame_OnShow
PaperDollFrame_OnShow            = DmgCalc_PaperDollFrame_OnShow

DmgCalc_OldPaperDollFrame_OnHide = PaperDollFrame_OnHide
PaperDollFrame_OnHide            = DmgCalc_PaperDollFrame_OnHide