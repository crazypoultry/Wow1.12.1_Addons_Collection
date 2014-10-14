local L = AceLibrary("AceLocale-2.1"):GetInstance("MageFu", true)

BINDING_HEADER_MAGEFU = L["BINDING_HEADER_MAGEFU"]
BINDING_NAME_CONJURE = L["BINDING_NAME_CONJURE"]
BINDING_NAME_TRADE = L["BINDING_NAME_TRADE"]
BINDING_NAME_CONSUME = L["BINDING_NAME_CONSUME"]
BINDING_NAME_HEARTHSTONE = L["BINDING_NAME_HEARTHSTONE"]

local opts = {
 type='group',
 args = {
  textoptions = {
   type = 'group',
   name = L["OPT_TEXTOPTIONS_NAME"],
   desc = L["OPT_TEXTOPTIONS_DESC"],
   order = 1,
   args = { 
    text = {
     type = 'text',
     name = L["OPT_TEXT_TEXT_NAME"],
     desc = L["OPT_TEXT_TEXT_DESC"],
     usage = "<some text>",
     get = function() return MageFu.db.profile.text.text end,
     set = function(val) MageFu.db.profile.text.text = val; MageFu:Update() end,
     validate = function(val) return string.len(val) > 0 end,
    },    
   },
  },
  raid = {
   type = 'group',
   name = L["OPT_RAID_NAME"],
   desc = L["OPT_RAID_DESC"],
   order = 9,
   args = {  
    group = {
     type = 'group',
     name = L["OPT_RAID_GROUP_NAME"],
     desc = L["OPT_RAID_GROUP_DESC"],
     order = 10,
     args = { 
      g1 = {
       type = 'toggle',
       name = string.format(L["OPT_RAID_GROUP_SPECIFIC_NAME"],1),
       desc = string.format(L["OPT_RAID_GROUP_SPECIFIC_DESC"],1),
       get = function() return MageFu.db.profile.raid.group[1] end,
       set = function() MageFu.db.profile.raid.group[1] = not MageFu.db.profile.raid.group[1]; MageFu:SendMessage() end, 
       order = 1,
      },  
      g2 = {
       type = 'toggle',
       name = string.format(L["OPT_RAID_GROUP_SPECIFIC_NAME"],2),
       desc = string.format(L["OPT_RAID_GROUP_SPECIFIC_DESC"],2),
       get = function() return MageFu.db.profile.raid.group[2] end,
       set = function() MageFu.db.profile.raid.group[2] = not MageFu.db.profile.raid.group[2]; MageFu:SendMessage() end, 
       order = 2,
      }, 
      g3 = {
       type = 'toggle',
       name = string.format(L["OPT_RAID_GROUP_SPECIFIC_NAME"],3),
       desc = string.format(L["OPT_RAID_GROUP_SPECIFIC_DESC"],3),
       get = function() return MageFu.db.profile.raid.group[3] end,
       set = function() MageFu.db.profile.raid.group[3] = not MageFu.db.profile.raid.group[3]; MageFu:SendMessage() end, 
       order = 3,
      }, 
      g4 = {
       type = 'toggle',
       name = string.format(L["OPT_RAID_GROUP_SPECIFIC_NAME"],4),
       desc = string.format(L["OPT_RAID_GROUP_SPECIFIC_DESC"],4),
       get = function() return MageFu.db.profile.raid.group[4] end,
       set = function() MageFu.db.profile.raid.group[4] = not MageFu.db.profile.raid.group[4]; MageFu:SendMessage() end, 
       order = 4,
      }, 
      g5 = {
       type = 'toggle',
       name = string.format(L["OPT_RAID_GROUP_SPECIFIC_NAME"],5),
       desc = string.format(L["OPT_RAID_GROUP_SPECIFIC_DESC"],5),
       get = function() return MageFu.db.profile.raid.group[5] end,
       set = function() MageFu.db.profile.raid.group[5] = not MageFu.db.profile.raid.group[5]; MageFu:SendMessage() end, 
       order = 5,
      }, 
      g6 = {
       type = 'toggle',
       name = string.format(L["OPT_RAID_GROUP_SPECIFIC_NAME"],6),
       desc = string.format(L["OPT_RAID_GROUP_SPECIFIC_DESC"],6),
       get = function() return MageFu.db.profile.raid.group[6] end,
       set = function() MageFu.db.profile.raid.group[6] = not MageFu.db.profile.raid.group[6]; MageFu:SendMessage() end, 
       order = 6,
      }, 
      g7 = {
       type = 'toggle',
       name = string.format(L["OPT_RAID_GROUP_SPECIFIC_NAME"],7),
       desc = string.format(L["OPT_RAID_GROUP_SPECIFIC_DESC"],7),
       get = function() return MageFu.db.profile.raid.group[7] end,
       set = function() MageFu.db.profile.raid.group[7] = not MageFu.db.profile.raid.group[7]; MageFu:SendMessage() end, 
       order = 7,
      }, 
      g8 = {
       type = 'toggle',
       name = string.format(L["OPT_RAID_GROUP_SPECIFIC_NAME"],8),
       desc = string.format(L["OPT_RAID_GROUP_SPECIFIC_DESC"],8),
       get = function() return MageFu.db.profile.raid.group[8] end,
       set = function() MageFu.db.profile.raid.group[8] = not MageFu.db.profile.raid.group[8]; MageFu:SendMessage() end, 
       order = 8,
      },    
     },
    },
    inraid = {
     type = 'toggle',
     name = L["OPT_RAID_INRAID_NAME"],
     desc = L["OPT_RAID_INRAID_DESC"],
     get = function() return MageFu.db.profile.raid.inRaid end,
     set = function() return end, 
     order = 100,
    },
    displaygroups = {
     type = 'toggle',
     name = L["OPT_RAID_DISPLAYGROUPS_NAME"],
     desc = L["OPT_RAID_DISPLAYGROUPS_DESC"],
     get = function() return MageFu.db.profile.raid.displayGroups end,
     set = function() MageFu.db.profile.raid.displayGroups = not MageFu.db.profile.raid.displayGroups; MageFu:Update() end, 
     order = 1,
    },
    displaybuffs = {
     type = 'toggle',
     name = L["OPT_RAID_DISPLAYBUFFS_NAME"],
     desc = L["OPT_RAID_DISPLAYBUFFS_DESC"],
     get = function() return MageFu.db.profile.raid.displayBuffs end,
     set = function() MageFu.db.profile.raid.displayBuffs = not MageFu.db.profile.raid.displayBuffs; MageFu:Update(); MageFu:UpdateBuffs() end, 
     order = 2,
    },
   },
  },  
  reagent = {
   type = 'group',
   name = L["OPT_REAGENT_NAME"],
   desc = L["OPT_REAGENT_DESC"],
   order = 7,
   args = { 
    arcanepowder = {
     type = 'range',
     name = L["ARCANEPOWDER"],
     desc = string.format(L["OPT_REAGENT_SPECIFIC_DESC"], L["ARCANEPOWDER"]),
     get = function() return MageFu.db.profile.reagent.arcanePowder end,
     set = function(newValue) MageFu.db.profile.reagent.arcanePowder = newValue end,
     min = 0,
     max = 5, 
     step = 1,
     isPercent = false, 
     order = 2,            
    },
    runeofteleportation = {
     type = 'range',
     name = L["RUNEOFTELEPORTATION"],
     desc = string.format(L["OPT_REAGENT_SPECIFIC_DESC"], L["RUNEOFTELEPORTATION"]),
     get = function() return MageFu.db.profile.reagent.runeOfTeleportation end,
     set = function(newValue) MageFu.db.profile.reagent.runeOfTeleportation = newValue end,
     min = 0,
     max = 5, 
     step = 1,
     isPercent = false,    
     order = 3,         
    },        
    runeofportals = {
     type = 'range',
     name = L["RUNEOFPORTALS"],
     desc = string.format(L["OPT_REAGENT_SPECIFIC_DESC"], L["RUNEOFPORTALS"]),
     get = function() return MageFu.db.profile.reagent.runeOfPortals end,
     set = function(newValue) MageFu.db.profile.reagent.runeOfPortals = newValue end,
     min = 0,
     max = 5, 
     step = 1,
     isPercent = false,  
     order = 4,           
    },       
    autobuy = {
     type = 'toggle',
     name = L["OPT_REAGENT_AUTOBUY_NAME"],
     desc = L["OPT_REAGENT_AUTOBUY_DESC"],
     get = function() return MageFu.db.profile.reagent.autoBuy end,
     set = function() MageFu.db.profile.reagent.autoBuy = not MageFu.db.profile.reagent.autoBuy end, 
     order = 1,
    },
   },
  },
  transport = {
   type = 'group',
   name = L["OPT_TRANSPORT_NAME"],
   desc = L["OPT_TRANSPORT_DESC"],
   order = 8,
   args = { 
    teleport = {
     type = 'group',
     name = L["OPT_TRANSPORT_TELEPORT_NAME"],
     desc = L["OPT_TRANSPORT_TELEPORT_DESC"],
     order = 1,
     args = {        
      ironforge = {
       type = 'execute',
       name = L["IRONFORGE"],
       desc = string.format(L["OPT_TRANSPORT_TELEPORT_SPECIFIC_DESC"], L["IRONFORGE"]),
       func = function() MageFu:Teleport(L["IRONFORGE"]) end, 
       order = 1,
       hidden = true,
      },        
      stormwind = {
       type = 'execute',
       name = L["STORMWIND"],
       desc = string.format(L["OPT_TRANSPORT_TELEPORT_SPECIFIC_DESC"], L["STORMWIND"]),
       func = function() MageFu:Teleport(L["STORMWIND"]) end, 
       order = 2,
       hidden = true,
      },        
      darnassus = {
       type = 'execute',
       name = L["DARNASSUS"],
       desc = string.format(L["OPT_TRANSPORT_TELEPORT_SPECIFIC_DESC"], L["DARNASSUS"]),
       func = function() MageFu:Teleport(L["DARNASSUS"]) end, 
       order = 3,
       hidden = true,
      },        
      orgrimmar = {
       type = 'execute',
       name = L["ORGRIMMAR"],
       desc = string.format(L["OPT_TRANSPORT_TELEPORT_SPECIFIC_DESC"], L["ORGRIMMAR"]),
       func = function() MageFu:Teleport(L["ORGRIMMAR"]) end, 
       order = 4,
       hidden = true,
      },        
      thunderbluff = {
       type = 'execute',
       name = L["THUNDERBLUFF"],
       desc = string.format(L["OPT_TRANSPORT_TELEPORT_SPECIFIC_DESC"], L["THUNDERBLUFF"]),
       func = function() MageFu:Teleport(L["THUNDERBLUFF"]) end, 
       order = 5,
       hidden = true,
      },        
      undercity = {
       type = 'execute',
       name = L["UNDERCITY"],
       desc = string.format(L["OPT_TRANSPORT_TELEPORT_SPECIFIC_DESC"], L["UNDERCITY"]),
       func = function() MageFu:Teleport(L["UNDERCITY"]) end, 
       order = 6,
       hidden = true,
      },
      message = {
       type = 'group',
       name = L["OPT_TRANSPORT_TELEPORT_MESSAGE_NAME"],
       desc = L["OPT_TRANSPORT_TELEPORT_MESSAGE_DESC"],
       order = 7,
       args = {  
        add = {
         type = 'text',
         name = L["OPT_TRANSPORT_TELEPORT_MESSAGE_ADD_NAME"],
         desc = L["OPT_TRANSPORT_TELEPORT_MESSAGE_ADD_DESC"],
         usage = "<a message>",
         get = function() return "" end,
         set = function(message) MageFu:AddTeleportMessage(message) end,
         validate = function(message) return string.len(message) > 0 end,
        },       
       },
      },
     },
    },
    portal = {
     type = 'group',
     name = L["OPT_TRANSPORT_PORTAL_NAME"],
     desc = L["OPT_TRANSPORT_PORTAL_DESC"],
     order = 2,
     args = { 
      ironforge = {
       type = 'execute',
       name = L["IRONFORGE"],
       desc = string.format(L["OPT_TRANSPORT_PORTAL_SPECIFIC_DESC"], L["IRONFORGE"]),
       func = function() MageFu:Portal(L["IRONFORGE"]) end, 
       order = 1,
       hidden = true,
      },        
      stormwind = {
       type = 'execute',
       name = L["STORMWIND"],
       desc = string.format(L["OPT_TRANSPORT_PORTAL_SPECIFIC_DESC"], L["STORMWIND"]),
       func = function() MageFu:Portal(L["STORMWIND"]) end, 
       order = 2,
       hidden = true,
      },        
      darnassus = {
       type = 'execute',
       name = L["DARNASSUS"],
       desc = string.format(L["OPT_TRANSPORT_PORTAL_SPECIFIC_DESC"], L["DARNASSUS"]),
       func = function() MageFu:Portal(L["DARNASSUS"]) end, 
       order = 3,
       hidden = true,
      },        
      orgrimmar = {
       type = 'execute',
       name = L["ORGRIMMAR"],
       desc = string.format(L["OPT_TRANSPORT_PORTAL_SPECIFIC_DESC"], L["ORGRIMMAR"]),
       func = function() MageFu:Portal(L["ORGRIMMAR"]) end, 
       order = 4,
       hidden = true,
      },        
      thunderbluff = {
       type = 'execute',
       name = L["THUNDERBLUFF"],
       desc = string.format(L["OPT_TRANSPORT_PORTAL_SPECIFIC_DESC"], L["THUNDERBLUFF"]),
       func = function() MageFu:Portal(L["THUNDERBLUFF"]) end, 
       order = 5,
       hidden = true,
      },        
      undercity = {
       type = 'execute',
       name = L["UNDERCITY"],
       desc = string.format(L["OPT_TRANSPORT_PORTAL_SPECIFIC_DESC"], L["UNDERCITY"]),
       func = function() MageFu:Portal(L["UNDERCITY"]) end, 
       order = 6,
       hidden = true,
      },
      message = {
       type = 'group',
       name = L["OPT_TRANSPORT_PORTAL_MESSAGE_NAME"],
       desc = L["OPT_TRANSPORT_PORTAL_MESSAGE_DESC"],
       order = 7,
       args = {  
        add = {
         type = 'text',
         name = L["OPT_TRANSPORT_PORTAL_MESSAGE_ADD_NAME"],
         desc = L["OPT_TRANSPORT_PORTAL_MESSAGE_ADD_DESC"],
         usage = "<a message>",
         get = function() return "" end,
         set = function(message) MageFu:AddPortalMessage(message) end,
         validate = function(message) return string.len(message) > 0 end,
        },       
       },
      },
     },
    },   
    hearthstone = {
     type = 'toggle',
     name = L["HEARTHSTONE"],
     desc = L["OPT_TRANSPORT_HEARTHSTONE_DESC"],
     get = function() return false end,
     set = function() MageFu:Hearthstone() end, 
     order = 3,
    },    
   },
  },
  conjureoptions = {
   type = 'group',
   name = L["OPT_CONJURE_OPTIONS_NAME"],
   desc = L["OPT_CONJURE_OPTIONS_DESC"],
   order = 2,
   args = { 
    gem = {
     type = 'range',
     name = L["OPT_CONJURE_GEM_NAME"],
     desc = L["OPT_CONJURE_GEM_DESC"],
     get = function() return MageFu.db.profile.conjure.gem end,
     set = function(newValue) MageFu.db.profile.conjure.gem = newValue end,
     min = 0,
     max = 4, 
     step = 1,
     isPercent = false, 
     order = 1,            
    },  
    maxrankgem = {
     type = 'range',
     name = L["OPT_CONJURE_MAXRANKGEM_NAME"],
     desc = L["OPT_CONJURE_MAXRANKGEM_DESC"],
     get = function() return MageFu.db.profile.conjure.maxRankGem end,
     set = function(newValue) MageFu.db.profile.conjure.maxRankGem = newValue end,
     min = 0,
     max = 4, 
     step = 1,
     isPercent = false, 
     order = 1,            
    }, 
    maxrankfood = {
     type = 'range',
     name = L["OPT_CONJURE_MAXRANKFOOD_NAME"],
     desc = L["OPT_CONJURE_MAXRANKFOOD_DESC"],
     get = function() return MageFu.db.profile.conjure.maxRankFood end,
     set = function(newValue) MageFu.db.profile.conjure.maxRankFood = newValue; MageFu:Update() end,
     min = 0,
     max = 7, 
     step = 1,
     isPercent = false, 
     order = 1,            
    }, 
    maxrankwater = {
     type = 'range',
     name = L["OPT_CONJURE_MAXRANKWATER_NAME"],
     desc = L["OPT_CONJURE_MAXRANKWATER_DESC"],
     get = function() return MageFu.db.profile.conjure.maxRankWater end,
     set = function(newValue) MageFu.db.profile.conjure.maxRankWater = newValue; MageFu:Update() end,
     min = 0,
     max = 7, 
     step = 1,
     isPercent = false, 
     order = 1,            
    }, 
    amount = {
     type = 'group',
     name = L["OPT_CONJURE_AMOUNT_NAME"],
     desc = L["OPT_CONJURE_AMOUNT_DESC"],
     order = 1,
     args = {
      limit = {
       type = "text",
       name = L["OPT_CONJURE_AMOUNT_LIMIT_NAME"],
       desc = L["OPT_CONJURE_AMOUNT_LIMIT_DESC"],
       validate = {
        NONE = L["OPT_CONJURE_AMOUNT_LIMIT_NONE"],
        MINIMUM = L["OPT_CONJURE_AMOUNT_LIMIT_MINIMUM"],
        MAXIMUM = L["OPT_CONJURE_AMOUNT_LIMIT_MAXIMUM"],
       },
       get = function() return MageFu.db.profile.conjure.amount.limit end,
       set = function(newValue) MageFu.db.profile.conjure.amount.limit = newValue end,
       order = 1,
      },      
      maxfood = {
       type = 'range',
       name = L["OPT_CONJURE_AMOUNT_MAXFOOD_NAME"],
       desc = L["OPT_CONJURE_AMOUNT_MAXFOOD_DESC"],
       get = function() return MageFu.db.profile.conjure.amount.foodMax end,
       set = function(newValue) MageFu.db.profile.conjure.amount.foodMax = newValue end,
       min = 0,
       max = 200, 
       step = 1,
       isPercent = false, 
       order = 10,            
      }, 
      maxwater = {
       type = 'range',
       name = L["OPT_CONJURE_AMOUNT_MAXWATER_NAME"],
       desc = L["OPT_CONJURE_AMOUNT_MAXWATER_DESC"],
       get = function() return MageFu.db.profile.conjure.amount.waterMax end,
       set = function(newValue) MageFu.db.profile.conjure.amount.waterMax = newValue end,
       min = 0,
       max = 200, 
       step = 1,
       isPercent = false, 
       order = 10,            
      }, 
     },
    },
    byclass = {
     type = 'toggle',
     name = L["OPT_CONJURE_BYCLASS_NAME"],
     desc = L["OPT_CONJURE_BYCLASS_DESC"],
     get = function() return MageFu.db.profile.conjure.byClass end,
     set = function() MageFu.db.profile.conjure.byClass = not MageFu.db.profile.conjure.byClass end, 
     order = 2,
    },     
    class = {
     type = 'group',
     name = L["OPT_CONJURE_CLASS_NAME"],
     desc = L["OPT_CONJURE_CLASS_DESC"],
     order = 3,
     args = { 
      mage = {
       type = 'group',
       name = L["MAGE"],
       desc = string.format(L["OPT_CONJURE_CLASS_SPECIFIC_DESC"],L["MAGE"]),
       args = {    
        food = {
         type = 'toggle',
         name = L["OPT_CONJURE_CLASS_FOOD_NAME"],
         desc = L["OPT_CONJURE_CLASS_FOOD_DESC"],
         get = function() return MageFu.db.profile.conjure.class[L["MAGE"]].food end,
         set = function() MageFu.db.profile.conjure.class[L["MAGE"]].food = not MageFu.db.profile.conjure.class[L["MAGE"]].food end, 
        },   
        water = {
         type = 'toggle',
         name = L["OPT_CONJURE_CLASS_WATER_NAME"],
         desc = L["OPT_CONJURE_CLASS_WATER_DESC"],
         get = function() return MageFu.db.profile.conjure.class[L["MAGE"]].water end,
         set = function() MageFu.db.profile.conjure.class[L["MAGE"]].water = not MageFu.db.profile.conjure.class[L["MAGE"]].water end, 
        }, 
       }, 
      },
      priest = {
       type = 'group',
       name = L["PRIEST"],
       desc = string.format(L["OPT_CONJURE_CLASS_SPECIFIC_DESC"],L["PRIEST"]),
       args = {    
        food = {
         type = 'toggle',
         name = L["OPT_CONJURE_CLASS_FOOD_NAME"],
         desc = L["OPT_CONJURE_CLASS_FOOD_DESC"],
         get = function() return MageFu.db.profile.conjure.class[L["PRIEST"]].food end,
         set = function() MageFu.db.profile.conjure.class[L["PRIEST"]].food = not MageFu.db.profile.conjure.class[L["PRIEST"]].food end, 
        },   
        water = {
         type = 'toggle',
         name = L["OPT_CONJURE_CLASS_WATER_NAME"],
         desc = L["OPT_CONJURE_CLASS_WATER_DESC"],
         get = function() return MageFu.db.profile.conjure.class[L["PRIEST"]].water end,
         set = function() MageFu.db.profile.conjure.class[L["PRIEST"]].water = not MageFu.db.profile.conjure.class[L["PRIEST"]].water end, 
        }, 
       }, 
      },
      warrior = {
       type = 'group',
       name = L["WARRIOR"],
       desc = string.format(L["OPT_CONJURE_CLASS_SPECIFIC_DESC"],L["WARRIOR"]),
       args = {    
        food = {
         type = 'toggle',
         name = L["OPT_CONJURE_CLASS_FOOD_NAME"],
         desc = L["OPT_CONJURE_CLASS_FOOD_DESC"],
         get = function() return MageFu.db.profile.conjure.class[L["WARRIOR"]].food end,
         set = function() MageFu.db.profile.conjure.class[L["WARRIOR"]].food = not MageFu.db.profile.conjure.class[L["WARRIOR"]].food end, 
        },   
        water = {
         type = 'toggle',
         name = L["OPT_CONJURE_CLASS_WATER_NAME"],
         desc = L["OPT_CONJURE_CLASS_WATER_DESC"],
         get = function() return MageFu.db.profile.conjure.class[L["WARRIOR"]].water end,
         set = function() MageFu.db.profile.conjure.class[L["WARRIOR"]].water = not MageFu.db.profile.conjure.class[L["WARRIOR"]].water end, 
        }, 
       }, 
      },
      shaman = {
       type = 'group',
       name = L["SHAMAN"],
       desc = string.format(L["OPT_CONJURE_CLASS_SPECIFIC_DESC"],L["SHAMAN"]),
       args = {    
        food = {
         type = 'toggle',
         name = L["OPT_CONJURE_CLASS_FOOD_NAME"],
         desc = L["OPT_CONJURE_CLASS_FOOD_DESC"],
         get = function() return MageFu.db.profile.conjure.class[L["SHAMAN"]].food end,
         set = function() MageFu.db.profile.conjure.class[L["SHAMAN"]].food = not MageFu.db.profile.conjure.class[L["SHAMAN"]].food end, 
        },   
        water = {
         type = 'toggle',
         name = L["OPT_CONJURE_CLASS_WATER_NAME"],
         desc = L["OPT_CONJURE_CLASS_WATER_DESC"],
         get = function() return MageFu.db.profile.conjure.class[L["SHAMAN"]].water end,
         set = function() MageFu.db.profile.conjure.class[L["SHAMAN"]].water = not MageFu.db.profile.conjure.class[L["SHAMAN"]].water end, 
        }, 
       }, 
      },
      paladin = {
       type = 'group',
       name = L["PALADIN"],
       desc = string.format(L["OPT_CONJURE_CLASS_SPECIFIC_DESC"],L["PALADIN"]),
       args = {    
        food = {
         type = 'toggle',
         name = L["OPT_CONJURE_CLASS_FOOD_NAME"],
         desc = L["OPT_CONJURE_CLASS_FOOD_DESC"],
         get = function() return MageFu.db.profile.conjure.class[L["PALADIN"]].food end,
         set = function() MageFu.db.profile.conjure.class[L["PALADIN"]].food = not MageFu.db.profile.conjure.class[L["PALADIN"]].food end, 
        },   
        water = {
         type = 'toggle',
         name = L["OPT_CONJURE_CLASS_WATER_NAME"],
         desc = L["OPT_CONJURE_CLASS_WATER_DESC"],
         get = function() return MageFu.db.profile.conjure.class[L["PALADIN"]].water end,
         set = function() MageFu.db.profile.conjure.class[L["PALADIN"]].water = not MageFu.db.profile.conjure.class[L["PALADIN"]].water end, 
        }, 
       }, 
      },
      hunter = {
       type = 'group',
       name = L["HUNTER"],
       desc = string.format(L["OPT_CONJURE_CLASS_SPECIFIC_DESC"],L["HUNTER"]),
       args = {    
        food = {
         type = 'toggle',
         name = L["OPT_CONJURE_CLASS_FOOD_NAME"],
         desc = L["OPT_CONJURE_CLASS_FOOD_DESC"],
         get = function() return MageFu.db.profile.conjure.class[L["HUNTER"]].food end,
         set = function() MageFu.db.profile.conjure.class[L["HUNTER"]].food = not MageFu.db.profile.conjure.class[L["HUNTER"]].food end, 
        },   
        water = {
         type = 'toggle',
         name = L["OPT_CONJURE_CLASS_WATER_NAME"],
         desc = L["OPT_CONJURE_CLASS_WATER_DESC"],
         get = function() return MageFu.db.profile.conjure.class[L["HUNTER"]].water end,
         set = function() MageFu.db.profile.conjure.class[L["HUNTER"]].water = not MageFu.db.profile.conjure.class[L["HUNTER"]].water end, 
        }, 
       }, 
      },
      warlock = {
       type = 'group',
       name = L["WARLOCK"],
       desc = string.format(L["OPT_CONJURE_CLASS_SPECIFIC_DESC"],L["WARLOCK"]),
       args = {    
        food = {
         type = 'toggle',
         name = L["OPT_CONJURE_CLASS_FOOD_NAME"],
         desc = L["OPT_CONJURE_CLASS_FOOD_DESC"],
         get = function() return MageFu.db.profile.conjure.class[L["WARLOCK"]].food end,
         set = function() MageFu.db.profile.conjure.class[L["WARLOCK"]].food = not MageFu.db.profile.conjure.class[L["WARLOCK"]].food end, 
        },   
        water = {
         type = 'toggle',
         name = L["OPT_CONJURE_CLASS_WATER_NAME"],
         desc = L["OPT_CONJURE_CLASS_WATER_DESC"],
         get = function() return MageFu.db.profile.conjure.class[L["WARLOCK"]].water end,
         set = function() MageFu.db.profile.conjure.class[L["WARLOCK"]].water = not MageFu.db.profile.conjure.class[L["WARLOCK"]].water end, 
        }, 
       }, 
      },
      rogue = {
       type = 'group',
       name = L["ROGUE"],
       desc = string.format(L["OPT_CONJURE_CLASS_SPECIFIC_DESC"],L["ROGUE"]),
       args = {    
        food = {
         type = 'toggle',
         name = L["OPT_CONJURE_CLASS_FOOD_NAME"],
         desc = L["OPT_CONJURE_CLASS_FOOD_DESC"],
         get = function() return MageFu.db.profile.conjure.class[L["ROGUE"]].food end,
         set = function() MageFu.db.profile.conjure.class[L["ROGUE"]].food = not MageFu.db.profile.conjure.class[L["ROGUE"]].food end, 
        },   
        water = {
         type = 'toggle',
         name = L["OPT_CONJURE_CLASS_WATER_NAME"],
         desc = L["OPT_CONJURE_CLASS_WATER_DESC"],
         get = function() return MageFu.db.profile.conjure.class[L["ROGUE"]].water end,
         set = function() MageFu.db.profile.conjure.class[L["ROGUE"]].water = not MageFu.db.profile.conjure.class[L["ROGUE"]].water end, 
        }, 
       }, 
      },
      druid = {
       type = 'group',
       name = L["DRUID"],
       desc = string.format(L["OPT_CONJURE_CLASS_SPECIFIC_DESC"],L["DRUID"]),
       args = {    
        food = {
         type = 'toggle',
         name = L["OPT_CONJURE_CLASS_FOOD_NAME"],
         desc = L["OPT_CONJURE_CLASS_FOOD_DESC"],
         get = function() return MageFu.db.profile.conjure.class[L["DRUID"]].food end,
         set = function() MageFu.db.profile.conjure.class[L["DRUID"]].food = not MageFu.db.profile.conjure.class[L["DRUID"]].food end, 
        },   
        water = {
         type = 'toggle',
         name = L["OPT_CONJURE_CLASS_WATER_NAME"],
         desc = L["OPT_CONJURE_CLASS_WATER_DESC"],
         get = function() return MageFu.db.profile.conjure.class[L["DRUID"]].water end,
         set = function() MageFu.db.profile.conjure.class[L["DRUID"]].water = not MageFu.db.profile.conjure.class[L["DRUID"]].water end, 
        }, 
       }, 
      },
     },
    },      
   },
  },
  tradeoptions = {
   type = 'group',
   name = L["OPT_TRADE_OPTIONS_NAME"],
   desc = L["OPT_TRADE_OPTIONS_DESC"],
   order = 3,
   args = { 
    autotrade = {
     type = 'toggle',
     name = L["OPT_TRADE_AUTOTRADE_NAME"],
     desc = L["OPT_TRADE_AUTOTRADE_DESC"],
     get = function() return MageFu.db.profile.trade.autoTrade end,
     set = function() MageFu.db.profile.trade.autoTrade = not MageFu.db.profile.trade.autoTrade end, 
    },   
   },
  },
  consumeptions = {
   type = 'group',
   name = L["OPT_CONSUME_OPTIONS_NAME"],
   desc = L["OPT_CONSUME_OPTIONS_DESC"],
   order = 4,
   args = { 
    healththreshold = {
     type = 'range',
     name = L["OPT_CONSUME_HEALTHTHRESHOLD_NAME"],
     desc = L["OPT_CONSUME_HEALTHTHRESHOLD_DESC"],
     get = function() return MageFu.db.profile.consume.healthThreshold end,
     set = function(newValue) MageFu.db.profile.consume.healthThreshold = newValue end,
     min = 0,
     max = 1, 
     step = 0.05,
     isPercent = true,             
    },  
    manathreshold = {
     type = 'range',
     name = L["OPT_CONSUME_MANATHRESHOLD_NAME"],
     desc = L["OPT_CONSUME_MANATHRESHOLD_DESC"],
     get = function() return MageFu.db.profile.consume.manaThreshold end,
     set = function(newValue) MageFu.db.profile.consume.manaThreshold = newValue end,
     min = 0,
     max = 1, 
     step = 0.05,
     isPercent = true,             
    }, 
   },
  },
  conjure = {
   type = 'execute',
   name = L["OPT_CONJURE_NAME"],
   desc = L["OPT_CONJURE_DESC"],
   func = function() MageFu:Conjure() end, 
   order = 101,
  },        
  trade = {
   type = 'execute',
   name = L["OPT_TRADE_NAME"],
   desc = L["OPT_TRADE_DESC"],
   func = function() MageFu:Trade() end, 
   order = 102,
  },        
  consume = {
   type = 'execute',
   name = L["OPT_CONSUME_NAME"],
   desc = L["OPT_CONSUME_DESC"],
   func = function() MageFu:Consume() end, 
   order = 103,
  },  
 },
}


