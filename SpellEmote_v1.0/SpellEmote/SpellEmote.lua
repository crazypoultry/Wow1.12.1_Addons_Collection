--
-- SpellEmote
-- Version 1.0
-- By Enos Shenk (Emlee of Sentinels, Scarlett of Maelstrom, Sathanas of Khadgar)
--
-- Version 1.0:
-- All emotes are now added, edited, and deleted via slash commands.
-- Completely re-written emote storage
-- Cleaned up lots of sloppy code
--
-- Beta 3:
-- Made the slash command for on/off actually work. Whoops.
-- Added support for multiple text strings per emote.
-- Added character-specific emote lists.
--
-- Beta 2:
-- Seperated emote list into 3 categories, Damage, Heal and Buff.
-- Added heshe, hishers, himher, spelltarget variables for the text field.
-- 
-- Beta 1:
-- Initial build
--


function SpellEmote_OnLoad()
	this:RegisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_SELF_BUFF");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS");
    DEFAULT_CHAT_FRAME:AddMessage("SpellEmote Loading");
    SLASH_SPELLEMOTE1 = "/spellemote";
    SlashCmdList["SPELLEMOTE"] = SpellEmote_Command;
    if (SpellEmoteEnable == nil) then SpellEmoteEnable = 1; end
    if (SpellEmote_EmoteList_Damage == nil) then SpellEmote_EmoteList_Damage = {}; end
    if (SpellEmote_EmoteList_Heal == nil) then SpellEmote_EmoteList_Heal = {}; end
    if (SpellEmote_EmoteList_Buff == nil) then SpellEmote_EmoteList_Buff = {}; end	
end

function SpellEmote_Command(cmd)
    if (cmd) then
        if (cmd == "off") then
            SpellEmoteEnable = 0;  
            DEFAULT_CHAT_FRAME:AddMessage("SpellEmote emotes are now OFF",1,.9,0);         
        elseif (cmd == "on") then
            SpellEmoteEnable = 1;
            DEFAULT_CHAT_FRAME:AddMessage("SpellEmote emotes are now ON",1,.9,0);
        elseif (string.sub(cmd, 1, 3) == "add") then
            SpellEmote_Command_Add(cmd);
        elseif (string.sub(cmd, 1, 4) == "view") then
            SpellEmote_Command_View(cmd);
        elseif (string.sub(cmd, 1, 6) == "delete") then
            SpellEmote_Command_Delete(cmd);
        elseif (string.sub(cmd, 1, 4) == "edit") then
            SpellEmote_Command_Edit(cmd);
        else
            DEFAULT_CHAT_FRAME:AddMessage("SpellEmote Commands:",1,.9,0);
            DEFAULT_CHAT_FRAME:AddMessage("Refer to the help file in the SpellEmote directory for detailed help and examples",1,.9,0);            
            DEFAULT_CHAT_FRAME:AddMessage("/spellemote add (required parameters) spell='Spell Name' spelltype='damage/heal/buff' text='Emote text' emotetype='say/emote' chance='0-100' (optional parameters) crit='yes/no'",1,.9,0);
            DEFAULT_CHAT_FRAME:AddMessage("/spellemote edit (required parameters) spell='Spell Name' spelltype='damage/heal/buff' (optional parameters) text='Emote text' emotetype='say/emote' chance='0-100'",1,.9,0);
            DEFAULT_CHAT_FRAME:AddMessage("/spellemote view spell='all/damage/heal/buff/Spell Name'",1,.9,0);
            DEFAULT_CHAT_FRAME:AddMessage("/spellemote delete spell='Spell Name' spelltype='damage/heal/buff'",1,.9,0);
            DEFAULT_CHAT_FRAME:AddMessage("/spellemote on - Turns emotes on",1,.9,0);            
            DEFAULT_CHAT_FRAME:AddMessage("/spellemote on - Turns emotes on",1,.9,0);
            DEFAULT_CHAT_FRAME:AddMessage("/spellemote off - Turns emotes off",1,.9,0);
        end        
    end
end

