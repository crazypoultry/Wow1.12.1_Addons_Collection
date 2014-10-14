HB_DEBUG = 0;
HB_Variables_Loaded = false;
HB_Config = 
{
    OnSide = true;    
    Enabled = true;
    DropForm = true;
    Moved = false;
    Movable = true;
    Tooltip = true;
    
    ToolTipParent;
    ToolTipAnchor;

    Notify = false;
    -- raid (=party if not in raid), party (=self if not in party), self, say
    NotifyChannel = "self";

    ButtonLocs = 
    {
        Player = {5,-20, 5, -45};
        Party1 = {0, -5, 0, -30};
        Party2 = {0, -5, 0, -30};
        Party3 = {0, -5, 0, -30};
        Party4 = {0, -5, 0, -30};
    };
    SpellTable = 
    {
        Priest = 
        {
            ID = {},
            Rank = {},
            Type = {'SPELL','SPELL','SPELL','SPELL','SPELL','SPELL'},
            --       Right                   middle        left           right     middle       left
            Name = {HB_GREATER_HEAL,HB_POWER_WORD_SHIELD,HB_LESSER_HEAL,HB_FLASH_HEAL,HB_HEAL,HB_RENEW}
        };
        Shaman = 
        {
            ID = {},
            Rank = {},
            Type = {'SPELL','SPELL','SPELL','SPELL','SPELL','SPELL','SPELL'},
            Name = {HB_HEALING_WAVE,HB_CURE_DISEASE,HB_LESSER_HEALING_WAVE,HB_CHAIN_HEAL,HB_ANCESTRAL_SPIRIT,HB_CURE_POISON}
        };
        Druid = 
        {
           ID = {},
            Rank = {},
            Type = {'SPELL','SPELL','SPELL','SPELL','SPELL','SPELL', 'SPELL'},
            Name = {HB_REJUVENATION,HB_CURE_POISON,HB_HEALING_TOUCH,HB_REBIRTH,HB_REMOVE_CURSE,HB_REGROWTH, HB_ABOLISH_POISON}
        };
        Paladin = 
        {
           ID = {},
            Rank = {},
            Type = {'SPELL','SPELL','SPELL','SPELL','SPELL','SPELL'},
            Name = {HB_HOLY_LIGHT,HB_CLEANSE,HB_FLASH_OF_LIGHT,HB_PURIFY,"",HB_REDEMPTION}
        }
    }
}

HB_BANDAGE_INFO =
{
    [HB_BANDAGE.Linen]  = {Level=1, HealAmount=66, OnHand = 0, Bag = -1, Slot = 0},
    [HB_BANDAGE.HeavyLinen]  = {Level=1, HealAmount=114, OnHand = 0, Bag = -1, Slot = 0},
    [HB_BANDAGE.Wool]  = {Level=1, HealAmount=161, OnHand = 0, Bag = -1, Slot = 0},
    [HB_BANDAGE.HeavyWool]  = {Level=1, HealAmount=301, OnHand = 0, Bag = -1, Slot = 0},
    [HB_BANDAGE.Silk]  = {Level=1, HealAmount=400, OnHand = 0, Bag = -1, Slot = 0},
    [HB_BANDAGE.HeavySilk]  = {Level=1, HealAmount=640, OnHand = 0, Bag = -1, Slot = 0},
    [HB_BANDAGE.Mageweave]  = {Level=1, HealAmount=800, OnHand = 0, Bag = -1, Slot = 0},
    [HB_BANDAGE.HeavyMageweave]  = {Level=1, HealAmount=1104, OnHand = 0, Bag = -1, Slot = 0},
    [HB_BANDAGE.Runecloth]  = {Level=52,HealAmount=1360, OnHand = 0, Bag = -1, Slot = 0},
    [HB_BANDAGE.HeavyRunecloth]  = {Level=58,HealAmount=2000, OnHand = 0, Bag = -1, Slot = 0}
}
HB_Levels = 
{
    SHIELD = 
    {
        Rank = { 1, 12, 18, 24, 30, 36, 42, 48, 54, 60 };
    };
    FORTITUDE = 
    {
        Rank = { 1, 2, 8, 14, 20, 26, 32, 38, 44, 50 };
    };
    SHADOW = 
    {
        Rank = { 20, 32, 46 };
    };
    SPIRIT = 
    {
        Rank = { 30, 32, 44 };
    };
    DISPEL = 
    {
        Rank = { 8 };
    };
    MARK = 
    {
        Rank = { 1, 1, 10, 20, 30, 40, 50 };
    };
    THORNS = 
    {
        Rank = { 1, 4, 14, 24, 34, 44 };
    };
}
local dragging = false;
local sideDefaults = {Player = {5,-20, 5, -45};Party1 = {0, -5, 0, -30};Party2 = {0, -5, 0, -30};Party3 = {0, -5, 0, -30};Party4 = {0, -5, 0, -30};};
local topDefaults = {Player = {-60,0, -30, 0};Party1 = {-60,15, -30, 15};Party2 = {-60,15, -30, 15};Party3 = {-60,15, -30, 15};Party4 = {-60,15, -30, 15};};

local side = {Player = {5,-20, 5, -45};Party1 = {0, -5, 0, -30};Party2 = {0, -5, 0, -30};Party3 = {0, -5, 0, -30};Party4 = {0, -5, 0, -30};};
local top = {Player = {-60,0, -30, 0};Party1 = {-60,15, -30, 15};Party2 = {-60,15, -30, 15};Party3 = {-60,15, -30, 15};Party4 = {-60,15, -30, 15};};

HB_Click = false;
local HB_Class = "";

function HB_Debug(s)
   if (HB_DEBUG == 1) then
      DEFAULT_CHAT_FRAME:AddMessage(s, 1, 1, 0)
   end