MageFu = AceLibrary("AceAddon-2.0"):new("AceConsole-2.0", "AceEvent-2.0", "AceDB-2.0", "AceComm-2.0", "FuBarPlugin-2.0")
local Tablet = AceLibrary("Tablet-2.0")
local Dewdrop = AceLibrary("Dewdrop-2.0")

MageFu:RegisterChatCommand({L["SLASHCMD_LONG"], L["SLASHCMD_SHORT"]}, opts)
MageFu:SetCommPrefix("MageFu")
MageFu.hasIcon = "Interface\\Icons\\INV_Staff_13"
MageFu.cannotDetachTooltip = false
MageFu.defaultPosition = "LEFT"
MageFu.OnMenuRequest = opts

MageFu:RegisterDB("FuBar_MageDB", "FuBar_MageDBPC")
MageFu:RegisterDefaults("profile", {
 text = {
  text = "[gemcount]/[foodcount]/[watercount]",
 },
 reagent = {
  arcanePowder = 1,
  runeOfTeleportation = 1,
  runeOfPortals = 1,
  autoBuy = false,
 },
 conjure = {
  gem = 2,
  maxRankGem = 4,
  maxRankWater = 7,
  maxRankFood = 6,
  amount = {
   limit = "NONE",
   waterMax = 0,
   foodMax = 0,
  },
  byClass = true,
  class = {
   [L["MAGE"]] = {
    food = false,
    water = true,
   },
   [L["PRIEST"]] = {
    food = false,
    water = true,
   },
   [L["WARRIOR"]] = {
    food = true,
    water = false,
   },
   [L["WARLOCK"]] = {
    food = false,
    water = true,
   },
   [L["SHAMAN"]] = {
    food = false,
    water = true,
   },
   [L["PALADIN"]] = {
    food = false,
    water = true,
   },
   [L["HUNTER"]] = {
    food = true,
    water = true,
   },
   [L["DRUID"]] = {
    food = false,
    water = true,
   },
   [L["ROGUE"]] = {
    food = true,
    water = false,
   },
  },
 },
 trade = {
  autoTrade = false,
 },
 consume = {
  healthThreshold = 0.75,
  manaThreshold = 0.75,
 },
 raid = {
  inRaid = false,
  displayGroups = true,
  displayBuffs = true,
  group = {
   false,
   false,
   false,
   false,
   false,
   false,
   false,
   false,
  },
  mage = {
  },
 },
 transport = {
  teleport = {
   message = {
   },
  },
  portal = {
   message = {
   },
  },
 },
} )