function SpellEmote_Command_Add(cmd)   -- Spell add handler, parameters are: Spell, Text, Chance, EmoteType, SpellType, (Optional) Crit, (Optional) Restrict
    local spellName, spellText, spellChance, emoteType, spellType, spellCrit, spellRestrict;
    for thing1 in string.gfind(cmd, "spell='(.-)'") do
        spellName = thing1;
    end
    for thing2 in string.gfind(cmd, "text='(.-)'") do
        spellText = thing2;
    end
    for thing3 in string.gfind(cmd, "chance='(.-)'") do
        spellChance = tonumber(thing3);
    end
    for thing4 in string.gfind(cmd, "emotetype='(.-)'") do
        emoteType = thing4;
    end
    for thing5 in string.gfind(cmd, "spelltype='(.-)'") do
        spellType = thing5;
    end
    for thing6 in string.gfind(cmd, "crit='(.-)'") do
        spellCrit = thing6;
    end
    if (spellName == nil) then
        DEFAULT_CHAT_FRAME:AddMessage("Error: Missing required parameter Spell",1,0,0);
    end       
    if (spellText == nil) then
        DEFAULT_CHAT_FRAME:AddMessage("Error: Missing required parameter Text",1,0,0);
    end       
    if (spellChance == nil) then
        DEFAULT_CHAT_FRAME:AddMessage("Error: Missing required parameter Chance",1,0,0);
    end
    if (emoteType == nil) then
        DEFAULT_CHAT_FRAME:AddMessage("Error: Missing required parameter EmoteType",1,0,0);
    end
    if (spellType == nil) then
        DEFAULT_CHAT_FRAME:AddMessage("Error: Missing required parameter SpellType",1,0,0);
    end  
    if (spellName ~= nil) and (spellText ~= nil) and (spellChance ~= nil) and (emoteType ~= nil) and (spellType ~= nil) then   -- All our ducks are in a row, lets do it.
            if (strlower(emoteType) == "say") or (strlower(emoteType) == "emote") then      -- Check and see if type is valid
                if (strlower(spellType) == "damage") or (strlower(spellType) == "heal") or (strlower(spellType) == "buff") then
                    if (strlower(spellType) == "damage") then
                        if (SpellEmote_EmoteList_Damage[spellName]) then DEFAULT_CHAT_FRAME:AddMessage("An emote for that spell name already exists, please use /spellemote delete to delete it, or /spellemote edit to edit it.",1,0,0); else
                            pureSpellName = spellName;
                            if (spellCrit == "yes") then
                                spellName = spellName.." Critical";
                            end
                            SpellEmote_EmoteList_Damage[spellName] = {};
                            if (spellChance < 0) then spellChance = 0; end
                            if (spellChance > 100) then spellChance = 100; end
                            SpellEmote_EmoteList_Damage[spellName]["Chance"] = spellChance;
                            SpellEmote_EmoteList_Damage[spellName]["Type"] = emoteType;
                            SpellEmote_EmoteList_Damage[spellName]["Text"] = spellText;
                            SpellEmote_AddMessage("Added emote for spell "..pureSpellName);
                        end                    
                    elseif (strlower(spellType) == "heal") then
                        if (SpellEmote_EmoteList_Heal[spellName]) then DEFAULT_CHAT_FRAME:AddMessage("An emote for that spell name already exists, please use /spellemote delete to delete it, or /spellemote edit to edit it.",1,0,0); else
                            pureSpellName = spellName;
                            if (spellCrit == "yes") then
                                spellName = spellName.." Critical";
                            end
                            SpellEmote_EmoteList_Heal[spellName] = {};
                            if (spellChance < 0) then spellChance = 0; end
                            if (spellChance > 100) then spellChance = 100; end
                            SpellEmote_EmoteList_Heal[spellName]["Chance"] = spellChance;
                            SpellEmote_EmoteList_Heal[spellName]["Type"] = emoteType;
                            SpellEmote_EmoteList_Heal[spellName]["Text"] = spellText;
                            SpellEmote_AddMessage("Added emote for spell "..pureSpellName);
                        end                       
                    elseif (strlower(spellType) == "buff") then
                        if (SpellEmote_EmoteList_Buff[spellName]) then DEFAULT_CHAT_FRAME:AddMessage("An emote for that spell name already exists, please use /spellemote delete to delete it, or /spellemote edit to edit it.",1,0,0); else
                            pureSpellName = spellName;
                            SpellEmote_EmoteList_Buff[spellName] = {};
                            if (spellChance < 0) then spellChance = 0; end
                            if (spellChance > 100) then spellChance = 100; end
                            SpellEmote_EmoteList_Buff[spellName]["Chance"] = spellChance;
                            SpellEmote_EmoteList_Buff[spellName]["Type"] = emoteType;
                            SpellEmote_EmoteList_Buff[spellName]["Text"] = spellText; 
                            SpellEmote_AddMessage("Added emote for spell "..pureSpellName);
                        end                      
                    end
                end
            end
        end          