end
function HB_TranslateSpellName(spellname)
    local name = "";
    if( spellname == HB_POWER_WORD_SHIELD) then
        name = "SHIELD";
    elseif( spellname == HB_POWER_WORD_FORTITUDE) then
        name = "FORTITUDE";
    elseif( spellname == HB_DIVINE_SPIRIT) then
        name = "SPIRIT";
    elseif( spellname == HB_SHADOW_PROTECTION) then
        name = "SHADOW";
    elseif( spellname == HB_DISPEL_MAGIC) then
        name = "DISPEL";
    elseif( spellname == HB_MARK_OF_WILD) then
        name = "MARK";
    elseif( spellname == HB_THORNS) then
        name = "THORNS";
    end
    return name;
end
function HB_UnitClass(unit)
    
    local class;
    if UnitClass(unit) == HB_PRIEST then 
        class = HB_PRIEST_CLASS;
    elseif UnitClass(unit) == HB_DRUID then 
        class = HB_DRUID_CLASS;
    elseif UnitClass(unit) == HB_PALADIN then 
        class = HB_PALADIN_CLASS;
    elseif UnitClass(unit) == HB_SHAMAN then 
        class = HB_SHAMAN_CLASS;
    end
    return class
end
function HB_OnLoad()

    HB_Class = HB_UnitClass("player");
    if HB_Config.Enabled and (HB_Class == HB_PRIEST_CLASS  or HB_Class == HB_PALADIN_CLASS  or HB_Class == HB_DRUID_CLASS or HB_Class == HB_SHAMAN_CLASS) then
		this:RegisterEvent("PLAYER_ENTERING_WORLD");
   		this:RegisterEvent("LEARNED_SPELL_IN_TAB");
        this:RegisterEvent( "PARTY_MEMBERS_CHANGED");
        this:RegisterEvent( "VARIABLES_LOADED" );
        this:RegisterEvent("UI_ERROR_MESSAGE");
    end
end

function HB_CheckConfig()
    if( HB_Config.DropForm == nil) then
        HB_Config.DropForm = true;
    end
    if( HB_Config.Tooltip == nil) then
        HB_Config.Tooltip = true;
    end
    if( HB_Config.Movable == nil) then
        HB_Config.Movable = true;
    end    
    if( HB_Config.NotifyChannel == nil) then
        HB_Config.NotifyChannel = "self";
    end
    if( HB_Config.SpellTable[HB_Class].Type == nil) then
        HB_Debug("Checking Type");
        HB_Config.SpellTable[HB_Class].Type = {'SPELL','SPELL','SPELL','SPELL','SPELL','SPELL'};
        for i=0, table.getn(HB_Config.SpellTable[HB_Class].Name) do
            if( HB_IsBandage(HB_Config.SpellTable[HB_Class].Name) == true) then
                HB_Config.SpellTable[HB_Class].Type[i] = 'BANDAGE';
            end
        end
    end
    if( HB_Config.ButtonLocs == nil) then
        if( HB_Config.OnSide) then 
            HB_Config.ButtonLocs = side;
        else
            HB_Config.ButtonLocs = top;
        end
    end
end

function HB_OnEvent(event)
    
    if (event == "LEARNED_SPELL_IN_TAB") then
		HB_SpellSetup();
    elseif (event == "PARTY_MEMBERS_CHANGED") then
        HB_SetParty(true)
    elseif (event == "VARIABLES_LOADED") then
    elseif (event == "BAG_UPDATE") then
        HB_GetBandages();
    elseif ( event == "PLAYER_ENTERING_WORLD") then
		SlashCmdList["HealerButtons"] = HB_Slash;
		SLASH_HealerButtons1 = "/HealerButtons";
		SLASH_HealerButtons2 = "/HB";
        HB_CheckConfig();
        HB_SetEnableDisable();
        HB_SetParty();
        HB_Variables_Loaded = true;
        this:RegisterEvent( "BAG_UPDATE" );
    elseif event == "UI_ERROR_MESSAGE" then
        HB_Debug("ErrorMessage");
        if HB_Class == HB_PRIEST_CLASS or HB_Class == HB_DRUID_CLASS or HB_Class == HB_SHAMAN_CLASS then 
            HB_Debug(arg1);
            if( HB_Click) then
                HB_Debug("Cancel Form");
                HB_CancelForm(arg1);
                HB_Click = false;
            else
                HB_Debug("No Click");
            end
        end
    end
end

function HB_CancelForm(arg1)

    if(string.find(arg1, HB_SHAPESHIFT) ) then
        local buffindex = -1;
        if( HB_Config.DropForm) then 
            if( HB_Class == HB_PRIEST_CLASS) then
                HB_Debug(HB_SHADOWFORM);
                buffindex = HB_BuffIndex(HB_SHADOWFORM);
            elseif( HB_Class == HB_SHAMAN_CLASS) then
                buffindex = HB_BuffIndex(HB_GHOST_WOLF);
            elseif HB_Class == HB_DRUID_CLASS then
                buffindex = HB_BuffIndex(HB_FORMS);
            end
            if( buffindex >= 0 ) then
                msg = nil;
                CancelPlayerBuff(buffindex);
            end
        end
    end