local session = {
 inCombat = false,
 tradeOpen = false,
 gemCount = 0,
 arcanePowderCount = 0,
 runeOfTeleportationCount = 0,
 runeOfPortalsCount = 0,
 hearthstone = {
  location = false
 },
 foodRanks = {
  {
   name = L["FOODRANK7"],
   playerLevel = 60,
   targetLevel = 55,
   mana = 705,
   count = 0,
   initCount = 10,
   location = false,
  },
  {
   name = L["FOODRANK6"],
   playerLevel = 52,
   targetLevel = 45,
   mana = 585,
   count = 0,
   initCount = 2,
   location = false,
  },
  {
   name = L["FOODRANK5"],
   playerLevel = 42,
   targetLevel = 35,
   mana = 420,
   count = 0,
   initCount = 2,
   location = false,
  },
  {
   name = L["FOODRANK4"],
   playerLevel = 32,
   targetLevel = 25,
   mana = 285,
   count = 0,
   initCount = 2,
   location = false,
  },
  {
   name = L["FOODRANK3"],
   playerLevel = 22,
   targetLevel = 15,
   mana = 180,
   count = 0,
   initCount = 2,
   location = false,
  },
  {
   name = L["FOODRANK2"],
   playerLevel = 12,
   targetLevel = 5,
   mana = 105,
   count = 0,
   initCount = 2,
   location = false,
  },
  {
   name = L["FOODRANK1"],
   playerLevel = 6,
   targetLevel = 0,
   mana = 60,
   count = 0,
   initCount = 2,
   location = false,
  },
 },
 waterRanks = {
  {
   name = L["WATERRANK7"],
   playerLevel = 60,
   targetLevel = 55,
   mana = 780,
   count = 0,
   initCount = 10,
   location = false,
  },
  {
   name = L["WATERRANK6"],
   playerLevel = 50,
   targetLevel = 45,
   mana = 585,
   count = 0,
   initCount = 2,
   location = false,
  },
  {
   name = L["WATERRANK5"],
   playerLevel = 40,
   targetLevel = 35,
   mana = 420,
   count = 0,
   initCount = 2,
   location = false,
  },
  {
   name = L["WATERRANK4"],
   playerLevel = 30,
   targetLevel = 25,
   mana = 285,
   count = 0,
   initCount = 2,
   location = false,
  },
  {
   name = L["WATERRANK3"],
   playerLevel = 20,
   targetLevel = 15,
   mana = 180,
   count = 0,
   initCount = 2,
   location = false,
  },
  {
   name = L["WATERRANK2"],
   playerLevel = 10,
   targetLevel = 5,
   mana = 105,
   count = 0,
   initCount = 2,
   location = false,
  },
  {
   name = L["WATERRANK1"],
   playerLevel = 4,
   targetLevel = 0,
   mana = 60,
   count = 0,
   initCount = 2,
   location = false,
  },
 },
 gemRanks = {
  {
   name = L["GEMRANK4"],
   playerLevel = 58,
   mana = 1470,
   count = 0,
   location = false,
  },
  {
   name = L["GEMRANK3"],
   playerLevel = 48,
   mana = 1130,
   count = 0,
   location = false,
  },
  {
   name = L["GEMRANK2"],
   playerLevel = 38,
   mana = 800,
   count = 0,
   location = false,
  },
  {
   name = L["GEMRANK1"],
   playerLevel = 28,
   mana = 530,
   count = 0,
   location = false,
  },
 },
 colours = {
  [L["DRUID"]] = "|cffff7c0a%s|r",
  [L["HUNTER"]] = "|cffaad372%s|r",
  [L["MAGE"]] = "|cff68ccef%s|r",
  [L["PALADIN"]] = "|cfff48cba%s|r",
  [L["PRIEST"]] = "|cffffffff%s|r",
  [L["ROGUE"]] = "|cfffff468%s|r",
  [L["SHAMAN"]] = "|cfff48cba%s|r",
  [L["WARLOCK"]] = "|cff9382C9%s|r",
  [L["WARRIOR"]] = "|cffc69b6d%s|r",  
  ["RED"] = "|cffff0000%s|r",  
 },
}