end

function SpellEmote_Command_Edit(cmd)  
    local spellName, spellText, spellChance, emoteType, spellType, spellCrit, spellRestrict;
    for thing1 in string.gfind(cmd, "spell='(.-)'") do
        spellName = thing1;
    end
    for thing2 in string.gfind(cmd, "text='(.-)'") do
        spellText = thing2;
    end
    for thing3 in string.gfind(cmd, "chance='(.-)'") do
        spellChance = tonumber(thing3);
    end
    for thing4 in string.gfind(cmd, "emotetype='(.-)'") do
        emoteType = thing4;
    end
    for thing5 in string.gfind(cmd, "spelltype='(.-)'") do
        spellType = thing5;
    end
    if (spellName == nil) then
        DEFAULT_CHAT_FRAME:AddMessage("Error: Missing required parameter spell",1,0,0);
    end  
    if (spellType == nil) then
        DEFAULT_CHAT_FRAME:AddMessage("Error: Missing required parameter spelltype",1,0,0);
    end  
    if (spellName ~= nil) and (spellType ~= nil) then 
        if (strlower(spellType) == "damage") then
            if (SpellEmote_EmoteList_Damage[spellName]) then
                if (spellText) then
                    SpellEmote_EmoteList_Damage[spellName]["Text"] = spellText;
                    SpellEmote_AddMessage("Changed text for emote "..spellName.." to "..spellText);
                end
                if (spellChance) then
                    if (spellChance < 0) then spellChance = 0; end
                    if (spellChance > 100) then spellChance = 100; end
                    SpellEmote_EmoteList_Damage[spellName]["Chance"] = spellChance;
                    SpellEmote_AddMessage("Changed chance for emote "..spellName.." to "..spellChance.."%");
                end
                if (emoteType) then
                    SpellEmote_EmoteList_Damage[spellName]["Type"] = emoteType;
                    SpellEmote_AddMessage("Changed emote type for emote "..spellName.." to "..emoteType);   
                end
            else
                SpellEmote_AddMessage("Unable to locate an emote matching "..spell..", perhaps you should use /spellemote view to locate the proper name");
            end
        elseif (strlower(spellType) == "heal") then
            if (SpellEmote_EmoteList_Heal[spellName]) then
                if (spellText) then
                    SpellEmote_EmoteList_Heal[spellName]["Text"] = spellText;
                    SpellEmote_AddMessage("Changed text for emote "..spellName.." to "..spellText);
                end
                if (spellChance) then
                    if (spellChance < 0) then spellChance = 0; end
                    if (spellChance > 100) then spellChance = 100; end
                    SpellEmote_EmoteList_Heal[spellName]["Chance"] = spellChance;
                    SpellEmote_AddMessage("Changed chance for emote "..spellName.." to "..spellChance.."%");
                end
                if (emoteType) then
                    SpellEmote_EmoteList_Heal[spellName]["Type"] = emoteType;
                    SpellEmote_AddMessage("Changed emote type for emote "..spellName.." to "..emoteType);   
                end
            else
                SpellEmote_AddMessage("Unable to locate an emote matching "..spell..", perhaps you should use /spellemote view to locate the proper name");
            end        
        elseif (strlower(spellType) == "buff") then
            if (SpellEmote_EmoteList_Buff[spellName]) then
                if (spellText) then
                    SpellEmote_EmoteList_Buff[spellName]["Text"] = spellText;
                    SpellEmote_AddMessage("Changed text for emote "..spellName.." to "..spellText);
                end
                if (spellChance) then
                    if (spellChance < 0) then spellChance = 0; end
                    if (spellChance > 100) then spellChance = 100; end
                    SpellEmote_EmoteList_Buff[spellName]["Chance"] = spellChance;
                    SpellEmote_AddMessage("Changed chance for emote "..spellName.." to "..spellChance.."%");
                end
                if (emoteType) then
                    SpellEmote_EmoteList_Buff[spellName]["Type"] = emoteType;
                    SpellEmote_AddMessage("Changed emote type for emote "..spellName.." to "..emoteType);   
                end
            else
                SpellEmote_AddMessage("Unable to locate an emote matching "..spell..", perhaps you should use /spellemote view to locate the proper name");
            end        
        end
    end         
