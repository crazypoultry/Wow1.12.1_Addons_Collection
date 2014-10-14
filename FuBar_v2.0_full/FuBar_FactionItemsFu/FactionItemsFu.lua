local dewdrop = AceLibrary("Dewdrop-2.0")
local tablet = AceLibrary("Tablet-2.0")
local crayon = AceLibrary("Crayon-2.0")

FactionItemsFu = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceConsole-2.0", "AceDB-2.0", "FuBarPlugin-2.0")

FactionItemsFu.version       = "2.0.2." .. string.sub("$Revision: 16888 $", 12, -3)
FactionItemsFu.releaseDate   = string.sub("$Date: 2006-11-13 15:00:04 -0500 (Mon, 13 Nov 2006) $", 8, 17)
FactionItemsFu.hasIcon = true
FactionItemsFu.loc = FactionItemsFuLocals
FactionItemsFu.defaultPosition = 'LEFT'
FactionItemsFu.canHideText = false
FactionItemsFu.clickableTooltip = false

FactionItemsFu:RegisterDB("FactionItems2DB") -- ,"FactionItems2CharDB")

FactionItemsFu:RegisterDefaults('char',{
        
TrackItems = {
	["Coarse Weightstone"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Small Furry Paw"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Copper Modulator"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Embossed Leather Boots"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
	["Torn Bear Pelt"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Heavy Grinding Stone"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Whirring Bronze Gizmo"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Toughened Leather Armor"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
	["Soft Bushy Tail"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Green Iron Bracers"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Green Firework"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Barbaric Harness"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
	["Vibrant Plume"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Big Black Mace"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Mechanical Repair Kit"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Turtle Scale Leggings"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
	["Glowing Scorpid Blood"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Evil Bat Eye"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Dense Grinding Stone"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Thorium Widget"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
	["Rugged Armor Kit"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Darkmoon Faire Prize Ticket"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Winterfall Spirit Beads"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Deadwood Headdress Feather"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
	["Twilight Text"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Cenarion Combat Badge"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Cenarion Logistics Badge"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Cenarion Tactical Badge"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
	["Qiraji Regal Drape"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Bone Scarab"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Silver Scarab"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Stone Scarab"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Bronze Scarab"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Ivory Scarab"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
	["Crystal Scarab"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Qiraji Magisterial Ring"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Qiraji Ornate Hilt"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Jasper Idol"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Alibaster Idol"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
	["Vermillion Idol"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Qiraji Spiked Hilt"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Qiraji Ceremonial Ring"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Lambent Idol"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Amber Idol"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Azure Idol"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
	["Gold Scarab"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Clay Scarab"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Qiraji Martial Drape"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Obsidian Idol"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Onyx Idol"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Troll Tribal Necklace"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
	["Coal"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Incendosaur Scales"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Kingsblood"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Heavy Leather"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Iron Bar"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Dark Iron Residue"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Dark Iron Ore"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
	["Core Leather"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Blood of the Mountain"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Lava Core"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Fiery Core"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Minion's Scourgestone"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Invader's Scourgestone"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Corruptor's Scourgestone"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
	["Runecloth"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Ectoplasmic Resonator"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Arcane Quickener"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Somatic Intensifier"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Osseous Agitator"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Argent Dawn Valor Token"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
	["Insignia of the Crusade"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Insignia of the Dawn"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Crypt Fiend Parts"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Core of Elements"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Savage Frond"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Dark Iron Scraps"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Bone Fragments"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Syndicate Emblem"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Qiraji Bindings of Dominance"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Idol of Strife"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
	["Gold Scarab"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Bone Scarab"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Silver Scarab"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Stone Scarab"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Idol of Rebirth"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Idol of War"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Crystal Scarab"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
	["Skin of the Great Sandworm"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Clay Scarab"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Idol of Life"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Vek\'lor\'s Diadem"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Husk of the Old God"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Bronze Scarab"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
	["Ivory Scarab"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Idol of the Sun"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Carapace of the Old God"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Idol of the Sage"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Idol of Death"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Ouro\'s Intact Hide"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
	["Vek\'nilash\'s Circlet"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Idol of Night"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Purple Hakkari Bijou"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Green Hakkari Bijou"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Red Hakkari Bijou"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Yellow Hakkari Bijou"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Bronze Hakkari Bijou"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Gold Hakkari Bijou"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Orange Hakkari Bijou"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
	["Blue Hakkari Bijou"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Silver Hakkari Bijou"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Primal Hakkari Aegis"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Primal Hakkari Armsplint"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
	["Primal Hakkari Bindings"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Primal Hakkari Girdle"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Primal Hakkari Idol"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Primal Hakkari Kossock"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
	["Primal Hakkari Sash"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Primal Hakkari Shawl"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Primal Hakkari Stanchion"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Primal Hakkari Tabard"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
	["Zandalar Honor Token"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Sandfury Coin"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Skullsplitter Coin"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Bloodscalp Coin"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Gurubashi Coin"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
	["Vilebranch Coin"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Witherbark Coin"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Zulian Coin"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Razzashi Coin"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Hakkari Coin"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Wushoolay\'s Mane"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
	["Punctured Voodoo Doll"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Gri\'lek\'s Blood"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Renataki\'s Tooth"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Hazza\'rah\'s Dream Thread"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Morrowgrain"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Un\'Goro soil"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
    ["Tarlendris Seeds"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
		["Heavy Junkboxes"] = {["inv"] = 0,["bank"] = 0,["mail"]=0,},
},
	["Argent Dawn"] = false,
	["Brood of Nozdormu"] = false,
  ["Cenarion Circle"] = false,
  ["Darkmoon Faire"] = true,
  ["Ravenholdt"] = false,
	["Thorium Brotherhood"] = false,
	["Timbermaw Hold"] = false,
	["Wildhammer Clan"] = false,
	["Zandalar Tribe"] = false,
  ["Alliance/Horde"] = false,
  ["countDisplayStyle"] = "",
  ["title"] = false,
  })

	local optionsTable = { 
		type = 'group',
 		args = { 
            watch = { 
                name = "watch", 
                type = 'group',
                desc = "watch items for desired faction(s)",
                args = {
                    ["ArgentDawn"] = {
                        name = "Argent Dawn",type = 'toggle',
                        desc = "toggles watching items for Argent Dawn",
                        usage = "watch ArgentDawn",
                        get = function()
                            return FactionItemsFu.db.char["Argent Dawn"]
                        end,
                        set = function(v)
                            FactionItemsFu.db.char["Argent Dawn"] = not FactionItemsFu.db.char["Argent Dawn"]
                            --- Refresh in place
                            FactionItemsFu:UpdateDisplay()
                        end,
                        map = { [true] = "Watching", [false] = "Hidden" },
                    },
                    ["BroodofNozdormu"] = {
                        name = "Brood of Nozdormu",type = 'toggle',
                        desc = "toggles watching items for Brood of Nozdormu",
                        usage = "watch BroodofNozdormu",
                        get = function()
                            return FactionItemsFu.db.char["Brood of Nozdormu"]
                        end,
                        set = function(v)
                            FactionItemsFu.db.char["Brood of Nozdormu"] = not FactionItemsFu.db.char["Brood of Nozdormu"]
                            --- Refresh in place
                            FactionItemsFu:UpdateDisplay()
                        end,
                        map = { [true] = "Watching", [false] = "Hidden" },
                    },
                    ["CenarionCircle"] = {
                        name = "Cenarion Circle",type = 'toggle',
                        desc = "toggles watching items for Cenarion Circle",
                        usage = "watch CenarionCircle",
                        get = function()
                            return FactionItemsFu.db.char["Cenarion Circle"]
                        end,
                        set = function(v)
                            FactionItemsFu.db.char["Cenarion Circle"] = not FactionItemsFu.db.char["Cenarion Circle"]
                            --- Refresh in place
                            FactionItemsFu:UpdateDisplay()
                        end,
                        map = { [true] = "Watching", [false] = "Hidden" },
                    },
                    ["DarkmoonFaire"] = {
                        name = "Darkmoon Faire",type = 'toggle',
                        desc = "toggles watching items for Darkmoon Faire",
                        usage = "watch DarkmoonFaire",
                        get = function()
                            return FactionItemsFu.db.char["Darkmoon Faire"]
                        end,
                        set = function(v)
                            FactionItemsFu.db.char["Darkmoon Faire"] = not FactionItemsFu.db.char["Darkmoon Faire"]
                            --- Refresh in place
                            FactionItemsFu:UpdateDisplay()
                        end,
                        map = { [true] = "Watching", [false] = "Hidden" },
                    },
                    ["Ravenholdt"] = {
                        name = "Ravenholdt",type = 'toggle',
                        desc = "toggles watching items for Ravenholdt",
                        usage = "watch Ravenholdt",
                        get = function()
                            return FactionItemsFu.db.char["Ravenholdt"]
                        end,
                        set = function(v)
                            FactionItemsFu.db.char["Ravenholdt"] = not FactionItemsFu.db.char["Ravenholdt"]
                            --- Refresh in place
                            FactionItemsFu:UpdateDisplay()
                        end,
                        map = { [true] = "Watching", [false] = "Hidden" },
                    },
                    ["TheThoriumBrotherhood"] = {
                        name = "The Thorium Brotherhood",type = 'toggle',
                        desc = "toggles watching items for The Thorium Brotherhood",
                        usage = "watch TheThoriumBrotherhood",
                        get = function()
                            return FactionItemsFu.db.char["Thorium Brotherhood"]
                        end,
                        set = function(v)
                            FactionItemsFu.db.char["Thorium Brotherhood"] = not FactionItemsFu.db.char["Thorium Brotherhood"]
                            --- Refresh in place
                            FactionItemsFu:UpdateDisplay()
                        end,
                        map = { [true] = "Watching", [false] = "Hidden" },
                    },
                    ["TimbermawHold"] = {
                        name = "Timbermaw Hold",type = 'toggle',
                        desc = "toggles watching items for Timbermaw Hold",
                        usage = "watch TimbermawHold",
                        get = function()
                            return FactionItemsFu.db.char["Timbermaw Hold"]
                        end,
                        set = function(v)
                            FactionItemsFu.db.char["Timbermaw Hold"] = not FactionItemsFu.db.char["Timbermaw Hold"]
                            --- Refresh in place
                            FactionItemsFu:UpdateDisplay()
                        end,
                        map = { [true] = "Watching", [false] = "Hidden" },
                    },
                    ["WildhammerClan"] = {
                        name = "Wildhammer Clan",type = 'toggle',
                        desc = "toggles watching items for Wildhammer Clan",
                        usage = "watch WildhammerClan",
                        get = function()
                            return FactionItemsFu.db.char["Wildhammer Clan"]
                        end,
                        set = function(v)
                            FactionItemsFu.db.char["Wildhammer Clan"] = not FactionItemsFu.db.char["Wildhammer Clan"]
                            --- Refresh in place
                            FactionItemsFu:UpdateDisplay()
                        end,
                        map = { [true] = "Watching", [false] = "Hidden" },
                    },
                    ["ZandalarTribe"] = {
                        name = "Zandalar Tribe",type = 'toggle',
                        desc = "toggles watching items for Zandalar Tribe",
                        usage = "watch ZandalarTribe",
                        get = function()
                            return FactionItemsFu.db.char["Zandalar Tribe"]
                        end,
                        set = function(v)
                            FactionItemsFu.db.char["Zandalar Tribe"] = not FactionItemsFu.db.char["Zandalar Tribe"]
                            --- Refresh in place
                            FactionItemsFu:UpdateDisplay()
                        end,
                        map = { [true] = "Watching", [false] = "Hidden" },
                    },
									  ["Alliance/Horde"] = {
                        name = "Alliance/Horde",type = 'toggle',
                        desc = "toggles watching items for Morrowgrain and Cloth Quests",
                        usage = "watch Alliance/Horde",
                        get = function()
                            return FactionItemsFu.db.char["Alliance/Horde"]
                        end,
                        set = function(v)
                            FactionItemsFu.db.char["Alliance/Horde"] = not FactionItemsFu.db.char["Alliance/Horde"]
                            --- Refresh in place
                            FactionItemsFu:UpdateDisplay()
                        end,
                        map = { [true] = "Watching", [false] = "Hidden" },
                    },
                },
            },
						panelDisplay = {
							name = "Panel_Display", 
              type = 'group',
              desc = "Text display configuration for FuBar panel",
              args = {
								["title"] = {
                	name = "Title",
									type = 'toggle',
                  desc = "toggles displaying addon title in FuBar panel",
                  usage = "panelDisplay title",
                  get = function()
                  	return FactionItemsFu.db.char["title"]
                  end,
                  set = function(v)
                  	FactionItemsFu.db.char["title"] = not FactionItemsFu.db.char["title"]
                    --- Refresh in place
                    FactionItemsFu:UpdateDisplay()
                  end,
                  map = { [true] = "Displayed", [false] = "Hidden" },
                },
                ["countDisplay"] = {
                  name = "countDisplay",
    							type = 'text',
    							desc = "toggles displaying bank and bags item totals in FuBar panel",
    							get = function()
        						return FactionItemsFu.db.char.countDisplayStyle
    							end,
    							set = function(option)
        						FactionItemsFu.db.char.countDisplayStyle = option
          					--- Refresh in place
        						FactionItemsFu:UpdateDisplay()
    							end,
    							validate = {"bags", "bank", "bankSlashbag","bagsPlusbank","none"},
								},
							},
						},
 		},
	}

	FactionItemsFu:RegisterChatCommand({"/fi", "/fifu"},optionsTable)
	FactionItemsFu.OnMenuRequest = optionsTable
	
function FactionItemsFu:OnInitialize()
	ItemList = self.loc.TrackItems
	FactionList = self.loc.TrackFactions
	RepUnitNames = self.loc.RepNames
    FactionItemsList = self.loc.FactionItems
    if not self.db.char.Loaded then
		DEFAULT_CHAT_FRAME:AddMessage("No Database info preloaded")
		self.db.char.Loaded = true
    self.db.char.countDisplayStyle = "bankSlashbag"
    end
    TextTotals = {
        ["bags"] = 0,
        ["bank"] = 0,
        }
end

function FactionItemsFu:OnEnable()
	-- put something that would be run every time this is enabled. Happens at the very start as well, after Initialize.
	self:RegisterEvent("MERCHANT_SHOW","Inv_Change");
	self:RegisterEvent("MERCHANT_CLOSED","Inv_Change");
	self:RegisterEvent("MAIL_CLOSED","Mail_Change");
	self:RegisterEvent("BAG_UPDATE","Inv_Change");
	self:RegisterEvent("BANKFRAME_CLOSED","Bnk_Change");
	self:RegisterEvent("UNIT_INVENTORY_CHANGED","Inv_Change");
	self:RegisterEvent("BANKFRAME_OPENED","Bnk_Change");
	self:RegisterEvent("PLAYERBANKSLOTS_CHANGED","Bnk_Change");
    self:RegisterEvent("FACTION_STANDING_INCREASED","CheckFactionValue");
		
end

function FactionItemsFu:OnDisable()
	-- you do not need to unregister the event here, all events/hooks are unregistered on disable implicitly.
end

function FactionItemsFu:CheckFactionValue()
	-- CreateFactionList()
	self:UpdateDisplay()
end

function FactionItemsFu:Inv_Change()
  for _,k in pairs(ItemList)  do
    local ItemCount = GetBagItems(k)
    self.db.char.TrackItems[k].inv = ItemCount
	end
	self:UpdateDisplay()
end

function FactionItemsFu:GetInvCount(k)
  return self.db.char.TrackItems[k].inv
	
end    

function FactionItemsFu:GetBankCount(k)
    return self.db.char.TrackItems[k].bank
    
end

function FactionItemsFu:GetMailCount(k)
  return self.db.char.TrackItems[k].mail
end

function FactionItemsFu:Bnk_Change()
  for _,k in pairs(ItemList)  do
    local ItemCount = GetBankItems(k)
    self.db.char.TrackItems[k].bank = ItemCount
  end
	self:UpdateDisplay()
end

function FactionItemsFu:Mail_Change()
  for _,k in pairs(ItemList)  do
    local ItemCount = GetMailItems(k)
    self.db.char.TrackItems[k].mail = ItemCount
  end
	
end

function FactionItemsFu:OnDataUpdate()
	TextTotals.bags = 0
  TextTotals.bank = 0
  for _,category in ipairs(FactionList) do
    local standing,bottomValue,maxNeeded,repValue = CheckFactionValues(category)
		if standing == nil then standing = 9 end
		if repValue == nil then repValue = 0 end
      if self.db.char[category] then
        if category == "Darkmoon Faire" then
					if standing == 9 or standing <= 4 then
						if repValue <= 500 then
							for _,items in ipairs(FactionItemsList["FaireTier1"]) do
								TextTotals.bags = TextTotals.bags + self:GetInvCount(items)
                TextTotals.bank = TextTotals.bank + self:GetBankCount(items)
							end
						end
						if repValue <= 1100 then
							for _,items in ipairs(FactionItemsList["FaireTier2"]) do
								TextTotals.bags = TextTotals.bags + self:GetInvCount(items)
              	TextTotals.bank = TextTotals.bank + self:GetBankCount(items)
							end
						end
						if repValue <= 1700 then
							for _,items in ipairs(FactionItemsList["FaireTier3"]) do
								TextTotals.bags = TextTotals.bags + self:GetInvCount(items)
              	TextTotals.bank = TextTotals.bank + self:GetBankCount(items)
							end
						end
						if repValue <= 2500 then
							for _,items in ipairs(FactionItemsList["FaireTier4"]) do
								TextTotals.bags = TextTotals.bags + self:GetInvCount(items)
              	TextTotals.bank = TextTotals.bank + self:GetBankCount(items)
							end
						end
					end
					for _,items in ipairs(FactionItemsList["FaireTier5"]) do
						TextTotals.bags = TextTotals.bags + self:GetInvCount(items)
        		TextTotals.bank = TextTotals.bank + self:GetBankCount(items)
					end
      	elseif category == "Thorium Brotherhood" then
          if standing == 9 or standing <= 8 then
            for _,items in ipairs(FactionItemsList["Brotherhood3"]) do
					    TextTotals.bags = TextTotals.bags + self:GetInvCount(items)
              TextTotals.bank = TextTotals.bank + self:GetBankCount(items)
				    end
          end
          if standing == 9 or standing <= 5 then
            for _,items in ipairs(FactionItemsList["Brotherhood2"]) do
					    TextTotals.bags = TextTotals.bags + self:GetInvCount(items)
              TextTotals.bank = TextTotals.bank + self:GetBankCount(items)
				    end
          end
          if standing == 9 or standing <= 4 then
            for _,items in ipairs(FactionItemsList["Brotherhood1"]) do
					    TextTotals.bags = TextTotals.bags + self:GetInvCount(items)
              TextTotals.bank = TextTotals.bank + self:GetBankCount(items)
				    end
          end
				else
					for _,items in ipairs(FactionItemsList[category]) do
            TextTotals.bags = TextTotals.bags + self:GetInvCount(items)
            TextTotals.bank = TextTotals.bank + self:GetBankCount(items)
					end
				end
      end
    end
end 

function FactionItemsFu:GetItemTotals(itm)
local a = self:GetInvCount(itm)
local b = self:GetBankCount(itm)
local c = self:GetMailCount(itm)
return a + b + c
	--- return self:GetInvCount(itm) + self:GetBankCount(itm) + self:GetMailCount(itm)
end

function FactionItemsFu:OnTextUpdate()
  self:UpdateData()
  textspace = " "
  if self.db.char["title"] then
		text = textspace..crayon:Green(self.loc.TEXT_SET)
  else
  	text = " "
  end
	if self.db.char["countDisplayStyle"] == "bankSlashbag" then
			text1 = textspace..crayon:White(TextTotals.bank).."/"..crayon:White(TextTotals.bags)
	elseif self.db.char["countDisplayStyle"] =="bagsPlusbank" then
			text1 = textspace..crayon:White(TextTotals.bank + TextTotals.bags)
	elseif self.db.char["countDisplayStyle"] =="bags" then
			text1 = textspace..crayon:White(TextTotals.bags)
	elseif self.db.char["countDisplayStyle"] == "bank" then
			text1 = textspace..crayon:White(TextTotals.bank)
	else
		text1 = ""
  end
	self:SetText(text..text1)
end
	
function FactionItemsFu:OnTooltipUpdate()

	for _,category in ipairs(FactionList) do
        local standing,bottomValue,maxNeeded,repValue = CheckFactionValues(category)
		if standing == nil then standing = 9 end
		if maxNeeded == nil then maxNeeded = 0 end
		if repValue == nil then repValue = 0 end
    if bottomValue == nil then bottomValue = 0 end
    if self.db.char[category] then
      cat = tablet:AddCategory(
        'columns', 3,
				'text', category,
				'text2',RepUnitNames[standing],
				'text3',(repValue - bottomValue).."/"..maxNeeded,
				'text3R',0,
				'text3G',0,
				'text3B',1
			)
			cat:AddLine()
			cat:AddLine('text',"Item ",'text2',"\t",'text3'," Qty ")
			cat:AddLine()
			if category == "Darkmoon Faire" then
				if standing == 9 or standing <= 4 then
					if repValue <= 500 then
						for _,items in ipairs(FactionItemsList["FaireTier1"]) do
              cat:AddLine('text',items,'text2',"\t",'text3',self:GetItemTotals(items))
						end
					end
					if repValue <= 1000 then
						for _,items in ipairs(FactionItemsList["FaireTier2"]) do
              cat:AddLine('text',items,'text2',"\t",'text3',self:GetItemTotals(items))
						end
					end
					if repValue <= 1600 then
						for _,items in ipairs(FactionItemsList["FaireTier3"]) do
              cat:AddLine('text',items,'text2',"\t",'text3',self:GetItemTotals(items))
						end
					end
					if repValue <= 2500 then
						for _,items in ipairs(FactionItemsList["FaireTier4"]) do
              cat:AddLine('text',items,'text2',"\t",'text3',self:GetItemTotals(items))
						end
					end
				end
				for _,items in ipairs(FactionItemsList["FaireTier5"]) do
              cat:AddLine('text',items,'text2',"\t",'text3',self:GetItemTotals(items))
				end
      elseif category == "Thorium Brotherhood" then
        if standing <= 9 then
          for _,items in ipairs(FactionItemsList["Brotherhood3"]) do
					  cat:AddLine('text',items,'text2',"\t",'text3',self:GetItemTotals(items))
				  end
        end
        if standing == 9 or standing <= 5 then
          for _,items in ipairs(FactionItemsList["Brotherhood2"]) do
				  	cat:AddLine('text',items,'text2',"\t",'text3',self:GetItemTotals(items))
				  end
        end
        if standing == 9 or standing <= 4 then
          for _,items in ipairs(FactionItemsList["Brotherhood1"]) do
				  	cat:AddLine('text',items,'text2',"\t",'text3',self:GetItemTotals(items))
				  end
        end
      else
        for _,items in ipairs(FactionItemsList[category]) do
          cat:AddLine('text',items,'text2',"\t",'text3',self:GetItemTotals(items))
				end
			end
		end
	end
	tablet:SetHint("Click here will open Argent Dawn Grinder Settings if Installed.")
	-- as a rule, if you have an OnClick or OnDoubleClick or OnMouseUp or OnMouseDown, you should set a hint.
end

function FactionItemsFu:OnClick()
	local frame = getglobal("ArgentDawnGrinderSettingsFrame");
	if(frame)then
		if(frame:IsVisible())then
			frame:Hide();
		else
			frame:Show();
		end
	end
end

--------------------------------------------'-----------------------------------------------------
-- COUNT THE NUMBER OF ITEMS
--------------------------------------------------------------------------------------------------

function NameFromLink(link)
	local name
	if (link) then
		for name in string.gfind(link, "|c%x+|Hitem:%d+:%d+:%d+:%d+|h%[(.-)%]|h|r") do
			return name;
		end
	end
end 

function GetBagItems(argItem)
	local count = 0
	for bag = 4, 0, -1 do
		local size = GetContainerNumSlots(bag)
		if (size > 0) then
			for slot=1, size, 1 do
				local texture, itemCount = GetContainerItemInfo(bag, slot)
				if (itemCount ~= nil) then
				   local itemName = NameFromLink(GetContainerItemLink(bag, slot))	
					if  ((itemName) and (itemName ~= "")) then -- if the item has a name
                        if (itemName == argItem) then 
							count  = count + itemCount
						end
					end
				end
			end            
		end
	end	
	return count
end

function GetMailItems(argItem)
	local count = 0
	local mailItems = GetInboxNumItems()
	if(mailItems > 0) then
		for index = 1, mailItems, 1 do
			itemName, itemIcon, itemQuantity = GetInboxItem(index)
			if( itemName == argItem ) then
			 count = count + itemQuantity
			end
		end
	end
	
	return count
end

function GetBankItems(argItem)
	local count = 0
		maxContainerItems = GetContainerNumSlots(BANK_CONTAINER)
		if ( maxContainerItems ) then
			for containerItemNum = 1, maxContainerItems do
				link = GetContainerItemLink(BANK_CONTAINER, containerItemNum)
				icon, quantity = GetContainerItemInfo(BANK_CONTAINER, containerItemNum)
				if( link ) then
				--LinkToName
					itemName = NameFromLink(link)
					if(itemName == argItem) then
						count = count + quantity
					end
				end
			end
		end
		for bagNum = 5, 10 do
			maxContainerItems = GetContainerNumSlots(bagNum)
			if( maxContainerItems ) then
				local id = BankButtonIDToInvSlotID(bagNum, 1)
				link = GetInventoryItemLink("player", id)
				icon = GetInventoryItemTexture("player", id)
				for containerItemNum = 1, maxContainerItems do
					link = GetContainerItemLink(bagNum, containerItemNum)
					icon, quantity = GetContainerItemInfo(bagNum, containerItemNum)
					if( link ) then
					--LinkToName
						itemName = NameFromLink(link)
						if(itemName == argItem) then
							count = count + quantity
						end
					end
				end
			end
		end
	
	return count
end

--------------------------------------------------------------------------------------------------
-- Reputation Functions
--------------------------------------------------------------------------------------------------

function CheckFactionValues(f)
	local numFactions = GetNumFactions()
		for factionIndex=1, numFactions do
			name, _, standingID, bottomValue, topValue, barValue, _, _, isHeader, isCollapsed,_ = GetFactionInfo(factionIndex)
			if isHeader == nil then 
			  isHeader = false
			end
			if isHeader then
				if isCollapsed then
					ExpandFactionHeader(factionIndex)
				end
			elseif name == f then
				return standingID,bottomValue,topValue,barValue
			end
		end
end

--------------------------------------------------------------------------------------------------
-- Misc Help Functions
-----------------------------------------------------------------'--------------------------------

function FactionItemsFu:Round(num)
	if(num - math.floor(num) >= 0.5) then
		num = num + 0.5;
	end
	return math.floor(num)
end

function Min(num1,num2)
  if(num1<=num2) then
	ret=num1
  else
	ret=num2
  end

  return ret
end 

function FactionItemsFu:CalculateCraftables()	-- to be used in future for Darkmoon Faire items
	 dense_grind_stone_craft =  math.floor(self:GetItemTotals("Dense Stone")/4)
	 heavy_grind_stone_craft =  math.floor(self:GetItemTotals("Heavy Stone")/3)
	 widgets_craft = Min(self:GetItemTotals("Runecloth"),math.floor((self:GetItemTotals("Thorium Bar") + self:GetItemTotals("Thorium Ore"))/4))
	 rugged_kit_craft = math.floor(self:GetItemTotals("Rugged Leather")/5)
end
