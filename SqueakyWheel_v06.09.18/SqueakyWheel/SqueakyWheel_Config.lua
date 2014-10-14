-- /squeak reset is needed to load defaults after modifying this file.

SqueakyConfigDefaults = {
version = "20060918",

-- display mode
-- show SqueakyWheel when solo (true or false)
displaySolo = false,
-- show SqueakyWheel in party (true or false)
displayParty = true,
-- show SqueakyWheel in raid (true or false)
displayRaid = true,
-- show pets in SqueakyWheel (true or false)
displayPets = false,
-- replace CT_RA Emergency Monitor with SqueakyWheel (true or false)
displayEmergency = true,

-- lock the main window
lock = false,

-- show all health bars, not just injured
showAll = true,

-- number of health bars (2 to 15)
healthBars = 10,

-- number of seconds until health bar is grey (1 to 30)
deltaMax = 10,

-- % health 1 second is worth in squeak (1 to 20)
-- Default settings means no activity = 10*6% = 60% health
deltaWeight = 6,

-- number of seconds unit remains on blacklist (0 to 10)
blacklistDuration = 3,

-- spacing between health bars (0 to 10)
barSpacing = 0,

-- width of health bars (10 to 300)
barWidth = 150,

-- height of health bars (6 to 30)
barHeight = 12,

-- minimum health threshold before squeaky (0.5 to 1, default 90% health)
minHealth = .9,

-- use Extra priorities?
priority = true,

-- Aggro is Squeaky (equivalent to this % health)
priorityAggro = 50,

-- Extra priority compared to typical raid members (additive, 0 to 1)
prioritySELF = .2, -- You are 10% more important
priorityPARTY = .2, -- Your own Party members are 20% more important
priorityDRUID = .2, -- Druids are 10% more important
priorityHUNTER = 0, -- Hunters are 0% more important
priorityMAGE = 0, -- Mages are 10% more important
priorityPRIEST = .2, -- Priests are 10% more important
priorityPALADIN = 0, -- Paladins are 0% more important
priorityROGUE = 0, -- Rogues are 0% more important
prioritySHAMAN = 0, -- Shaman are 0% more important
priorityWARLOCK = 0, -- Warlocks are 0% more important
priorityWARRIOR = 0, -- Warriors are 0% more important (they usually benefit from priorityAggro)
priorityPET = 0, -- Pets are 0% more important
priorityMT = .5, -- CT_RA Main Tanks and Personal Targets are 50% more important

-- Extra priority for full mana bars (additive, 0 to 1)
priorityMana = .1, -- Mana users
priorityRage = .2, -- Rage users
priorityFocus = 0, -- Pet Focus
priorityEnergy = 0, -- Energy users
priorityHappiness = 0, -- Happiness

-- Extra priority based on Group assignments (additive, 0 to 1)
priorityGroups = .5, -- Extra priority amount for checked groups
priorityGroup1 = false, -- Group 1 gets extra priority
priorityGroup2 = false, -- Group 2 gets extra priority
priorityGroup3 = false, -- Group 3 gets extra priority
priorityGroup4 = false, -- Group 4 gets extra priority
priorityGroup5 = false, -- Group 5 gets extra priority
priorityGroup6 = false, -- Group 6 gets extra priority
priorityGroup7 = false, -- Group 7 gets extra priority
priorityGroup8 = false, -- Group 8 gets extra priority

-- frame colors {red, green, blue, alpha}
backdropColor = {.4,.2,.4,.4}, -- Frame background color
backdropBorderColor = {.9,.8,1,1}, --  Frame border color
deadColor = {.8,0,0,1}, -- injured person color
liveColor = {0,.8,0,1}, -- healthy person color
fadeColor = {.6,.6,.6,1}, -- unknown person color
goneColor = {.2,.2,.2,1}, -- out of range person color
textColor = {1,1,1,1}, -- text color

-- class based colors
textClassColor = true, -- use class colors for text
textClassColorIntensity = 1, -- for textClassColor.  0 = black, 1 = full intensity
barClassColor = false, -- use class colors for health bar
barClassColorIntensity = .8, -- for barClassColor.  0 = black, 1 = full intensity

-- set to false to reduce spam
debugMode = false,
}