end

function SpellEmote_Command_View(cmd)
    local findRange;
    for thing1 in string.gfind(cmd, "spell='(.-)'") do
        findRange = thing1;
    end
    if (findRange == "all") then      -- Print all active emotes to the chat window
        DEFAULT_CHAT_FRAME:AddMessage("Damage spell emotes:",1,.9,0);
        table.foreach(SpellEmote_EmoteList_Damage,SpellEmote_AddMessage); 
        DEFAULT_CHAT_FRAME:AddMessage("Heal spell emotes:",1,.9,0);
        table.foreach(SpellEmote_EmoteList_Heal,SpellEmote_AddMessage);
        DEFAULT_CHAT_FRAME:AddMessage("Buff spell emotes:",1,.9,0);
        table.foreach(SpellEmote_EmoteList_Buff,SpellEmote_AddMessage);      
    elseif (findRange == "damage") then   -- Print all damage emotes
        DEFAULT_CHAT_FRAME:AddMessage("Damage spell emotes:",1,.9,0);
        table.foreach(SpellEmote_EmoteList_Damage,SpellEmote_AddMessage);   
    elseif (findRange == "heal") then     -- Print all heal emotes
        DEFAULT_CHAT_FRAME:AddMessage("Heal spell emotes:",1,.9,0);
        table.foreach(SpellEmote_EmoteList_Heal,SpellEmote_AddMessage);       
    elseif (findRange == "buff") then     -- Print all heal emotes
        DEFAULT_CHAT_FRAME:AddMessage("Buff spell emotes:",1,.9,0);
        table.foreach(SpellEmote_EmoteList_Buff,SpellEmote_AddMessage);       
    else                            -- Print a specific emotes settings
        local foundAnythingYet;
        if (SpellEmote_EmoteList_Damage[findRange]) then
            SpellEmote_AddMessage("Located "..findRange.." in the Damage Spells emote list:");
            local chance = tonumber(SpellEmote_EmoteList_Damage[findRange]["Chance"]);
            local commType = SpellEmote_EmoteList_Damage[findRange]["Type"];
            local text = SpellEmote_EmoteList_Damage[findRange]["Text"]; 
            SpellEmote_AddMessage("  -Spell name: "..findRange);
            SpellEmote_AddMessage("  -Emote Text: "..text);
            SpellEmote_AddMessage("  -Emote Type: "..commType);
            SpellEmote_AddMessage("  -Emote Chance: "..chance);
            foundAnythingYet=1;
        end
        if (SpellEmote_EmoteList_Heal[findRange]) then
            SpellEmote_AddMessage("Located "..findRange.." in the Heal Spells emote list:");
            local chance = tonumber(SpellEmote_EmoteList_Heal[findRange]["Chance"]);
            local commType = SpellEmote_EmoteList_Heal[findRange]["Type"];
            local text = SpellEmote_EmoteList_Heal[findRange]["Text"]; 
            SpellEmote_AddMessage("  -Spell name: "..findRange);
            SpellEmote_AddMessage("  -Emote Text: "..text);
            SpellEmote_AddMessage("  -Emote Type: "..commType);
            SpellEmote_AddMessage("  -Emote Chance: "..chance);
            foundAnythingYet=1;        
        end
        if (SpellEmote_EmoteList_Buff[findRange]) then
            SpellEmote_AddMessage("Located "..findRange.." in the Buff Spells emote list:");
            local chance = tonumber(SpellEmote_EmoteList_Buff[findRange]["Chance"]);
            local commType = SpellEmote_EmoteList_Buff[findRange]["Type"];
            local text = SpellEmote_EmoteList_Buff[findRange]["Text"]; 
            SpellEmote_AddMessage("  -Spell name: "..findRange);
            SpellEmote_AddMessage("  -Emote Text: "..text);
            SpellEmote_AddMessage("  -Emote Type: "..commType);
            SpellEmote_AddMessage("  -Emote Chance: "..chance);
            foundAnythingYet=1;        
        end
        if (foundAnythingYet == nil) then SpellEmote_AddMessage("Unable to find any emotes matching "..findRange.."...Sorry!"); end                      
    end