end
function HB_Slash(message)

    local hbArgs = HB_TextParse(message);
    hbArgs[1] = strlower(hbArgs[1]);

    local invalid = nil;

    if (hbArgs[1] == "top") then
        ChatFrame1:AddMessage("Healer Buttons: setting to saved top locations" );
        invalid = ( HB_setConfigSavedTopLocations() == false );

    elseif (hbArgs[1] ==  "side" ) then
        ChatFrame1:AddMessage("Healer Buttons: resetting to side");
        invalid = ( HB_setConfigSavedSideLocations() == false );

    elseif (hbArgs[1] ==  "reset" ) then 
        if ( HB_Config.OnSide ) then
            ChatFrame1:AddMessage("Healer Buttons: resetting buttons to side default locations");
        else 
            ChatFrame1:AddMessage("Healer Buttons: resetting buttons to top default locations");
        end
        invalid = ( HB_resetConfigSavedLocation() == false );

    elseif (hbArgs[1] == "lock") then
        ChatFrame1:AddMessage("Healer Buttons: locking positions");
        HB_setConfigMovable( false );

    elseif (hbArgs[1] == "unlock") then
        ChatFrame1:AddMessage("Healer Buttons: unlocking positions");
        HB_setConfigMovable( true );

    elseif hbArgs[1] == "enable" or hbArgs[1] == "enabled" then 
        ChatFrame1:AddMessage("Healer Buttons: enabling");
        HB_setConfigEnabled( true );

    elseif hbArgs[1] == "disable" or hbArgs[1] == "disabled" then 
        ChatFrame1:AddMessage("Healer Buttons: disabling");
        HB_setConfigEnabled( false );

 
    elseif (hbArgs[1] == "dropform" ) then
        if ( table.getn(hbArgs) > 1) then
            if (strlower(hbArgs[2]) == "disable" or strlower(hbArgs[2]) == "disabled") then
                ChatFrame1:AddMessage("Healer Buttons: disabling dropform");
                HB_SetConfigDropForm( false );
            elseif (strlower(hbArgs[2]) == "enable" or strlower(hbArgs[2]) == "enabled") then
                ChatFrame1:AddMessage("Healer Buttons: enabling dropform");
                HB_SetConfigDropForm( true );
            else
                invalid = true;
            end
        else
            invalid = true;
        end
        
    elseif (hbArgs[1] == "notify" ) then
        if ( table.getn(hbArgs) > 1 ) then
            if (strlower(hbArgs[2]) == "disable" or strlower(hbArgs[2]) == "disabled") then
                ChatFrame1:AddMessage("Healer Buttons: disabling notify messages to channel " .. HB_Config.NotifyChannel );
                HB_SetConfigNotify( false );
            elseif (strlower(hbArgs[2]) == "enable" or strlower(hbArgs[2]) == "enabled") then
                ChatFrame1:AddMessage("Healer Buttons: enabling notify messages to channel " .. HB_Config.NotifyChannel );
                HB_SetConfigNotify( true );
            elseif (strlower(hbArgs[2]) == "raid" or 
                    strlower(hbArgs[2]) == "party" or strlower(hbArgs[2]) == "group" or 
                    strlower(hbArgs[2]) == "self" or 
                    strlower(hbArgs[2]) == "say" ) then
                ChatFrame1:AddMessage("Healer Buttons: changing notify channel to " .. strlower(hbArgs[2]) );
                HB_SetConfigNotifyPsuedoChannel( strlower(hbArgs[2] ));
            else
                -- non-PsuedoChannels are not supported at this time
                ChatFrame1:AddMessage("Healer Buttons: cannot change notify channel to " .. hbArgs[2] .. ".  Notify channels other than raid, party, self, and say are not supported." );
                invalid = true;
            end
        else
            invalid = true;
        end
    elseif (hbArgs[1] == "tooltip") and hbArgs[2] ~= nil and (strlower(hbArgs[2]) == "hide") then 
        HB_Config.Tooltip = false;
    elseif (hbArgs[1] == "tooltip") and hbArgs[2] ~= nil and (strlower(hbArgs[2]) == "show") then 
        HB_Config.Tooltip = true;
    elseif (hbArgs[1] == "tooltip") and table.getn(hbArgs) > 2 and strlower(hbArgs[2]) == "parent"  then
       ChatFrame1:AddMessage("Healer Buttons: changing tool tip parent to " .. strlower(hbArgs[3]) );
        if (strlower(hbArgs[3]) == "default") then
            HB_SetConfigToolTipParent( nil );
        elseif (strlower(hbArgs[3]) == "button1" or strlower(hbArgs[3]) == "button2" or strlower(hbArgs[3]) == "world") then
            HB_SetConfigToolTipParent( strlower(hbArgs[3]) );
        else
            HB_SetConfigToolTipParent( hbArgs[3] );
        end           
    elseif (hbArgs[1] == "tooltip") and table.getn(hbArgs) > 2 and strlower(hbArgs[2]) == "anchor" then
       ChatFrame1:AddMessage("Healer Buttons: changing tool tip parent to " .. strlower(hbArgs[3]) );
        if (strlower(hbArgs[3]) == "default") then
            HB_SetConfigToolTipAnchor( nil );
        else
            HB_SetConfigToolTipAnchor( hbArgs[3] );
        end             
    elseif (hbArgs[1] == "info") then
        HB_showInfo();        
    else
        local setOk = HB_setConfigSpell( hbArgs );
        if ( setOk == false ) then
            invalid = true;
        end
    end
    
    if ( invalid ) then
        ChatFrame1:AddMessage("Unknown command: "..message );
        HB_showHelp();
    end
end
function HB_setConfigSpell( hbArgs ) 
    local index = HB_GetIndex(hbArgs[1]);
    if( index > 0 ) then
        local spellname = HB_SpellName(hbArgs);
        HB_Config.SpellTable[HB_Class].Name[index] = spellname;
        if( HB_IsBandage(spellname) == true ) then
            HB_Config.SpellTable[HB_Class].Type[index] = 'BANDAGE';
        else
            HB_Config.SpellTable[HB_Class].Type[index] = 'SPELL';
        end
        HB_SpellSetup();
        return true;
    end
    return false;
end



