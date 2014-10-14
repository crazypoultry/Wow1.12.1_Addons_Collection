local RAID_MEMBERS = 20

local names = {"Adan", "Edain", "Adorn", "Aduial", "Aear", "Aearon", "Aer", "Aerlinn", "Aglar", "Aglarni", "Aglarond", "Aiglin", "Aiglos", "Alfirin", "Alph", "Amarth", "Amlaith", "Ammen", "Amon", "Amroth", "Amrun", "Anann", "Anborn", "Ancalagon", "Andaith", "Andrast", "Andros", "Anduin", "Anfalas", "Ang", "Angband", "Angbor", "Angerthas", "Angmar", "Angren", "Angrenost", "Anim", "Annthennath", "Annon", "Annuminas", "Annun", "Anor", "Anorien", "Arador", "Araglas", "Aragorn", "Aragost", "Arahad", "Arahael", "Aran", "Aranarth", "Aranuir", "Araphant", "Araphor", "Arassuil", "Arathorn", "Araval", "Aravir", "Aravorn", "Araw", "Argeleb", "Argonath", "Argonui", "Arnen", "Arnor", "Arth", "Arthedain", "Arvedui", "Arvegil", "Arveleg", "Arvenienn", "Arwen", "Asfaloth", "Athelas", "Athrad", "Aur", "Balan", "Balchoth", "Balrog", "Barad", "Barahir", "Baran", "Baranduin", "Baranor", "Bas", "Bel", "Belain", "Belecthor", "Beleg", "Belegorn", "Belegost", "Beleriand", "Beleth", "Belfalas", "Benadar", "Beraid", "Beregond", "Beren", "Bereth", "Bergil", "Berhael", "Beruthiel", "Beth", "Bladorthin", "Borgil", "Boromir", "Brandir", "Bregalad", "Brethil", "Bruinen", "Cair", "Calad", "Calan", "Calar", "Calembel", "Calen", "Calenardhon", "Calenhad", "Carach", "Caradhras", "Caran", "Caras", "Carchost", "Cardolan", "Carn", "Carnen", "Celair", "Celduin", "Celeb", "Celebdil", "Celeborn", "Celebrant", "Celebrian", "Celebrimbor", "Celebrindal", "Celebrindor", "Celepharn", "Celeirdan", "Celerdancelos", "Cerin", "Certh", "Certhas", "Cerveth", "Chaered", "Chebin", "Chost", "Cir", "Cirdan", "Ciril", "Cirith", "Cirth", "Conin", "Cor", "Cormallen", "Craban", "Crebain", "Cuio", "Curunir", "Deadelos", "Daer", "Daeron", "Dagor", "Dagorlad", "Damrod", "Dain", "Dan", "Daro", "Daur", "Degil", "Denethor", "Derufin", "Dervorin", "Din", "Dinen", "Dinguruthos", "Dior", "Dir", "Dirhael", "Diriel", "Dol", "Dor", "Dorenernil", "Doriath", "Dorthonion", "Dorwinion", "Druadan", "Druwaith", "Duath", "Duhirion", "Duilin", "Duin", "Duinhir", "Dum", "Dun", "Dunadan", "Dunedain", "Durthang", "Echant", "Echor", "Echuir", "Ecthelion", "Edain", "Edhel", "Edhellen", "Edhellond", "Edhil", "Edraith", "Edro", "Egalmoth", "Egladil", "Eglerio", "Eithel", "Elanor", "Elbereth", "Elenath", "Elin", "Elladan", "Elmoth", "Elrohir", "Elrond", "Elros", "Elwing", "Emyn", "Enedhwaith", "Enedwaith", "Ennor", "Ennorath", "Ennyn", "Enyd", "Ephel", "Eradan", "Erain", "Erebor", "Ered", "Eredluin", "Eregion", "Erelas", "Erestor", "Eriador", "Ernil", "Erui", "Eryd", "Erynesgalduin", "Esgaroth", "Estel", "Ethir", "Ethring", "Ethuil", "Falas", "Fan", "Fang", "Fangorn", "Fanghorn", "Fanui", "Fanuidhol", "Fanuilos", "Felagund", "Fenn", "Fennas", "Fimbrethil", "Finarfin", "Findegil", "Finduilas", "Fing", "Finglas", "Fingolfin", "Finrod", "Firith", "Fladrif", "Forlindon", "Forlond", "Formost", "Forochel", "Forod", "Forodwaith", "Foron", "Fuin", "Galad", "Galadh", "Galdhon", "Galadhremmen", "Galadhrim", "Galadon", "Galadriel", "Galadrim", "Galathilion", "Galdor", "Galen", "Galenas", "Galion", "Gaur", "Gaurhoth", "Gebir", "Geleb", "Gelin", "Gil", "Gildor", "Gilgalad", "Giliath", "Gilion", "Gilraen", "Gilrain", "Gilthoniel", "Girion", "Girithron", "Glamdring", "Glanduinglorfindel", "Glos", "Golasgil", "Gond", "Gondobar", "Gondolin", "Gondor", "Gonui", "Gorgor", "Gorgoroth", "Gorthad", "Govannen", "Guldur", "Gundabad", "Guruthos", "Gwae", "Gwaeron", "Gwai", "Gwaihir", "Gwain", "Gwanur", "Gwath", "Gwathlo", "Gwirith", "Hador", "Hael", "Hain", "Hal", "Halbarad", "Haldir", "Hallas", "Han", "Harad", "Haradrim", "Haradwaith", "Harlondon", "Harlond", "Harnen", "Harondor", "Haudh", "Hen", "Henneth", "Herion", "Hin", "Hir", "Hirgon", "Hiriath", "Hirluin", "Hith", "Hithaiglin", "Hithlain", "Hithoel", "Hithuihollen", "Horn", "Hoth", "Huor", "Huorn", "Hurin", "Iarwain", "Iath", "Iaur", "Iavas", "Idril", "Imlad", "Imladris", "Imloth", "Inglorien", "Ioreth", "Iorlas", "Ithil", "Ithildrin", "Ithilien", "Ivanneth", "Ivorwen", "Kelos", "Kiril", "Kirith", "Laer", "Lain", "Lam", "Lamedon", "Lammen", "Landroval", "Las", "Lasgalen", "Lasto", "Lebennin", "Lebethron", "Lefnui", "Legolas", "Lembas", "Lhaw", "Lhun", "Lim", "Linn", "Lindir", "Linhir", "Linnathon", "Linnod", "Lith", "Lithui", "Lithlad", "Lond", "Lor", "Lorien", "Loss", "Lossarnach", "Lossen", "Lossoth", "Loth", "Lothiriel", "Lothlorien", "Lothron", "Luin", "Luthien", "Lyg", "Mablung", "Mae", "Magor", "Mal", "Malbeth", "Mallen", "Mallor", "Mallorn", "Mellryn", "Mallos", "Malvegil", "Marmedui", "Megil", "Melian", "Mellon", "Mellryn", "Melui", "Menel", "Meneldor", "Menelvagor", "Mereth", "Merethrond", "Methed", "Methedras", "Min", "Minas", "Mindolluin", "Minhiriath", "Minmo", "Minrimmon", "Minuial", "Mir", "Miriel", "Miruvor", "Mith", "Mitheithel", "Mithlond", "Mithrandir", "Mithren", "Mithrin", "Mithril", "Mor", "Morannon", "Mordor", "Morgai", "Morgoth", "Morgul", "Morgulduin", "Moria", "Morn", "Morthond", "Morwen", "Muil", "Nachaered", "Naith", "Nallon", "Nan", "Nanduhirion", "Nantasarion", "Nar", "Narbeleth", "Narchost", "Nardol", "Nargothrond", "Narwain", "Naug", "Naugrim", "Naur", "Ndaedelos", "Nef", "Neldor", "Neldoreth", "Nen", "Nenuial", "Ngaurhoth", "Nguruthos", "Nim", "Nimbrethil", "Nimloth", "Nimrais", "Nimrodel", "Nin", "Nondalf", "Ninui", "Niphredil", "Nogothrim", "Nogrod", "Noro", "Norui", "Nurn", "Nurnen", "Onen", "Onod", "Onodrim", "Oraeron", "Oranor", "Orbelain", "Orch", "Orcrist", "Orgaladh", "Orgaladhad", "Orgilion", "Orithil", "Ormenel", "Orod", "Orodnathon", "Orodreth", "Orodruin", "Orophin", "Orthanc", "Osgiliath", "Ossir", "Ossiriand", "Palan", "Palandiriel", "Pant", "Parth", "Pedo", "Pel", "Pelargir", "Pelen", "Pelennor", "Peleth", "Penna", "Per", "Peredhel", "Perhael", "Periainn", "Periann", "Periannath", "Pheriain", "Pheriannath", "Pinn", "Pinnath", "Poros", "Rais", "Rammas", "Randir", "Rant", "Rass", "Rathrauros", "Raw", "Remm", "Remmen", "Remmirath", "Ren", "Rhiw", "Rhosgobel", "Rhovanion", "Rhu", "Rhudaur", "Riel", "Ril", "Rim", "Rin", "Ring", "Ringlo", "Roch", "Rochand", "Rochann", "Rodyn", "Rant", "Rass", "Rath", "Rohan", "Roheryn", "Rohir", "Rohirrim", "Rond", "Rumil", "Samm", "Sammath", "Sarn", "Sarnathrad", "Sauron", "Serni", "Sernui", "Silivren", "Sir", "Sirannon", "Sirith", "Suil", "Sul", "Taith", "Talan", "Talf", "Targon", "Tarlang", "Tasar", "Tasarinan", "Taur", "Taurnaneldor", "Teithant", "Telchar", "Tew", "Thangorodrim", "Tharbad", "Thingol", "Thiw", "Thon", "Thond", "Thoniel", "Thoron", "Thorondir", "Thorondor", "Thorongil", "Til", "Tin", "Tinuviel", "Tir", "Tiriel", "Tirith", "Tiro", "Tiw", "Tolbrandir", "Tolfalas", "Torech", "Torn", "Torog", "Tumladen", "Tuor", "Tur", "Turgon", "Tyrn", "Uchebin", "Udun", "Uial", "Uilos", "Ungol", "Ungoliant", "Urui", "Vagor", "Vedui", "Vegil", "Veleg", "Vir", "Vorn", "Wain", "Waith", "Yrch"}