end

function SpellEmote_Command_Delete(cmd)
    local spell;
    for thing1 in string.gfind(cmd, "spell='(.-)'") do
        spell = thing1;
    end
    for thing1 in string.gfind(cmd, "spelltype='(.-)'") do
        spellType = thing1;
    end
    if (spellType) then
    if (strlower(spellType) == "damage") or (strlower(spellType) == "heal") or (strlower(spellType) == "buff") then     -- Player has called out a specific type spell, lets axe it
        if (strlower(spellType) == "damage") then
            if (SpellEmote_EmoteList_Damage[spell]) then
                SpellEmote_EmoteList_Damage[spell] = nil;
                SpellEmote_AddMessage("Deleted emote for spell "..spell);
            else
                SpellEmote_AddMessage("Unable to locate an emote matching "..spell..", perhaps you should use /spellemote view to locate the proper name"); 
            end
        elseif (strlower(spellType) == "heal") then
            if (SpellEmote_EmoteList_Heal[spell]) then
                SpellEmote_EmoteList_Heal[spell] = nil;
                SpellEmote_AddMessage("Deleted emote for spell "..spell);
            else
                SpellEmote_AddMessage("Unable to locate an emote matching "..spell..", perhaps you should use /spellemote view to locate the proper name"); 
            end        
        elseif (strlower(spellType) == "buff") then
            if (SpellEmote_EmoteList_Buff[spell]) then
                SpellEmote_EmoteList_Buff[spell] = nil;
                SpellEmote_AddMessage("Deleted emote for spell "..spell);
            else
                SpellEmote_AddMessage("Unable to locate an emote matching "..spell..", perhaps you should use /spellemote view to locate the proper name"); 
            end        
        end
       end 
    else                    -- Player didnt specify a spell type, check and see if the same spell exists in more than one table
        local found = 0;
        if (SpellEmote_EmoteList_Damage[spell]) then
            found = found + 1;
            spellType = "Damage";
        end    
        if (SpellEmote_EmoteList_Heal[spell]) then
            found = found + 1;
            spellType = "Heal";
        end   
        if (SpellEmote_EmoteList_Buff[spell]) then
            found = found + 1;
            spellType = "Buff";
        end 
        if (found == 0) then 
            SpellEmote_AddMessage("Unable to locate an emote matching "..spell..", perhaps you should use /spellemote view to locate the proper name"); 
        end
        if (found > 1) then 
            SpellEmote_AddMessage("Found emote named "..spell.." in more than one spell type, use /spellemote delete spell='spellname' spelltype='damage/heal/buff' to specify which one to delete."); 
        end
        if (found == 1) then
        if (strlower(spellType) == "damage") then
            if (SpellEmote_EmoteList_Damage[spell]) then
                SpellEmote_EmoteList_Damage[spell] = nil;
                SpellEmote_AddMessage("Deleted emote for spell "..spell);
            else
                SpellEmote_AddMessage("Unable to locate an emote matching "..spell..", perhaps you should use /spellemote view to locate the proper name"); 
            end
        elseif (strlower(spellType) == "heal") then
            if (SpellEmote_EmoteList_Heal[spell]) then
                SpellEmote_EmoteList_Heal[spell] = nil;
                SpellEmote_AddMessage("Deleted emote for spell "..spell);
            else
                SpellEmote_AddMessage("Unable to locate an emote matching "..spell..", perhaps you should use /spellemote view to locate the proper name"); 
            end        
        elseif (strlower(spellType) == "buff") then
            if (SpellEmote_EmoteList_Buff[spell]) then
                SpellEmote_EmoteList_Buff[spell] = nil;
                SpellEmote_AddMessage("Deleted emote for spell "..spell);
            else
                SpellEmote_AddMessage("Unable to locate an emote matching "..spell..", perhaps you should use /spellemote view to locate the proper name"); 
            end        
        end
        end
    end      