function HB_showHelp()
        ChatFrame1:AddMessage("Healer Buttons /hb commands:");
        ChatFrame1:AddMessage("info -      Shows the current configuration");
        ChatFrame1:AddMessage("top -       Moves buttons to the top of the frame");
        ChatFrame1:AddMessage("side -      Moves buttons to the Side of the frame");
        ChatFrame1:AddMessage("enable -    Enables the addon");
        ChatFrame1:AddMessage("disable -   Disables and hides the addon");
        ChatFrame1:AddMessage("dropform enable/disable  - Automatically drop out of shapeshifted forms to cast ");
        ChatFrame1:AddMessage("Bnc spellname  - Where n is 1 or 2 and c is r, l, or m. changes the button click spells");
        ChatFrame1:AddMessage("For example:");
        ChatFrame1:AddMessage("        B2R Lesser Heal   -  assigns Lesser Heal to the right click of Button2");
        ChatFrame1:AddMessage("        B2R Bandage       -  assigns using the best bandage found to the right click of Button2");
        ChatFrame1:AddMessage("        B2R Linen Bandage -  assigns using a Linen Bandage to the right click of Button2");
        ChatFrame1:AddMessage("");
        ChatFrame1:AddMessage("tooltip parent <value> - Specify where tooltips are shown");
        ChatFrame1:AddMessage("    where <value> is one of: default, button1, button2, world, or a UI component name");
        ChatFrame1:AddMessage("tooltip anchor <value> - Specify how tooltips are anchored to their parent");
        ChatFrame1:AddMessage("    where <value> is one of: default (aka ANCHOR_CURSOR),");
        ChatFrame1:AddMessage("            ANCHOR_TOPLEFT, ANCHOR_TOP, ANCHOR_TOPRIGHT,  " );
        ChatFrame1:AddMessage("            ANCHOR_LEFT,  ANCHOR_NONE, ANCHOR_RIGHT,  " );
        ChatFrame1:AddMessage("            ANCHOR_BOTTOMLEFT, ANCHOR_BOTTOM, ANCHOR_BOTTOMRIGHT");
        ChatFrame1:AddMessage("tooltip hide - keeps the tooltip from displaying");
        ChatFrame1:AddMessage("tooltip show - causes the tooltip to display");
end
function HB_ButtonLoadInfo(index) 
    spellname, spelltocast, spellMaxKnownRank  = HB_GetSpellToCast(index);
    
    if( spelltocast ~= nil) then 
   
        if( HB_Config.SpellTable[HB_Class].Type[index] == 'SPELL') then 
            -- this is a level ranked spell
            local castbyname = false;
            local newspellname;
            if( HB_Levels[HB_TranslateSpellName(spellname)] ) then
                castbyname = true;
                newspellname = HB_GetRankedSpellName(spellname, spellMaxKnownRank);
            else
                newspellname = spellname;
            end
            if( newspellname ~= nil) then
                if( castbyname == true) then
                    return "Spell '" .. newspellname .. "'";
                else
                    return "Spell '" .. spelltocast .. "'";
                end
            else
                return "Spell '" .. spellname .. "'";
            end
        else
            local bandagename = HB_Config.SpellTable[HB_Class].Name[index];
            if(HB_Config.SpellTable[HB_Class].Name[index] == 'Bandage' or HB_Config.SpellTable[HB_Class].Name[index] == 'bandage') then
                bandagename = HB_GetBestBandage();
            end
            bandage = HB_BANDAGE_INFO[bandagename];
            return "Bandage '" .. bandagename .. "' " .. " bag=" .. bandage.Bag .. " slot=" .. bandage.Slot;
        end
    end
end


function HB_showInfo() 
        ChatFrame1:AddMessage("Healer Buttons current settings:");
        ChatFrame1:AddMessage(" Enabled =    " .. HB_formatBoolean(HB_Config.Enabled) );
        ChatFrame1:AddMessage(" Locked =     " .. HB_formatBoolean(HB_Config.Moveable) );
        ChatFrame1:AddMessage(" OnSide =     " .. HB_formatBoolean(HB_Config.OnSide) );
        ChatFrame1:AddMessage(" DropForm = " .. HB_formatBoolean(HB_Config.DropForm) );
        local channel = HB_Config.NotifyChannel;
        if ( channel == nil ) then
            channel = "default";
        end
        ChatFrame1:AddMessage(" Notify =       " .. HB_formatBoolean(HB_Config.Notify) .. " (Channel " .. channel .. ")" );
        local parent = HB_Config.ToolTipParent;
        if ( parent == nil ) then
            parent = "default";
        end
        local anchor = HB_Config.ToolTipAnchor;
        if ( anchor == nil ) then
            anchor = "default";
        end
        ChatFrame1:AddMessage(" ToolTip At = " .. parent .. " (Anchor " .. anchor  .. ")" );

        ChatFrame1:AddMessage(" Button Locations: " );
        ChatFrame1:AddMessage("   Player:  Button1=(".. HB_formatButton(HB_playerButton1)..
                                        ") Button2=(" .. HB_formatButton(HB_playerButton2)..")" );
        ChatFrame1:AddMessage("   Party 1: Button1=("..HB_formatButton(HB_Party1Button1)..
                                        ") Button2=(" .. HB_formatButton(HB_Party1Button2)..")" );
        ChatFrame1:AddMessage("   Party 2: Button1=("..HB_formatButton(HB_Party2Button1)..
                                        ") Button2=(" .. HB_formatButton(HB_Party2Button2)..")" );
        ChatFrame1:AddMessage("   Party 3: Button1=("..HB_formatButton(HB_Party3Button1)..
                                        ") Button2=(" .. HB_formatButton(HB_Party3Button2)..")" );
        ChatFrame1:AddMessage("   Party 4: Button1=("..HB_formatButton(HB_Party4Button1)..
                                        ") Button2=(" .. HB_formatButton(HB_Party4Button2)..")" );
        
        ChatFrame1:AddMessage(" Button Settings (Class " .. HB_Class .. ")" );
        ChatFrame1:AddMessage("   Right Button    (b1r)   = " .. HB_GetSpellToCast(1) .. "   [" .. HB_ButtonLoadInfo(1) .. "]" );
        ChatFrame1:AddMessage("   Middle Button  (b1m)  = " .. HB_GetSpellToCast(2) .. "   [" .. HB_ButtonLoadInfo(2) .. "]" );
        ChatFrame1:AddMessage("   Left Button      (b1l)   = " .. HB_GetSpellToCast(3) .. "   [" .. HB_ButtonLoadInfo(3) .. "]" );
        ChatFrame1:AddMessage("   Right Button    (b2r)   = " .. HB_GetSpellToCast(4) .. "   [" .. HB_ButtonLoadInfo(4) .. "]" );
        ChatFrame1:AddMessage("   Middle Button  (b2m) = " .. HB_GetSpellToCast(5) .. "   [" .. HB_ButtonLoadInfo(5) .. "]" );
        ChatFrame1:AddMessage("   Left Button       (b2l)  = " .. HB_GetSpellToCast(6) .. "   [" .. HB_ButtonLoadInfo(6) .. "]" );