--[===== Main Functions =====]--

function MageFu:OnEnable()
 local playerClass = UnitClass("player")
 if playerClass ~= L["MAGE"] then
  self:ToggleActive(false)
  return
 end

 self:SetTransportOptions()
 self:BuildTeleportMenu()
 self:BuildPortalMenu()
 self:BagUpdate()
 self:CheckRaidStatus()
 self:UpdateBuffs()
 
 self:RegisterEvent("MERCHANT_SHOW")
 self:RegisterEvent("TRADE_SHOW")
 self:RegisterEvent("TRADE_CLOSED")
 self:RegisterEvent("BAG_UPDATE")
 self:RegisterEvent("RAID_TARGET_UPDATE")
 self:RegisterEvent("PLAYER_REGEN_ENABLED")
 self:RegisterEvent("PLAYER_REGEN_DISABLED")
 
 self:RegisterComm(self.commPrefix, "RAID", "ReceiveMessage")
end

function MageFu:OnTooltipUpdate()
 if self.db.profile.raid.displayGroups then
  self:DisplayGroups()
 end
 if self.db.profile.raid.displayBuffs then
  self:DisplayBuffs()
 end
 Tablet:SetHint(L["TOOLTIP_HINT"])
end

function MageFu:OnClick()
 self:Conjure()