end

function SpellEmote_AddMessage(text)
    if (text == nil) then text="Nil?!"; end
    DEFAULT_CHAT_FRAME:AddMessage(text,1,.9,0);    
end

function SpellEmote_OnEvent(event)
    if (event == "CHAT_MSG_SPELL_SELF_DAMAGE") then
        for spell, creatureName, damage in string.gfind(arg1, "Your (.+) hits (.+) for (%d+).") do
            SpellEmote_Go(spell, 0, 1, creatureName);
        end
        for spell, creatureName, damage in string.gfind(arg1, "Your (.+) crits (.+) for (%d+).") do
            SpellEmote_Go(spell, 1, 1, creatureName);
        end
    elseif (event == "CHAT_MSG_SPELL_SELF_BUFF") then
		for spell, targetName, damage in string.gfind(arg1, "Your (.+) critically heals (.+) for (%d+).") do
            SpellEmote_Go(spell, 1, 2, targetName);
		end
		for spell, targetName, damage in string.gfind(arg1, "Your (.+) heals (.+) for (%d+).") do
            SpellEmote_Go(spell, 0, 2, targetName);
		end    
    elseif (event == "CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS") then
		for spell in string.gfind(arg1, "You gain (.+).") do
            SpellEmote_Go(spell, 0, 3, UnitName("player"));
		end        
    end
end