end
function HB_formatButton(button) 
   if ( button == nil ) then
      return "nil";
   end
   local name, x, y = HB_Points(button,button:GetName());
   local visible=button:IsVisible();
   return string.format("x=%d, y=%d visible=%s", x, y, HB_formatBoolean(visible));
end

function HB_formatBoolean(bool)
   if ( bool == nil ) then
     return "nil";
   elseif ( bool ) then
     return "true";
   else
     return "false";
   end
   return "unknown";
end

function HB_setConfigSavedTopLocations( )         
    HB_Config.OnSide = false;
    HB_Config.ButtonLocs = top;
    HB_SetParty();
end

function HB_setConfigSavedSideLocations( )         
    HB_Config.OnSide = true;
    HB_Config.ButtonLocs = side;
    HB_SetParty();
end

function HB_resetConfigSavedLocation( )         
   local fromWhich = nil;
   if ( HB_Config.OnSide ) then
       fromWhich = sideDefaults;
   else 
       fromWhich = topDefaults;
   end
   -- cannot just set the ButtonLocs = fromWhich, these are object and we must update the contents.
   for i=1,4 do
       HB_Config.ButtonLocs.Player[i] = fromWhich.Player[i];
       for j=1,4 do
           local party = "Party"..j;
           HB_Config.ButtonLocs[party][i] = fromWhich[party][i];
       end
   end
   HB_SetParty();
end

function HB_setConfigMovable( makeEnabled )         
   HB_Config.Movable = makeEnabled;
end

function HB_setConfigEnabled( makeEnabled )         
   HB_Config.Enabled = makeEnabled;
   HB_SetEnableDisable();
end

function HB_SetConfigDropForm( makeEnabled )         
    HB_Config.DropForm = makeEnabled;
end    

function HB_SetConfigNotify( makeEnabled )         
    HB_Config.Notify = makeEnabled;
end    

function HB_SetConfigNotifyPsuedoChannel( psuedoChannel )         
    HB_Config.NotifyChannel = psuedoChannel;
end     

function HB_SetConfigToolTipParent( newParent ) 
    HB_Config.ToolTipParent = newParent;
end

function HB_SetConfigToolTipAnchor( newAnchor ) 
    HB_Config.ToolTipAnchor = newAnchor;
end



function HB_IsBandage(name)

    if( name == 'Bandage' or name == 'bandage' or HB_BANDAGE_INFO[name] ~= nil) then 
        return true;
    else
        return false;
    end
end
function HB_GetIndex(code, button, click)
    local index = -1;
    if code == "b1r"  or ( button == 1 and click == "RightButton") then    
        index = 1;
    elseif code == "b1m" or ( button == 1 and click == "MiddleButton") then
        index = 2;
    elseif code == "b1l" or ( button == 1 and click == "LeftButton") then
        index = 3;
    elseif code == "b2r" or ( button == 2 and click == "RightButton") then
        index = 4;
    elseif code == "b2m" or ( button == 2 and click == "MiddleButton") then
        index = 5;
    elseif code == "b2l" or ( button == 2 and click == "LeftButton") then
        index = 6;
    end
    return index;
end

function HB_SpellName(msg)

    local words = table.getn(msg);
    local spellname = '';
    for i = 2, words do
        if( i == words) then
            spellname = spellname..msg[i];
        else
            spellname = spellname..msg[i].." ";
        end
    end
    return spellname;
end


function HB_BuffIndex(buffname)
    local i = 0;
    HB_Debug(buffname)
    local index = GetPlayerBuff(i);
    while not ( index == -1) do        
        for j=1,table.getn(buffname) do
            HB_Debug("Buff: "..buffname[j]);
            HB_Debug("Texture: "..GetPlayerBuffTexture(i));
            if (string.find(strlower(GetPlayerBuffTexture(i)), strlower(buffname[j]))) then 
                return index;
            end
        end
        i = i + 1;
        index = GetPlayerBuff(i);
    end
    return -1;
end

function HB_SetEnableDisable()
    if HB_Config.Enabled then 
        HB_playerButton1:Show();
        HB_playerButton2:Show();
        HB_GetBandages();
        HB_SpellSetup();
    else
        HB_playerButton1:Hide();
        HB_playerButton2:Hide();
    end
end

function HB_MakeTooltip(button, btype, anchor)
    HB_Debug(" Tooltip =    " .. HB_formatBoolean(HB_Config.Tooltip) );


    if( HB_Config.Tooltip ) then 
        GameTooltip:SetOwner(button, anchor);
        GameTooltip:AddLine("Mouse Clicks Cast");
        local spellname;
        if( btype == 1 ) then
            GameTooltip:AddLine("Right Click: "..HB_GetSpellToCast(1));
            GameTooltip:AddLine("Middle Click: "..HB_GetSpellToCast(2));
            GameTooltip:AddLine("Left Click: "..HB_GetSpellToCast(3));
        else 
            GameTooltip:AddLine("Right Click: "..HB_GetSpellToCast(4));
            GameTooltip:AddLine("Middle Click: "..HB_GetSpellToCast(5));
            GameTooltip:AddLine("Left Click: "..HB_GetSpellToCast(6));
        end
        GameTooltip:Show();
    end