local raid = {}

for i=1,RAID_MEMBERS do
    raid["raid"..i] = {}
end

local classes = {
    [1] = {"Warrior", "WARRIOR",1},
    [2] = {"Priest", "PRIEST",0},
    [3] = {"Hunter", "HUNTER",0},
    [4] = {"Druid", "DRUID",0},
    [5] = {"Paladin", "PALADIN",0},
    [6] = {"Warlock", "WARLOCK",0},
    [7] = {"Mage", "MAGE",0},
    [8] = {"Shaman", "SHAMAN",0},
    [9] = {"Rogue", "ROGUE",3},
}

local funcs = {
    "GetNumRaidMembers",
    "GetRaidRosterInfo",
    "UnitClass",
    "UnitName",
    "UnitHealth",
    "UnitMana",
    "UnitHealthMax",
    "UnitManaMax",
    "UnitIsGhost",
    "UnitIsDead",
    "UnitIsConnected",
    "UnitPowerType",
    "UnitExists",
}

local orig = {}

RaidSimulation = {}

function RaidSimulation.UnitName(unit)
    if not raid[unit] then return orig.UnitName(unit) end
    if not raid[unit].name then
        raid[unit].name = names[math.random(table.getn(names))]
    end
    return raid[unit].name
end

function RaidSimulation.GetNumRaidMembers()
    return RAID_MEMBERS
