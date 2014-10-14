------------------------------------------------------
Fizzwidget FactionFriend
by Gazmik Fizzwidget
http://www.fizzwidget.com/factionfriend
gazmik@fizzwidget.com
------------------------------------------------------

It's amazing the lengths some will go to to win friends. Gaining the trust of furbolg tribes, Dark Iron dwarves, and other organizagations of demi-goblinoid races can be a lot of work, and it can be easy sometimes to lose rack of one's progress. That's where Fizzwidget Industries comes in! Our newest gadget not only helps you keep tabs on whose respect you're earning, but also how much more you could earn by turning in certain items you're carrying.

------------------------------------------------------

INSTALLATION: Put the GFW_FactionFriend folder into your World Of Warcraft/Interface/AddOns folder and launch WoW.

FEATURES: 
	- Automatically switches the Blizzard builtin reputation watch bar (i.e. the "Show as experience bar" option in the Reputation pane) when entering certain zones. (Argent Dawn in Plaguelands, Zandalar Tribe in Zul'Gurub, etc.)
	- Outside of those zones, automatically switches the reputation watch bar when gaining reputation. (If gaining reputation with multiple factions at once, the bar will switch for only the first.)
	- In cases where faction can be gained through repeatable item turnins, the faction you can earn by turning in whatever's in your inventory is shown on the reputation watch bar in a similar fashion to how rest state is shown on the experience bar. (For example, if you're watching Timbermaw Hold faction and have 23 Winterfall Spirit Beads in your inventory, a marker and partially-shaded area on the bar will show that you can gain 200 reputation points by turning in four sets of five beads each.)
	- Mousing over the reputation watch bar (or the aforementioned marker) will show a summary of the reputation points that can be earned through turning in or consuming items.

CHAT COMMANDS:
	/factionfriend (or /ff): shows or hides the options window.

CAVEATS, KNOWN BUGS, ETC.: 
	- The potential reputation gain shown on the bar is just an estimate: actual reputation gain may vary. (This is especially true for humans, as FactionFriend's rounding may not match Blizzard's when calculating the racial 10% increase in faction gain.)
	- Some repeatable faction turnins offer an increased amount of reputation the first time they're completed; FactionFriend has no way of knowing whether you've done a turnin before, so it always assumes the smaller amount.
	- Some repeatable faction turnins only become available at a certain level, or once prerequisite quests are completed. FactionFriend can't keep track of all the reasons a turnin might or might not be available; it just shows how much reputation you'd be able earn if the turnins are possible. 

------------------------------------------------------
VERSION HISTORY

v. 11200.1 - 2006/10/16
- Initial public release. 

See http://fizzwidget.com/notes/factionfriend/ for older release notes.

------------------------------------------------------

Complete list of builtin zone faction switches:
	Alterac Valley: Frostwolf Clan (Horde) or Stormpike Guard (Alliance)
	Arathi Basin: Defilers (Horde) or League of Arathor (Alliance)
	Warsong Gulch: Warsong Clan (Horde) or Silverwing Sentinels (Alliance)
	Hinterlands: Wildhammer Clan (Alliance only)
	Silithus: Cenarion Circle
	AQ20: Cenarion Circle
	AQ40: Brood of Nozdormu
	Zul'Gurub: Zandalar Tribe
	WPL: Argent Dawn
	EPL: Argent Dawn
	Stratholme: Argent Dawn
	Scholomance: Argent Dawn
	Naxxramas: Argent Dawn
	Felwood: Timbermaw Hold
	Winterspring: Timbermaw Hold
	
Complete list of tracked item turnins, by faction:
	For the eight racial factions:
		Alliance/Horde Commendation signets (from the AQ war effort)
		Runecloth
	Alterac Valley turnins (affects both Stormpike Guard/Frostwolf Clan and Ironforge/Orgrimmar):
		Wolf/ram hides for harnesses
		Storm Crystals / blood for boss summons
		Armor Scraps
		Medals / flesh for airstrikes
	Zandalar Tribe:
		any Bijous
		Zulian + Razzashi + Hakkari Coins, Gurubashi + Vilebranch + Witherbark Coins, Sandfury + Skullsplitter + Bloodscalp Coins
		Zandalar Honor Token
	Brood of Nozdormu: 
		Qiraji Lord's Insignia, Ancient Qiraji Artifact
	Cenarion Circle:
		Qiraji Lord's Insignia, Abyssal Crests, Abyssal Signets, Abyssal Scepters, Encrypted Twilight Texts
	Argent Dawn:
		Insignia turnins (only available at Friendly and above): Crypt Fiend Parts, Bone Fragments, Core of Elements, Dark Iron Scraps, Savage Frond
		Cauldron run sets: Ectoplasmic Resonator, Somatic Intensifier, Osseous Agitator + associated amounts of Runecloth
		Etc: Minion's Scourgestone, Invader's Scourgestone, Corruptor's Scourgestone, Argent Dawn Valor Token, Healthy Dragon Scale
	Timbermaw Hold:
		Winterfall Spirit Beads, Deadwood Headdress Feather, Winterfall Ritual Totem, Deadwood Ritual Totem
	Thorium Brotherhood:
		"Restoring Fiery Flux Supplies" turnin sets (only available at Neutral): Heavy Leather, Kingsblood, Iron Bar + associated amounts of Incendosaur Scale
		Dark Iron Residue (only available at Friendly)
		Dark Iron Ore, Core Leather, Fiery Core, Lava Core, Blood of the Mountain
	Darkmoon Faire (lower level turnins subject to max faction limits, as according to http://www.goblinworkshop.com/darkmoon-faire.html):
		Small Furry Paw, Torn Bear Pelt, Soft Bushy Tail, Vibrant Plume, Evil Bat Eye, Glowing Scorpid Blood
		Coarse Weightstone, Heavy Grinding Stone, Green Iron Bracers, Big Black Mace, Dense Grinding Stone
		Copper Modulator, Whirring Bronzze Gizmo, Green Firework, Mechanical Repair Kit, Thorium Widget
		Embossed Leather Boots, Toughened Leather Armor, Barbaric Harness, Turtle Scale Leggings, Rugged Armor Kit
	