end
function HB_GetSpellToCast(index)
    HB_Debug("Casting: "..index.."-"..HB_Config.SpellTable[HB_Class].Name[index]);
    if HB_Class == HB_DRUID_CLASS then
        if HB_Config.SpellTable[HB_Class].ID[7] ~= nil and HB_Config.SpellTable[HB_Class].Name[index] == 'Cure Poison' then
            DEFAULT_CHAT_FRAME:AddMessage("Replacing Cure Poison with Abolish Poison" , .5, 1, 0)
            return HB_Config.SpellTable[HB_Class].Name[7], HB_Config.SpellTable[HB_Class].ID[7], 0;
        else
            return HB_Config.SpellTable[HB_Class].Name[index], 
                   HB_Config.SpellTable[HB_Class].ID[index],
                   HB_Config.SpellTable[HB_Class].Rank[index];
        end
    else
        return HB_Config.SpellTable[HB_Class].Name[index], 
               HB_Config.SpellTable[HB_Class].ID[index],
               HB_Config.SpellTable[HB_Class].Rank[index];
    end
end

function HB_Cast(member, button, click)

    local TargetName;
    HB_Click = true;
    local spelltocast;
    local spellname;
    local spellMaxKnownRank;
    local index = 0;
    index = HB_GetIndex('',button, click);
    spellname, spelltocast, spellMaxKnownRank = HB_GetSpellToCast(index);
    HB_Debug(spellname);
    HB_Debug(spelltocast);
    HB_Debug(spellMaxKnownRank);
    if( spelltocast ~= nil and spelltocast > 0) then 
    
        if( member == 0 ) then
            TargetName = UnitName("Player");
        elseif (member >0 and member < 5) then
            TargetName = UnitName("party"..member);
        end
        TargetByName(TargetName);
        
        if( HB_Config.SpellTable[HB_Class].Type[index] == 'SPELL') then 
            -- this is a level ranked spell
            local castbyname = false;
            local newspellname;
            if( HB_Levels[HB_TranslateSpellName(spellname)] ) then
                castbyname = true;
                newspellname = HB_GetRankedSpellName(spellname,spellMaxKnownRank);
            else
                newspellname = spellname;
            end
            if( newspellname ~= nil) then
               HB_SendChatMessage("Casting "..newspellname.." on "..TargetName);
                if( castbyname == true) then
                    CastSpellByName(newspellname, "spell")
                else
                    CastSpell(spelltocast,"spell");
                end
                if( SpellIsTargeting() ) then
                    SpellStopTargeting();
                    HB_SendChatMessage(TargetName.." is out of Range.");
                end 
            else
                HB_SendChatMessage("Cannot cast "..spellname.." on "..TargetName..".  "..TargetName.." is too low a level.");        
            end
        else
            local bandagename = HB_Config.SpellTable[HB_Class].Name[index];
            if(HB_Config.SpellTable[HB_Class].Name[index] == 'Bandage' or HB_Config.SpellTable[HB_Class].Name[index] == 'bandage') then
                bandagename = HB_GetBestBandage();
            end
            HB_Bandage(HB_BANDAGE_INFO[bandagename]);
        end
        TargetLastTarget();   
    end
end

function HB_GetBestBandage()
    if( HB_BANDAGE_INFO[HB_BANDAGE.HeavyRunecloth].OnHand > 0 ) then
        return HB_BANDAGE.HeavyRunecloth;
    elseif( HB_BANDAGE_INFO[HB_BANDAGE.Runecloth].OnHand > 0 ) then
        return HB_BANDAGE.Runecloth;
    elseif( HB_BANDAGE_INFO[HB_BANDAGE.HeavyMageweave].OnHand > 0 ) then 
        return HB_BANDAGE.HeavyMageweave;
    elseif( HB_BANDAGE_INFO[HB_BANDAGE.Mageweave].OnHand > 0 )  then
        return HB_BANDAGE.Mageweave;
    elseif( HB_BANDAGE_INFO[HB_BANDAGE.HeavySilk].OnHand > 0 )  then
        return HB_BANDAGE.HeavySilk;
    elseif( HB_BANDAGE_INFO[HB_BANDAGE.Silk].OnHand > 0 )  then
        return HB_BANDAGE.Silk;
    elseif( HB_BANDAGE_INFO[HB_BANDAGE.HeavyWool].OnHand > 0 )  then
        return HB_BANDAGE.HeavyWool;
    elseif( HB_BANDAGE_INFO[HB_BANDAGE.Wool].OnHand > 0 )  then
        return HB_BANDAGE.Wool;
    elseif( HB_BANDAGE_INFO[HB_BANDAGE.HeavyLinen].OnHand > 0 ) then 
        return HB_BANDAGE.HeavyLinen;
    elseif( HB_BANDAGE_INFO[HB_BANDAGE.Linen].OnHand > 0 )  then
        return HB_BANDAGE.Linen;
    else return "NONE";
    end
end
function HB_SendChatMessage(message)

   if ( HB_Config.Notify ) then
       if ( HB_Config.NotifyChannel == "raid" ) then
          if( UnitInRaid("player") == true) then 
              SendChatMessage(message, "raid");
          elseif( UnitInParty("player") == true or UnitName("party1") ~= nil) then 
              SendChatMessage(message, "party");
          else
              DEFAULT_CHAT_FRAME:AddMessage(message);
          end
       elseif ( HB_Config.NotifyChannel == "party" or HB_Config.NotifyChannel == "group" ) then
          if( UnitInParty("player") == true or UnitName("party1") ~= nil) then 
              SendChatMessage(message, "party");
          else
              DEFAULT_CHAT_FRAME:AddMessage(message);
          end
       elseif ( HB_Config.NotifyChannel == "self" ) then
          DEFAULT_CHAT_FRAME:AddMessage(message);
       elseif ( HB_Config.NotifyChannel == "say" or HB_Config.NotifyChannel == nil ) then
           SendChatMessage(message);
       else
           SendChatMessage(message, HB_Config.NotifyChannel);
       end
    end