end

function MageFu:OnTextUpdate() 
 local text, foodId, waterId = self.db.profile.text.text, self:GetFoodId("player"), self:GetWaterId("player")
 local foodCount, waterCount
 if foodId then
  foodCount = session.foodRanks[foodId].count
 else
  foodCount = 0
 end
 if waterId then
  waterCount = session.waterRanks[waterId].count
 else
  waterCount = 0
 end 
 
 text = string.gsub(text, "%[gemcount%]", string.format(session.colours[L["SHAMAN"]], session.gemCount))
 text = string.gsub(text, "%[foodcount%]", string.format(session.colours[L["WARRIOR"]], foodCount))
 text = string.gsub(text, "%[watercount%]", string.format(session.colours[L["MAGE"]], waterCount))
 text = string.gsub(text, "%[apcount%]", session.arcanePowderCount)
 text = string.gsub(text, "%[rotcount%]", session.runeOfTeleportationCount)
 text = string.gsub(text, "%[ropcount%]", session.runeOfPortalsCount)
 if session.foodRanks[8-self.db.profile.conjure.maxRankFood].location then
  text = string.gsub(text, "%[floc%]", session.foodRanks[8-self.db.profile.conjure.maxRankFood].location.count)
 end
 if session.waterRanks[8-self.db.profile.conjure.maxRankWater].location then
  text = string.gsub(text, "%[wloc%]", session.waterRanks[8-self.db.profile.conjure.maxRankWater].location.count)
 end
 self:SetText(text)