function SpellEmote_Go(spell, crit, spellType, spellTarget)
    if (SpellEmoteEnable == 1) then
        if (spellType == 1) then    -- Damage spell cast on something
            if (crit == 1) then spell = spell.." Critical"; end      
            if (SpellEmote_EmoteList_Damage[spell]) then
                local chance = tonumber(SpellEmote_EmoteList_Damage[spell]["Chance"]);
                local commType = SpellEmote_EmoteList_Damage[spell]["Type"];
                local text = SpellEmote_EmoteList_Damage[spell]["Text"];                    
                if (chance == nil) or (commType == nil) or (text == nil) then
                    DEFAULT_CHAT_FRAME:AddMessage("SpellEmote: There is an error in your emote syntax for the spell "..spell,1,0,0);
                    return;
                end  
                local roll = math.random(0,100);
                if (roll <= chance) then                         
                    local heshe, hishers, himher, hisher;
                    if (UnitSex("player") == 2) then    -- Player is male
                        heshe = "he";
                        hishers = "his";
                        himher = "him";
                        hisher = "his";
                    elseif (UnitSex("player") == 3) then    -- Player is female
                        heshe = "she";
                        hishers = "hers";
                        himher = "her";
                        hisher = "her";
                    elseif (UnitSex("player") == 1) then    -- Player is...uh...Something else
                        heshe = "it";
                        hishers = "its";
                        himher = "it";
                        hisher = "its";
                    end     
                    text = string.gsub(text, "(heshe)", heshe);   
                    text = string.gsub(text, "(hishers)", hishers); 
                    text = string.gsub(text, "(himher)", hishers); 
                    text = string.gsub(text, "(hisher)", hisher);
                    text = string.gsub(text, "(spelltarget)", spellTarget);
                    if (strlower(commType) == "say") then  
                        SendChatMessage(text, "SAY");                    
                    elseif (strlower(commType) == "emote") then
                        SendChatMessage(text, "EMOTE"); 
                    end           
                end  
            end
        elseif (spellType == 2) then    -- Heal type spell cast on something
            if (crit == 1) then spell = spell.." Critical"; end  
            if (SpellEmote_EmoteList_Heal[spell]) then
                local chance = tonumber(SpellEmote_EmoteList_Heal[spell]["Chance"]);
                local commType = SpellEmote_EmoteList_Heal[spell]["Type"];
                local text = SpellEmote_EmoteList_Heal[spell]["Text"];                    
                if (chance == nil) or (commType == nil) or (text == nil) then
                    DEFAULT_CHAT_FRAME:AddMessage("SpellEmote: There is an error in your emote syntax for the spell "..spell,1,0,0);
                    return;
                end  
                local roll = math.random(0,100);
                if (roll <= chance) then
                    local heshe, hishers, himher, hisher;
                    if (UnitSex("player") == 2) then    -- Player is male
                        heshe = "he";
                        hishers = "his";
                        himher = "him";
                        hisher = "his";
                    elseif (UnitSex("player") == 3) then    -- Player is female
                        heshe = "she";
                        hishers = "hers";
                        himher = "her";
                        hisher = "her";
                    elseif (UnitSex("player") == 1) then    -- Player is...uh...Something else
                        heshe = "it";
                        hishers = "its";
                        himher = "it";
                        hisher = "its";
                    end     
                    text = string.gsub(text, "(heshe)", heshe);   
                    text = string.gsub(text, "(hishers)", hishers); 
                    text = string.gsub(text, "(himher)", hishers); 
                    text = string.gsub(text, "(hisher)", hisher);
                    text = string.gsub(text, "(spelltarget)", spellTarget);
                    if (strlower(commType) == "say") then  
                        SendChatMessage(text, "SAY");                    
                    elseif (strlower(commType) == "emote") then
                        SendChatMessage(text, "EMOTE"); 
                    end           
                end  
            end  
        elseif (spellType == 3) then    -- Gaining a buff or ability   
            if (SpellEmote_EmoteList_Buff[spell]) then
                local chance = tonumber(SpellEmote_EmoteList_Buff[spell]["Chance"]);
                local commType = SpellEmote_EmoteList_Buff[spell]["Type"];
                local text = SpellEmote_EmoteList_Buff[spell]["Text"];                    
                if (chance == nil) or (commType == nil) or (text == nil) then
                    DEFAULT_CHAT_FRAME:AddMessage("SpellEmote: There is an error in your emote syntax for the spell "..spell,1,0,0);
                    return;
                end  
                local roll = math.random(0,100);
                if (roll <= chance) then
                    local heshe, hishers, himher, hisher;
                    if (UnitSex("player") == 2) then    -- Player is male
                        heshe = "he";
                        hishers = "his";
                        himher = "him";
                        hisher = "his";
                    elseif (UnitSex("player") == 3) then    -- Player is female
                        heshe = "she";
                        hishers = "hers";
                        himher = "her";
                        hisher = "her";
                    elseif (UnitSex("player") == 1) then    -- Player is...uh...Something else
                        heshe = "it";
                        hishers = "its";
                        himher = "it";
                        hisher = "its";
                    end     
                    text = string.gsub(text, "(heshe)", heshe);   
                    text = string.gsub(text, "(hishers)", hishers); 
                    text = string.gsub(text, "(himher)", hishers); 
                    text = string.gsub(text, "(hisher)", hisher);
                    text = string.gsub(text, "(spelltarget)", spellTarget);
                    if (strlower(commType) == "say") then  
                        SendChatMessage(text, "SAY");                    
                    elseif (strlower(commType) == "emote") then
                        SendChatMessage(text, "EMOTE"); 
                    end           
                end  
            end 
        end
    end
end