end

function HB_GetRankedSpellName(spellname,spellMaxKnownRank)
    local castbyname = true;
    local newspellname;
    local targetlevel =  UnitLevel("target");
    local ranks = {};
    if( HB_Levels[HB_TranslateSpellName(spellname)] ~= nil 
       and HB_Levels[HB_TranslateSpellName(spellname)].Rank ~= nil) then
        ranks = HB_Levels[HB_TranslateSpellName(spellname)].Rank;
    end

    local limit = table.getn(ranks);
    local found = false;
    local useRank = 0;
    if( targetlevel >= ranks[limit] and limit <= spellMaxKnownRank ) then
        useRank = limit;
    else
        -- example: 1=1, ... 8=48, 9=54, 10=60
        for rank=spellMaxKnownRank, 1, -1 do
            if ( targetlevel < ranks[rank] ) then
               -- too high for target
            else
               useRank = rank;
               found = true;
               break;
            end
        end
    end
    -- if cant tell rank, just use name (WoW will use highest known by default)
    if ( useRank > 0 ) then
        newspellname = spellname.."("..HB_RANK.." "..(useRank)..")";
    end
    return newspellname;
end

function HB_SetParty()

    local PartyCount = GetNumPartyMembers();
    if( HB_Config.Enabled ) then
        if ( PartyCount > 0) then 
            for i=1,PartyCount do
                local party = "Party"..i;
                button1 =  getglobal( 'HB_Party'..i..'Button1' );
                button2 = getglobal( 'HB_Party'..i..'Button2' );
                HB_Points(button1, button1:GetName());
                HB_Debug(string.format("Config: %d, %d", HB_Config.ButtonLocs[party][1], HB_Config.ButtonLocs[party][2]));
                button1:SetPoint("TOPLEFT", "PartyMemberFrame"..i, "TOPRIGHT", HB_Config.ButtonLocs[party][1], HB_Config.ButtonLocs[party][2]);
                button2:SetPoint("TOPLEFT", "PartyMemberFrame"..i, "TOPRIGHT", HB_Config.ButtonLocs[party][3], HB_Config.ButtonLocs[party][4]);
                button1:Show();
                button2:Show();
            end    
        end
        HB_playerButton1:SetPoint("TOPLEFT", "PlayerFrame", "TOPRIGHT", HB_Config.ButtonLocs["Player"][1], HB_Config.ButtonLocs["Player"][2]);
        HB_playerButton2:SetPoint("TOPLEFT", "PlayerFrame", "TOPRIGHT", HB_Config.ButtonLocs["Player"][3], HB_Config.ButtonLocs["Player"][4]);
    else
        PartyCount = 0;
    end
    
    if( PartyCount < 4) then 
        for i = PartyCount+1, 4 do
            getglobal( 'HB_Party'..i..'Button1' ):Hide();
            getglobal( 'HB_Party'..i..'Button2' ):Hide();
        end
    end
end


function HB_SpellSetup()
    
    local CurrentSpells = {
        ID = {},
        Name = {},
        subName = {},
    };
    HB_Debug( "Init CurrentSpells by searching for type=" .. BOOKTYPE_SPELL );
    
    local spellID = 1;
    while true do
        -- Get all the spells in the book

        local spellName, subSpellName = GetSpellName(spellID, BOOKTYPE_SPELL);
        if not spellName then
            HB_Debug( "SpellID = " .. spellID .. " not found.  Ending search" );
            do break end
        end
        
        if (spellName) then
            if (string.find(subSpellName, HB_RANK)) then
                local found = false;
                local rank = tonumber(strsub(subSpellName, 6, strlen(subSpellName)));                
                for index=1, table.getn(CurrentSpells.Name), 1 do
                    if (CurrentSpells.Name[index] == spellName) then                                                
                        found = true;
                        if (CurrentSpells.subName[index] < rank) then       
                            CurrentSpells.ID[index] = spellID;
                            CurrentSpells.subName[index] = rank;
                        end
                        break;
                    end
                end
                if (not found) then       
                    table.insert(CurrentSpells.ID, spellID);
                    table.insert(CurrentSpells.Name, spellName);
                    table.insert(CurrentSpells.subName, rank);
                end
            else
                table.insert(CurrentSpells.ID, spellID);
                table.insert(CurrentSpells.Name, spellName);
                table.insert(CurrentSpells.subName, 0);
            end
        else
            HB_Debug( "SpellID = " .. spellID .. " has a nil spellName, ignoring" );
        end
        spellID = spellID + 1;
    end
    
    -- Put the spells in the spell table
    local desiredSpellTable = HB_Config.SpellTable[HB_Class];
    HB_Debug("updating desired spells table for class " .. HB_Class );
    for spell=1, table.getn(desiredSpellTable.Name), 1 do
        if( desiredSpellTable.Type[spell] == 'SPELL' ) then
            local limit = table.getn(CurrentSpells.Name);
            local isfound = false;
            for index=limit, 1, -1 do
                local curname = CurrentSpells.Name[index];
                local tabname = desiredSpellTable.Name[spell];
                if  curname == tabname then
                    HB_Debug(string.format("Index: %d    Desired spell: %s matched to %s", spell, desiredSpellTable.Name[spell], CurrentSpells.Name[index]));
                    desiredSpellTable.ID[spell] = CurrentSpells.ID[index];
                    desiredSpellTable.Rank[spell] = CurrentSpells.subName[index];
                    
                    isfound = true;
                end
            end
            if isfound == false then
                HB_Debug(string.format("Index: %d     Desired spell: %s is NOT matched.  Setting to 0", spell, desiredSpellTable.Name[spell]));
                desiredSpellTable.ID[spell] = 0;
                desiredSpellTable.Rank[spell] = 0;
            end        
        end
    end