end

--[===== Event Functions =====]--

function MageFu:MERCHANT_SHOW()
 if self.db.profile.reagent.autoBuy then
  self:ReagentBuy()
 end
end

function MageFu:TRADE_SHOW()
 session.tradeOpen = true
 if self.db.profile.trade.autoTrade then
  self:Trade()
 end
end

function MageFu:TRADE_CLOSED()
 session.tradeOpen = false
end

function MageFu:BAG_UPDATE()
 self:BagUpdate()
end

function MageFu:RAID_TARGET_UPDATE()
 self:CheckRaidStatus()
end

function MageFu:PLAYER_REGEN_ENABLED()
 session.inCombat = false
end

function MageFu:PLAYER_REGEN_DISABLED()
 session.inCombat = true
end

--[===== Comm Functions =====]--

function MageFu:ReceiveMessage(prefix, sender, distribution, g1, g2, g3, g4, g5, g6, g7, g8, arcanePowderCount, refresh)
 local group = {g1, g2, g3, g4, g5, g6, g7, g8}
 self.db.profile.raid.mage[sender] = {group = group, arcanePowderCount = arcanePowderCount}
 if refresh then
  self:SendMessage()
 else 
  self:Update()
 end
end

function MageFu:SendMessage(refresh)
 if self.db.profile.raid.inRaid then
  if refresh then
   self.db.profile.raid.mage = {}
  end
  self:SendCommMessage("RAID", self.db.profile.raid.group[1], self.db.profile.raid.group[2], self.db.profile.raid.group[3], self.db.profile.raid.group[4], self.db.profile.raid.group[5], self.db.profile.raid.group[6], self.db.profile.raid.group[7], self.db.profile.raid.group[8], session.arcanePowderCount, refresh)
  self:Update()
 end 
end

--[===== Menu Functions =====]--

function MageFu:SetTransportOptions()
 local playerLevel, playerFaction = UnitLevel("player"), UnitFactionGroup("player")

 opts.args.transport.args.teleport.args.ironforge.hidden = (playerFaction == L["HORDE"] or playerLevel < 20)
 opts.args.transport.args.teleport.args.stormwind.hidden = (playerFaction == L["HORDE"] or playerLevel < 20)
 opts.args.transport.args.teleport.args.darnassus.hidden = (playerFaction == L["HORDE"] or playerLevel < 30)
 opts.args.transport.args.teleport.args.orgrimmar.hidden = (playerFaction == L["ALLIANCE"] or playerLevel < 20)
 opts.args.transport.args.teleport.args.undercity.hidden = (playerFaction == L["ALLIANCE"] or playerLevel < 20)
 opts.args.transport.args.teleport.args.thunderbluff.hidden = (playerFaction == L["ALLIANCE"] or playerLevel < 30)
 opts.args.transport.args.portal.args.ironforge.hidden = (playerFaction == L["HORDE"] or playerLevel < 40)
 opts.args.transport.args.portal.args.stormwind.hidden = (playerFaction == L["HORDE"] or playerLevel < 40)
 opts.args.transport.args.portal.args.darnassus.hidden = (playerFaction == L["HORDE"] or playerLevel < 50)
 opts.args.transport.args.portal.args.orgrimmar.hidden = (playerFaction == L["ALLIANCE"] or playerLevel < 40)
 opts.args.transport.args.portal.args.undercity.hidden = (playerFaction == L["ALLIANCE"] or playerLevel < 40)
 opts.args.transport.args.portal.args.thunderbluff.hidden = (playerFaction == L["ALLIANCE"] or playerLevel < 50)
  
 opts.args.conjureoptions.args.class.args.paladin.hidden = (playerFaction == L["HORDE"])
 opts.args.conjureoptions.args.class.args.shaman.hidden = (playerFaction == L["ALLIANCE"])
end

function MageFu:BuildTeleportMenu()
 local key, value 
 for key, value in pairs(opts.args.transport.args.teleport.args.message.args) do
  if key ~= "add" then
   value.hidden = true
  end
 end
 for key, value in pairs(self.db.profile.transport.teleport.message) do 
  if value then
   local tkey = key
   opts.args.transport.args.teleport.args.message.args[string.format("m%d",key)] = {type = 'toggle', name = value, desc = value, get = function() return false end, set = function() MageFu:RemoveTeleportMessage(tkey) end, order = 1, hidden = false}
  end
 end
end

function MageFu:BuildPortalMenu()
 local key, value 
 for key, value in pairs(opts.args.transport.args.portal.args.message.args) do
  if key ~= "add" then
   value.hidden = true
  end
 end
 for key, value in pairs(self.db.profile.transport.portal.message) do 
  if value then
   local tkey = key
   opts.args.transport.args.portal.args.message.args[string.format("m%d",key)] = {type = 'toggle', name = value, desc = value, get = function() return false end, set = function() MageFu:RemovePortalMessage(tkey) end, order = 1, hidden = false}
  end
 end
end

function MageFu:AddTeleportMessage(message) 
 if message then
  table.insert(self.db.profile.transport.teleport.message, message)
  self:BuildTeleportMenu()
 end
end

function MageFu:AddPortalMessage(message)
 if message then
  table.insert(self.db.profile.transport.portal.message, message)
  self:BuildPortalMenu()
 end
end

function MageFu:RemoveTeleportMessage(key) 
 if key then
  table.remove(self.db.profile.transport.teleport.message, key)
  self:BuildTeleportMenu()
 end
end

function MageFu:RemovePortalMessage(key) 
 if key then
  table.remove(self.db.profile.transport.portal.message, key)
  self:BuildPortalMenu()
 end
end

--[===== Main Functions =====]--