end

function RaidSimulation.UnitClass(unit)
    if not raid[unit] then return orig.UnitClass(unit) end
    if not raid[unit].class then
        raid[unit].class = math.random(9)
    end
    
    local class = raid[unit].class
    local power = classes[class][3]
    
    return classes[class][1], classes[class][2]
end

function RaidSimulation.UnitPowerType(unit)
    if not raid[unit] then return orig.UnitPowerType(unit) end
    if not raid[unit].class then
        local class = UnitClass(unit)
    end
    
    return classes[raid[unit].class][3]
end

function RaidSimulation.UnitHealth(unit)
    if not raid[unit] then return orig.UnitHealth(unit) end
    return math.random(UnitHealthMax(unit))
end

function RaidSimulation.UnitHealthMax(unit)
    if not raid[unit] then return orig.UnitHealthMax(unit) end
    if not raid[unit].healthmax then
        raid[unit].healthmax = math.random(5000) + 200
    end
    
    return raid[unit].healthmax
end

function RaidSimulation.UnitMana(unit)
    if not raid[unit] then return orig.UnitMana(unit) end
    
    return math.random(UnitManaMax(unit))
end

function RaidSimulation.UnitManaMax(unit)
    if not raid[unit] then return orig.UnitManaMax(unit) end
    if not raid[unit].manamax then
        raid[unit].manamax = math.random(5000) + 200
    end
    
    return raid[unit].manamax
end

function RaidSimulation.UnitIsDead(unit)
    if not raid[unit] then return orig.UnitIsDead(unit) end
    return nil
end

function RaidSimulation.UnitIsGhost(unit)
    if not raid[unit] then return orig.UnitIsGhost(unit) end
    return nil
end

function RaidSimulation.UnitIsConnected(unit)
    if not raid[unit] then return orig.UnitIsConnected(unit) end
    return true
end

function RaidSimulation.UnitExists(unit)
    if not raid[unit] then return orig.UnitExists(unit) end
    return true
end

--name, rank, subgroup, level, class, fileName, zone, online, isDead = GetRaidRosterInfo(raidIndex);

function RaidSimulation.GetRaidRosterInfo(index)
    local unit = "raid"..index
    local u = raid[unit]
    
    if not u.name then UnitName(unit) end
    if not u.rank then u.rank = nil end
    if not u.group then u.group = math.random(8) end
    if not u.level then u.level = math.random(50) + 10 end
    if not u.class then UnitClass(unit) end
    
    return u.name, u.rank, u.group, u.level, classes[u.class][1], classes[u.class][2]
end

function RaidSimulation:Start()
    local g = getfenv(0)

    for idx,fname in ipairs(funcs) do
        if self[fname] then
            orig[fname] = g[fname]
            g[fname] = self[fname]
        end
    end
end

function RaidSimulation:Stop()
    local g = getfenv(0)

    for idx,fname in ipairs(funcs) do
        if orig[fname] then
            g[fname] = orig[fname]
        end
    end
end