end

function HB_Bandage(bandage)
    if( bandage ~= nil) then
        UseContainerItem( bandage.Bag, bandage.Slot );
    end
end

function HB_GetBandages( )
    local bag, slot, itemLink, itemName;
    local bandageBag = -1;
    local bandageSlot = -1;
    local healTotal = -1;

    for bag=0,4 do
        for slot=1,GetContainerNumSlots(bag) do
            itemLink = GetContainerItemLink( bag, slot );
            if ( itemLink ) then
                local _, itemCount = GetContainerItemInfo(bag, slot);
                _,_,itemName = strfind( itemLink, "%[(.*)%]" );
                if ( itemName and HB_BANDAGE_INFO[itemName]) then
                    HB_Debug("Bandage: "..itemName);
                    HB_BANDAGE_INFO[itemName].OnHand = itemCount;
                    HB_BANDAGE_INFO[itemName].Bag = bag;
                    HB_BANDAGE_INFO[itemName].Slot = slot;
                end
            end
        end
    end
end
function HB_OnDragStart(button)
    HB_Debug("Dragging");
    if (HB_Config.Movable) then
        button:StartMoving();
	else
        button:StopMovingOrSizing();
	end
end

function HB_Points(button, name)
    local y = button:GetTop();
    local x = button:GetLeft();

        if( strfind(name, "Party1") ) then
            name = "Party1";
            y = y - PartyMemberFrame1:GetTop();
            x = x -PartyMemberFrame1:GetRight() - 1;
        elseif( strfind(name, "Party2") ) then
            name = "Party2";
            y = y-PartyMemberFrame2:GetTop();
            x = x - PartyMemberFrame2:GetRight()  - 1;
        elseif( strfind(name, "Party3") ) then
            name = "Party3";
            y = y - PartyMemberFrame3:GetTop();
            x = x -PartyMemberFrame3:GetRight() - 1;
        elseif( strfind(name, "Party4") ) then
            name = "Party4";
            y = y - PartyMemberFrame4:GetTop();
            x = x -PartyMemberFrame4:GetRight() - 1;
        else
            name = "Player";
            y = y - PlayerFrame:GetTop();
            x = x - PlayerFrame:GetRight() - 1;
        end
        HB_Debug(string.format("%s: %d, %d", name, x, y));
        return name, x, y;
end

function HB_OnDragStop(button)
    HB_Debug("done Dragging");
    local name = button:GetName();
    local x;
    local y;
    local height = button:GetHeight();
    local offset = 0
    button:StopMovingOrSizing();
    if( strfind(name, "Button1") ) then
        offset = 0;
    else
        offset = 2;
    end
    name, x, y = HB_Points(button, name);
    
    HB_Config.ButtonLocs[name][offset + 1] = x;
    HB_Config.ButtonLocs[name][offset + 2] = y;
end
function HB_TextParse(InputString)
-- By FERNANDO!

-- This function should take a string and return a table with each word from the string in
-- each entry. IE, "Linoleum is teh awesome" returns {"Linoleum", "is", "teh", "awesome"}
--
-- Some good should come of this, I've been avoiding writing a text parser for a while, and
-- I need one I understand completely. ^_^
--
-- If you want to gank this function and use it for whatever, feel free. Just give me props
-- somewhere. This function, as far as I can tell, is fairly foolproof. It's hard to get it
-- to screw up. It's also completely self-contained. Just cut and paste.


   local Text = InputString;
   local TextLength = 1;
   local OutputTable = {};
   local OTIndex = 1;
   local StartAt = 1;
   local StopAt = 1;
   local TextStart = 1;
   local TextStop = 1;
   local TextRemaining = 1;
   local NextSpace = 1;
   local Chunk = "";
   local Iterations = 1;
   local EarlyError = false;

   if ((Text ~= nil) and (Text ~= "")) then
   -- ... Yeah. I'm not even going to begin without checking to make sure Im not getting
   -- invalid data. The big ol crashes I got with my color functions taught me that. ^_^

      -- First, it's time to strip out any extra spaces, ie any more than ONE space at a time.
      while (string.find(Text, "  ") ~= nil) do
         Text = string.gsub(Text, "  ", " ");
      end

      -- Now, what if text consisted of only spaces, for some ungodly reason? Well...
      if (string.len(Text) <= 1) then
         EarlyError = true;
      end

      -- Now, if there is a leading or trailing space, we nix them.
      if EarlyError ~= true then
        TextStart = 1;
        TextStop = string.len(Text);

        if (string.sub(Text, TextStart, TextStart) == " ") then
           TextStart = TextStart+1;
        end

        if (string.sub(Text, TextStop, TextStop) == " ") then
           TextStop = TextStop-1;
        end

        Text = string.sub(Text, TextStart, TextStop);
      end

      -- Finally, on to breaking up the goddamn string.

      OTIndex = 1;
      TextRemaining = string.len(Text);

      while (StartAt <= TextRemaining) and (EarlyError ~= true) do

         -- NextSpace is the index of the next space in the string...
         NextSpace = string.find(Text, " ",StartAt);
         -- if there isn't another space, then StopAt is the length of the rest of the
         -- string, otherwise it's just before the next space...
         if (NextSpace ~= nil) then
            StopAt = (NextSpace - 1);
         else
            StopAt = string.len(Text);
            LetsEnd = true;
         end

         Chunk = string.sub(Text, StartAt, StopAt);
         OutputTable[OTIndex] = Chunk;
         OTIndex = OTIndex + 1;

         StartAt = StopAt + 2;

      end
   else
      OutputTable[1] = "Error: Bad value passed to HB_TextParse!";
   end

   if (EarlyError ~= true) then
      return OutputTable;
   else
      return {"Error: Bad value passed to HB_TextParse!"};
   end
end