function MageFu:Conjure()
 local playerLevel = UnitLevel("player")
 local foodId, waterId, gemId, waterLimit, foodLimit
 DoEmote("stand") 
 if not self.db.profile.conjure.byClass or not UnitExists("target") or UnitIsUnit("player","target") or not UnitCanCooperate("player","target") then 
  foodId = self:GetFoodId("player")  
  waterId = self:GetWaterId("player") 
  gemId = self:GetGemId(0)
  foodLimit = self:CheckLimit("food", foodId)
  waterLimit = self:CheckLimit("water", waterId)
  
  if waterId and session.waterRanks[waterId].count == 0 and not waterLimit then
   self:ConjureOrConsume(string.format(L["SPELL_CONJUREWATER"], 8-waterId), session.waterRanks[waterId].mana)  
  elseif gemId and session.gemCount < self.db.profile.conjure.gem then
   self:ConjureOrConsume(string.format(L["SPELL_CONJUREGEM"], session.gemRanks[gemId].name), session.gemRanks[gemId].mana) 
  elseif foodId and (session.foodRanks[foodId].count < 3 or (waterLimit and not foodLimit)) then
   self:ConjureOrConsume(string.format(L["SPELL_CONJUREFOOD"], 8-foodId), session.foodRanks[foodId].mana)
  elseif waterId and not waterLimit then
   self:ConjureOrConsume(string.format(L["SPELL_CONJUREWATER"], 8-waterId), session.waterRanks[waterId].mana) 
  end
  
 else
  local targetLevel = UnitLevel("target")
  local targetClass = UnitClass("target")
  if self.db.profile.conjure.class[targetClass] then
   local food,water = self.db.profile.conjure.class[targetClass].food, self.db.profile.conjure.class[targetClass].water
   if food then
    foodId = self:GetFoodId("target")
    foodLimit = self:CheckLimit("food", foodId)  
   end
   if water then
    waterId = self:GetWaterId("target")
    waterLimit = self:CheckLimit("water", waterId)   
   end
   
   if ((foodId and waterId and session.foodRanks[foodId].count < session.waterRanks[waterId].count) or foodId) and not foodLimit then
    self:ConjureOrConsume(string.format(L["SPELL_CONJUREFOOD"], 8-foodId), session.foodRanks[foodId].mana)
   elseif waterId and not waterLimit then
    self:ConjureOrConsume(string.format(L["SPELL_CONJUREWATER"], 8-waterId), session.waterRanks[waterId].mana) 
   end 
  end
 end
end

function MageFu:Consume(overrideWater)
 if session.inCombat then
  local gemId = self:GetGemId(1)
  if gemId then
   UseContainerItem(session.gemRanks[gemId].location.bag, session.gemRanks[gemId].location.slot) 
  end
 else
  local playerMana, playerHealth = UnitMana("player") / UnitManaMax("player"), UnitHealth("player") / UnitHealthMax("player")
  local foodId, waterId = self:GetFoodId("player"), self:GetWaterId("player")
  if foodId and playerHealth < self.db.profile.consume.healthThreshold then
   UseContainerItem(session.foodRanks[foodId].location.bag, session.foodRanks[foodId].location.slot)  
  end
  if waterId and (overrideWater or playerMana < self.db.profile.consume.manaThreshold) then
   UseContainerItem(session.waterRanks[waterId].location.bag, session.waterRanks[waterId].location.slot)
  end
 end
end

function MageFu:Trade()
 local playerLevel, i = UnitLevel("player")
 if session.tradeOpen then
  local targetLevel = UnitLevel("target")
  local targetClass = UnitClass("target")
  if self.db.profile.conjure.class[targetClass] then
   local food,water,foodId,waterId = self.db.profile.conjure.class[targetClass].food, self.db.profile.conjure.class[targetClass].water, self:GetFoodId("target"), self:GetWaterId("target")
   
   if food and foodId then
    if session.foodRanks[foodId].location and session.foodRanks[foodId].location.count == 20 then
     i = TradeFrame_GetAvailableSlot()
     if i then
      PickupContainerItem(session.foodRanks[foodId].location.bag, session.foodRanks[foodId].location.slot);
      ClickTradeButton(i);
      if (CursorHasItem()) then
       PickupContainerItem(session.foodRanks[foodId].location.bag, session.foodRanks[foodId].location.slot);
      end
     end
    else
     self:Conjure()
     return
    end
   end
   
   if water and waterId then
    if session.waterRanks[waterId].location and session.waterRanks[waterId].location.count == 20 then
     i = TradeFrame_GetAvailableSlot()
     if i then
      PickupContainerItem(session.waterRanks[waterId].location.bag, session.waterRanks[waterId].location.slot);
      ClickTradeButton(i);
      if (CursorHasItem()) then
       PickupContainerItem(session.waterRanks[waterId].location.bag, session.waterRanks[waterId].location.slot);
      end
     end
    else
     self:Conjure()
     return
    end
   end
   
  end
 else
  if UnitCanCooperate("player","target") and CheckInteractDistance("target",2) then
   InitiateTrade("target")
  end  
 end
end

function MageFu:ReagentBuy()
  local items, money = GetMerchantNumItems(), GetMoney()
  local i, itemName, itemPrice, cost, quantity
  for i = 1, items, 1 do
   itemName,_,itemPrice = GetMerchantItemInfo(i)
   if itemName == L["ARCANEPOWDER"] and session.arcanePowderCount < (self.db.profile.reagent.arcanePowder * 20) then
    quantity = (self.db.profile.reagent.arcanePowder * 20) - session.arcanePowderCount
    cost = quantity * itemPrice
    if cost > money then
     quantity = money / itemPrice
    end
    BuyMerchantItem(i, quantity)
   elseif itemName == L["RUNEOFTELEPORTATION"] and session.runeOfTeleportationCount < (self.db.profile.reagent.runeOfTeleportation * 10) then
    quantity = (self.db.profile.reagent.runeOfTeleportation * 10) - session.runeOfTeleportationCount
    cost = quantity * itemPrice
    if cost > money then
     quantity = money / itemPrice
    end
    BuyMerchantItem(i, quantity)
   elseif itemName == L["RUNEOFPORTALS"] and session.runeOfPortalsCount < (self.db.profile.reagent.runeOfPortals * 10) then
    quantity = (self.db.profile.reagent.runeOfPortals * 10) - session.runeOfPortalsCount
    cost = quantity * itemPrice
    if cost > money then
     quantity = money / itemPrice
    end
    BuyMerchantItem(i, quantity)
   end
  end 
end

function MageFu:Teleport(location)
 self:TransportMessage("teleport", location)
 CastSpellByName(string.format(L["SPELL_TELEPORT"], location))
end

function MageFu:Portal(location)
 self:TransportMessage("portal", location)
 CastSpellByName(string.format(L["SPELL_PORTAL"], location))
end

function MageFu:Hearthstone()
 if session.hearthstone.location then
  UseContainerItem(session.hearthstone.location.bag, session.hearthstone.location.slot)   
 end
end

--[===== Other Functions =====]--

function MageFu:BagReset()
 session.gemCount = 0
 session.arcanePowderCount = 0
 session.runeOfTeleportationCount = 0
 session.runeOfPortalsCount = 0
 session.hearthstone.location = false
 local i
 for i = 1, table.getn(session.foodRanks), 1 do
  session.foodRanks[i].count = 0
  session.foodRanks[i].location = false
 end
 for i = 1, table.getn(session.waterRanks), 1 do
  session.waterRanks[i].count = 0
  session.waterRanks[i].location = false
 end
 for i = 1, table.getn(session.gemRanks), 1 do
  session.gemRanks[i].count = 0
  session.gemRanks[i].location = false
 end
end

