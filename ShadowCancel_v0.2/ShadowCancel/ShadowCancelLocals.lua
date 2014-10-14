-- Create a table to store all global variables. This is not translation-specific, so
-- it is created before the translation is checked, and the translation function will
-- fill it.
SHADOWCANCEL = {}

-- The ace:LoadTranslation() method looks for a specific translation function for
-- the addon. If it finds one, that translation is loaded. See AceHelloLocals_xxXX.lua
-- for an example and description of function naming.
if( not ace:LoadTranslation("ShadowCancel") ) then

-- All text that is translated is placed in quotes in this template.

ace:RegisterGlobals({
    -- Match this version to the library version you are pulling from.
    version = 1.02,

    -- Place any AceUtil globals your addon needs here.
    ACEG_MAP_ONOFF = {[0]="|cffff5050Off|r",[1]="|cff00ff00On|r"},
})

-- Chat handler locals
SHADOWCANCEL.COMMANDS		= {"/sca", "/shadowcancel"}
SHADOWCANCEL.CMD_OPTIONS	= {}

SHADOWCANCEL.UICOMPLAINING = "You are in shapeshift form"
SHADOWCANCEL.REMOVED = "Shadowform removed!"
SHADOWCANCEL.BUFF = "Shadowform"


end