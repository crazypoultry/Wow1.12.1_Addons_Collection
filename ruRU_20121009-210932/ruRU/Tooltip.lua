
local function ruItemType(state)

    local items = {"Dagger", "Fist Weapon", "Mace", "Sword", "Polearm", "Staff", "Bow", "Crossbow", "Gun", "Thrown", "Wand", "Fishing Pole", "Axe", "Cloth", "Leather", "Mail", "Plate"};
    local itemsRU = {"Кинжал", "Кистевое оружие", "Дробящее", "Меч", "Древковое", "Посох", "Лук", "Арбалет", "Огнестрельное", "Метательное", "Жезл", "Удочка", "Топор", "Ткань", "Кожа", "Кольчуга", "Латы"}
        
    local itemType,itemString;
    local function isTypeRu(itm)
        if itm ~= nil then
            for i, item  in ipairs(items) do
                if itm == item then
                    return itemsRU[i];
                end
            end
        end
        return nil;
    end

    local function getRegion()
        local region = nil;
        local num = GameTooltip:NumLines();
        
        if GameTooltip:NumLines() ~= nil then

            for i = 1, GameTooltip:NumLines() do
                if getglobal("GameTooltipTextRight"..i):IsVisible() then
                    region = isTypeRu(getglobal("GameTooltipTextRight"..i):GetText());
                    if region ~= nil then
                        -- Print(isTypeRu(getglobal("GameTooltipTextRight"..i):GetText()).." i = "..i);
                        return "GameTooltipTextRight"..i;
                    end
                end

            end

            for i = 1, GameTooltip:NumLines() do
                if getglobal("GameTooltipTextLeft"..i):IsVisible() then
                    region = isTypeRu(getglobal("GameTooltipTextLeft"..i):GetText());
                    if region ~= nil then
                        -- Print(isTypeRu(getglobal("GameTooltipTextRight"..i):GetText()).." i = "..i);
                        return "GameTooltipTextLeft"..i;
                    end
                end

            end
        end
    end

    if state then
        local iTypeRegion = getRegion();
        if iTypeRegion ~= nil then
            if isTypeRu(getglobal(iTypeRegion):GetText()) == "Жезл" then
                local _,_, istr = string.find(iTypeRegion, "(%d+)");
                getglobal("GameTooltipTextLeft"..istr):SetText("Дальний бой");
                getglobal("GameTooltipTextRight"..istr):SetText("Жезл");
                -- local r1, rel, r2, x, y = getglobal("GameTooltipTextRight4"):GetPoint();
                -- Print("r1 = "..r1);
                -- Print("rel = "..rel:GetName());
                -- Print("r2 = "..r2);
                -- Print("x = "..x);
                -- Print("y = "..y);
                getglobal("GameTooltipTextRight"..istr):SetPoint("RIGHT", GameTooltipTextLeft3, "LEFT", GameTooltip:GetWidth() - 20, 0);
                getglobal("GameTooltipTextRight"..istr):Show();
            else
                getglobal(iTypeRegion):SetText(isTypeRu(getglobal(iTypeRegion):GetText()));
            end
        end
    end
end

local function itemBonus(state)
--     local items = {
--     "Increases"
-- }
end

local function fixStats(state)
    local stats = {
        "(.%d+) Intellect",
        "Intellect (.%d+)",
        "(.%d+) Stamina",
        "Stamina (.%d+)",
        "(.%d+) Spirit",
        "Spirit (.%d+)",
        "(.%d+) Agility",
        "Agility (.%d+)",
        "(.%d+) Strength",
        "Strength (.%d+)",
        "(.%d+) All Resistances(.*)",
        "All Stats (.%d+)",
        "(%d+) Armor(.)",
        "Health (.%d+)",
        ".(%d+) Attack Power(.)",
----
        "Increases damage and healing done by magical spells and effects by up to",
        "Increases healing done by spells and effects by up to",
        "Increases damage done by (%a+) spells and effects by up to (%d+).",
        "Improves your chance to hit by",
        "Improves your chance to hit with spells by",
        "Improves your chance to get a critical strike with spells by ",
        "Restores (.*) mana per (.*) sec%.", 
        "Restores (.*) mana%.",
        "Improves your chance to get a critical strike by",
        "Increases your chance to parry an attack by (%d+.).",
        "Increases your chance to dodge an attack by (%d+.).",
        "Reduces the cooldown of your (.*) ability by (.*) sec.",
----
        "Reinforced Armor (.%d+)",
        "Weapon Damage (.%d+)",
----    
        "Increases the target.s (%a+) by (%d+) for (.*)%.",
        "Heals (%d+) damage over (.*%.)",
----
        -- "Tailoring",
        -- "Engineering",
        -- "Blacksmithing",
        -- "Leatherworking",
        -- "Herbalism",
        -- "Mining",
        -- "Skinning",
----
        "Teaches you how to make.?a?%s(.*)%.",
        "Teaches you how to sew.?a?%s(.*)%.",

    }
    local statsRU = {
        "%1 к интеллекту",
        "%1 к интеллекту",  
        "%1 к выносливости",
        "%1 к выносливости", 
        "%1 к духу",
        "%1 к духу", 
        "%1 к ловкости",
        "%1 к ловкости", 
        "%1 к силе",
        "%1 к силе",
        "%1 ко всем видам сопротивления%2",
        "%1 ко всем характеристикам",
        "%1 к броне",
        "%1 к здоровью",
        "Сила атаки +%1.",
----
        "Увеличивает силу заклинаний на",
        "Увеличивает силу исцеляющих заклинаний на",
        "Увеличивает силу заклинаний магии %1 на %2.",
        "Повышает меткость на",
        "Повышает меткость спеллами на",
        "Шанс критического удара +",
        "Восполнение %1 ед. маны раз в %2 сек.",
        "Восполняет %1 ед. маны.",
        "Повышает рейтинг критического удара на",
        "Увеличивает шанс парирования на %1.",
        "Увеличивает шанс уклонения на %1.",
        "Сокращение времени восстановления способности \"%1\" на %2 сек.",
----
        "Доспех усилен (%1)",
        "%1 к урону оружием",
----
        "Повышает %1 цели на %2 ед. на %3.",
        "Восполнение %1 ед. здоровья в течение %2",
----
        -- "Портняжное дело",
        -- "Инженерное дело",
        -- "Кузнечное дело",
        -- "Кожевничество",
        -- "Травничество",
        -- "Горное дело",
        -- "Снятие шкур",        

----    
        "Обучает изготовлению %1.",
        "Обучает пошиву %1.",


    }

    local function needFixRu(object)
        local st = getglobal(object):GetText();

        if st ~= nil then
            for i, stat  in ipairs(stats) do
                if string.find(st, stat) then
                    getglobal(object):SetText(string.gsub(st, stats[i], statsRU[i]));
                end
            end
        end
    end

    for i = 1, GameTooltip:NumLines() do
        needFixRu("GameTooltipTextLeft"..i);
    end

end  


local frame = CreateFrame("Frame", nil,GameTooltip);
frame:SetScript("OnShow",function()
        ruItemType(true);
        fixStats(true);
    end)
-- frame:SetScript("OnHide",function()
--         addTeleports();
--     end)





-- Кинжал - Dagger
-- Кистевое оружие - Fist Weapon
-- Дробящее - Mace
-- Меч - Sword
-- Древковое - Polearm
-- Посох - Staff
-- Лук - Bow
-- Арбалет - Crossbow
-- Огнестрельное - Gun
-- Метательное - Thrown
-- Жезл - Wand
-- Удочка - Fishing Pole
-- Топор - Axe