function MageFu:BagUpdate()
 local i, j, k, slots, name, count, found
 local oldArcanePowderCount = session.arcanePowderCount
 self:BagReset()
 for i = 0, 4, 1 do
  slots = GetContainerNumSlots(i)
  for j = 1, slots, 1 do
   name, count = self:ItemInfo(i, j)
   if name == L["HEARTHSTONE"] then
    session.hearthstone.location = {bag = i, slot = j}
   elseif name == L["ARCANEPOWDER"] then
    session.arcanePowderCount = session.arcanePowderCount + count
   elseif name == L["RUNEOFTELEPORTATION"] then
    session.runeOfTeleportationCount = session.runeOfTeleportationCount + count
   elseif name == L["RUNEOFPORTALS"] then
    session.runeOfPortalsCount = session.runeOfPortalsCount + count
   else
    found = false
    for k = 1, table.getn(session.foodRanks), 1 do
     if name == session.foodRanks[k].name then
      session.foodRanks[k].count = session.foodRanks[k].count + count
      if not session.foodRanks[k].location or count >= session.foodRanks[k].location.count then
       session.foodRanks[k].location = {bag = i, slot = j, count = count}
      end
      found = true
      break
     end
    end
     if not found then
     for k = 1, table.getn(session.waterRanks), 1 do
      if name == session.waterRanks[k].name then
       session.waterRanks[k].count = session.waterRanks[k].count + count
       if not session.waterRanks[k].location or count >= session.waterRanks[k].location.count then
        session.waterRanks[k].location = {bag = i, slot = j, count = count}
       end
       found = true
       break
      end
     end
     if not found then
      for k = 1, table.getn(session.gemRanks), 1 do
       if name == session.gemRanks[k].name then
        session.gemRanks[k].count = 1
        session.gemRanks[k].location = {bag = i, slot = j}
        session.gemCount = session.gemCount + 1
        found = true
        break
       end
      end
     end
    end
   end
  end
 end
 if oldArcanePowderCount ~= session.arcanePowderCount then
  self:SendMessage()
 end
 self:Update()
end

function MageFu:ItemInfo(bag,slot)
 local linkText = GetContainerItemLink(bag, slot)
 local _,count = GetContainerItemInfo(bag, slot)
 if linkText then
  local _,_,name = string.find(linkText,"^.*%[(.*)%].*$")
  return name, count
 else 
  return "", count
 end
end

function MageFu:CheckRaidStatus()
 local oldInRaid = self.db.profile.raid.inRaid
 self.db.profile.raid.inRaid = UnitInRaid("player")
 if not oldInRaid and self.db.profile.raid.inRaid then
  self:SendMessage(true)
  self:UpdateBuffs()
 end
end

function MageFu:DisplayBuffs()
 if self.db.profile.raid.inRaid then
  local cat = Tablet:AddCategory(
    'columns', 2
  )
  for i = 1, 40, 1 do
   local unitName, _, unitGroup, _, unitClass, _, _, unitOnline, unitDead = GetRaidRosterInfo(i);
   if unitName and self.db.profile.raid.group[unitGroup] and unitOnline and not unitDead then
    local buffName, buffName2 = string.format(session.colours["RED"], "NA"), ""
    for k = 0, 15, 1 do
     local buffTexture = UnitBuff(string.format("raid%d", i), k, true)  
     if buffTexture == "Interface\\Icons\\Spell_Holy_ArcaneIntellect" then
      buffName = string.format(session.colours[L["MAGE"]], "AB")
     elseif buffTexture == "Interface\\Icons\\Spell_Holy_MagicalSentry" then 
      buffName = string.format(session.colours[L["MAGE"]], "AI")
     elseif buffTexture == "Interface\\Icons\\Spell_Nature_AbolishMagic" then 
      buffName2 = string.format(session.colours[L["HUNTER"]], "DM")
     elseif buffTexture == "Interface\\Icons\\Spell_Holy_FlashHeal" then 
      buffName2 = string.format(session.colours[L["ROGUE"]], "AM")
     end
    end
    if string.len(buffName2) > 0 then
     buffName = string.format("%s, %s", buffName, buffName2)
    end
    cat:AddLine(
     'text', string.format(session.colours[unitClass], unitName),
     'text2', buffName
    )      
   end
  end
 end
end

function MageFu:UpdateBuffs()
 if self.db.profile.raid.inRaid and self.db.profile.raid.displayBuffs then
  self:ScheduleRepeatingEvent("buffs", function() MageFu:Update() end, 5)
 else
  self:CancelScheduledEvent("buffs")
 end
end

function MageFu:DisplayGroups()
 if self.db.profile.raid.inRaid then
  local cat = Tablet:AddCategory(
    'columns', 3
  )
  local playerName = UnitName("player")
  cat:AddLine(
   'text', string.format(session.colours[L["MAGE"]], playerName),
   'text2', self:GetGroupString(playerName),
   'text3', session.arcanePowderCount
  )
  local name, options
  for name, options in pairs(self.db.profile.raid.mage) do
   cat:AddLine(
    'text', string.format(session.colours[L["MAGE"]], name),
    'text2', self:GetGroupString(name),
    'text3', options.arcanePowderCount
   )
  end
 end
end

function MageFu:GetGroupString(name)
 local id, value
 local groupString = ""
 if name == UnitName("player") then
  for id, value in pairs(self.db.profile.raid.group) do
   if value then
    groupString = groupString .. ", " .. id
   end
  end
 else
  for id, value in pairs(self.db.profile.raid.mage[name].group) do
   if value then
    groupString = groupString .. ", " .. id
   end
  end 
 end
 if string.len(groupString) > 0 then
  groupString = string.sub(groupString, 3)
 end
 return groupString
end

function MageFu:TransportMessage(transportType, location)
 if table.getn(self.db.profile.transport[transportType].message) > 0 then
  local message = self.db.profile.transport[transportType].message[math.random(table.getn(self.db.profile.transport[transportType].message))]
  message = string.gsub(message,"%[location%]",location)
  local chatType = "SAY"
  if self.db.profile.raid.inRaid then
   chatType = "RAID"
  elseif UnitExists("party1") then
   chatType = "PARTY"
  end
  SendChatMessage(message,chatType)
 end
end

function MageFu:GetFoodId(target)
 local playerLevel, targetLevel, i = UnitLevel("player"), UnitLevel("target")
 for i = 8-self.db.profile.conjure.maxRankFood, table.getn(session.foodRanks), 1 do
  if playerLevel >= session.foodRanks[i].playerLevel and (target == "player" or targetLevel >= session.foodRanks[i].targetLevel) then 
   return i
  end
 end 
end

function MageFu:GetWaterId(target)
 local playerLevel, targetLevel, i = UnitLevel("player"), UnitLevel("target")
 for i = 8-self.db.profile.conjure.maxRankWater, table.getn(session.waterRanks), 1 do
  if playerLevel >= session.waterRanks[i].playerLevel and (target == "player" or targetLevel >= session.waterRanks[i].targetLevel) then 
   return i
  end
 end 
end

function MageFu:GetGemId(count)
 local playerLevel, i = UnitLevel("player")
 for i = 5-self.db.profile.conjure.maxRankGem, table.getn(session.gemRanks), 1 do
  if session.gemRanks[i].count == count and playerLevel >= session.gemRanks[i].playerLevel then
   return i
  end
 end
end

function MageFu:ConjureOrConsume(spellName, spellMana)
 local playerMana = UnitMana("player")
 if playerMana >= spellMana then
   CastSpellByName(spellName)
  else
   self:Consume(true)
  end
end

function MageFu:CheckLimit(key, id)
 if id then
  if self.db.profile.conjure.amount.limit == "NONE" then
   return
  else
   local currentCount, playerLevel = session[string.format("%sRanks",key)][id].count, UnitLevel("player")
   if self.db.profile.conjure.amount.limit == "MAXIMUM" then
    local nextCount = session[string.format("%sRanks",key)][id].initCount + ((playerLevel - session[string.format("%sRanks",key)][id].playerLevel) * 2)
    if nextCount < 0 then
     nextCount = 0
    elseif nextCount > 20 then
     nextCount = 20
    end
    currentCount = currentCount + nextCount
   end
   if currentCount <= self.db.profile.conjure.amount[string.format("%sMax",key)] then
    return
   end   
  end
 end
 return true
end