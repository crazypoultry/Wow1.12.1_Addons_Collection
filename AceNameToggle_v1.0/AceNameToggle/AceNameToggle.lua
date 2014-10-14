
AceNameToggle = {}

-- Section I: Chat Options.                              --

AceNameToggle.Const = {

   ChatCmd    = { "/AceNameToggle", "/ant" },

   ChatOpts   = {
      {
         option   = "tog",
         desc     = "Switch to the next view.",
         method   = "NameSwitch"
      },
      {	
         option  = "set",
         desc    = "Set the view to ...",
         input   = TRUE,
         method  = "Cycle",
         args    = {
            {
               option  = "Name",
               desc    = "The players name only."
            },
            {
               option  = "NameGuild",
               desc    = "The players name & guild."
            },
            {
               option  = "NameRank",
               desc    = "The players rank & name."
            },
            {
               option  = "All",
               desc    = "The players name, rank & guild."
            },
            {
               option  = "None",
               desc    = "See nothing!"
            },
         },
      },
      {
           option  = "NPC",
           desc    = "Toggles the NPC names on/off.",
           method  = "NPCToggle"
      }

   },

-- Section II: AddOn Information.                        --
   Title   = "AceNameToggle",
   Version = "1.0",
   Desc    = "Cycles through different player titles displays via keybinding.",

}


-->> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ <<--
-- Chapter II: Addon Object and Functions.               --
-->> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ <<--

--<< ================================================= >>--
-- Section I: The Defaults Table.                        --
--<< ================================================= >>--

--<< ================================================= >>--
-- Section II: Initialize the AddOn Object.              --
--<< ================================================= >>--

local const = AceNameToggle.Const


AceNameToggle    = AceAddonClass:new({
   name          = const.Title,
   description   = const.Desc,
   version       = const.Version,
   releaseDate   = "02/01/06",
   aceCompatible = "102",
   author        = "downforce",
   email         = "gonetribal@gmail.com",
   category      = ACE_CATEGORY_INTERFACE,
   cmd           = AceChatCmd:new(const.ChatCmd,
                                  const.ChatOpts),
})


--<< ================================================= >>--
-- Section III(a): The Enable Function.                  --
-- Section III(b): Register the System Message event.    --
--<< ================================================= >>--

--<< ================================================= >>--
-- Section III: Change the unit's titles.                --
--<< ================================================= >>--


function AceNameToggle:Cycle(i)

    local a,b,c
    
    i = strupper(i)
    
    if      i == "NAME" then a,b,c = 1, 0, 0
        self:Msg("Player names only are being displayed.")
    elseif  i == "NAMEGUILD" then a,b,c = 1, 1, 0
        self:Msg("Player names & guild are being displayed.")
    elseif  i == "NAMERANK" then a,b,c = 1, 0, 1
        self:Msg("Player names and rank are being displayed.")
    elseif  i == "ALL" then a,b,c = 1, 1, 1
        self:Msg("All information is being displayed.")
    elseif  i == "NONE" then a,b,c = 0, 0, 0
        self:Msg("Nothing is being displayed!")
    else
        return
    end

    SetCVar("UnitNamePlayer", a)
    SetCVar("UnitNamePlayerGuild", b)
    SetCVar("UnitNamePlayerPVPTitle", c)
end 

function AceNameToggle:NPCToggle()
    local unpc = GetCVar("UnitNameNPC")
    if (unpc == "0") then
        SetCVar("UnitNameNPC", "1")
    else
        SetCVar("UnitNameNPC", "0")
    end
end

function AceNameToggle:NameSwitch()
    local un = GetCVar("UnitNamePlayer")
    local ug = GetCVar("UnitNamePlayerGuild")
    local ut = GetCVar("UnitNamePlayerPVPTitle")

    if (un == "0" and ug == "0" and ut == "0") then
        self:Cycle("ALL")
    elseif (un == "1" and ug == "1" and ut == "1") then
        self:Cycle("NAME")
    elseif (un == "1" and ug == "0" and ut == "0") then
        self:Cycle("NAMEGUILD")
    elseif (un == "1" and ug == "1" and ut == "0") then
        self:Cycle("NAMERANK")
    elseif (un == "1" and ug == "0" and ut == "1") then
        self:Cycle("NONE")
    else
        return
    end
end

--<< ================================================= >>--
-- Section Omega: Register the AddOn Object.             --
--<< ================================================= >>--

AceNameToggle:RegisterForLoad()

-->> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ <<--
-- Chapter IV: Register Shared Util Functions.           --
-->> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ <<--

ace:RegisterFunctions(AceNameToggle, {
   version = 1.0,

--<< ================================================= >>--
-- Page I: The Addon Closures.                           --
--<< ================================================= >>--

   Msg   = function(self, ...)
      self.cmd:msg(unpack(arg))
   end
   
--<< ================================================= >>--
-- Page Omega: Closure.                                  --
--<< ================================================= >>--

})

