
----------------------------
--      Localization      --
----------------------------

local L = AceLibrary("AceLocale-2.2"):new("Rawr")

L:RegisterTranslations("enUS", function() return {
	SEARCHSTRING = "roar",
	["Illusion: Black Dragonkin"] = true,
	["Furbolg Form"] = true,
} end)


L:RegisterTranslations("deDE", function() return {
	SEARCHSTRING = "br\195\188llt",
	["Illusion: Black Dragonkin"] = "Illusion: Schwarzer Drachkin",
} end)


------------------------------
--      Are you local?      --
------------------------------

local BS = AceLibrary("Babble-Spell-2.2")
local SEA = AceLibrary("SpecialEvents-Aura-2.0")

local playername = UnitName("player")
local _, race = UnitRace("player")
if race == "Scourge" then race = "Undead" end
local rawrpath = "Sound\\Character\\PlayerRoars\\CharacterRoars"..race..
	((UnitSex("player") == 2) and "Male.wav" or "Female.wav")

local buffs = {
	[BS["Bear Form"]]      = "Sound\\Creature\\Bear\\mBearAttackCriticalA.wav",
	[BS["Dire Bear Form"]] = "Sound\\Creature\\Bear\\mBearAttackCriticalA.wav",
	[BS["Cat Form"]]       = "Sound\\Creature\\Tiger\\mTigerAttackA.wav",
	[BS["Travel Form"]]    = "Sound\\Creature\\Tiger\\mTigerAttackA.wav",
	[BS["Moonkin Form"]]   = "Sound\\Creature\\ForceofNature\\ForceOfNatureWoundCrit.wav",
	[BS["Ghost Wolf"]]     = "Sound\\Creature\\Worgen\\A_FenrusAggro.wav",
	[L["Furbolg Form"]]    = "Sound\\Creature\\Furbolg\\mFurbolgWoundCritical1.wav",
	[L["Illusion: Black Dragonkin"]] = "Sound\\Creature\\DragonSpawn\\mDragonSpawnAttackCritical1.wav",
}

---------------------------------
--      Addon Declaration      --
---------------------------------

Rawr = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceConsole-2.0", "AceDB-2.0")
Rawr:RegisterDB("RawrDB", "RawrDBPerChar")
Rawr:RegisterChatCommand({"/rawr"})


------------------------------
--      Initialization      --
------------------------------

function Rawr:OnInitialize()
	self.version = (self.version or GetAddOnMetadata("Rawr", "Version") or "1.0")..
		" |cffff8888r".. (string.sub("$Revision: 15677 $", 12, -3)).. "|r"
end


function Rawr:OnEnable()
	self:RegisterEvent("CHAT_MSG_TEXT_EMOTE")
end


------------------------------
--      Event Handlers      --
------------------------------

function Rawr:CHAT_MSG_TEXT_EMOTE(em, name)
	if name ~= playername or not string.find(string.lower(em), L.SEARCHSTRING) then return end

	for buff,sound in pairs(buffs) do
		if SEA:UnitHasBuff("player", buff) then return PlaySoundFile(sound) end
	end

	PlaySoundFile(rawrpath)
end
