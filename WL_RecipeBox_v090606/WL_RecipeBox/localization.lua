-- Deutsche Localization by Skulk
-- Version English

--list of tradeskills
RB_SkillList = {
  "Tailoring",
  "Alchemy",
  "Enchanting",
  "Cooking",
  "Blacksmithing",
  "First Aid",
  "Leatherworking",
  "Poisons",
  "Engineering",
  "Mining",
 };
RB_ENCHANTING = "Enchanting";

--Text for Buttons
RB_ADDTORB = "Add To RecipeBox";
RB_GATHERING = "Gathering Recipes";

--Text for keybindings
BINDING_HEADER_RECIPEBOX = "RecipeBox";
BINDING_NAME_RBTOGGLE = "Toggle RecipeBox Visibility";

--slash handlers
SLASH_RECIPEBOX1 = "/rbox";
SLASH_RECIPEBOX2 = "/rb";
SLASH_RECIPEBOXREALM1 = "/rbrealm";
SLASH_RECIPEBOXCHECK1 = "/rbcheck";
SLASH_RECIPEBOXOFFSET1 = "/rboffset";

RB_SELECTPLAYER = "Select Character";
RB_KNOWNRECIPES = "Known Recipes";
RB_SELECTTRADESKILL = "Select Tradeskill";

RB_DELETEALLYESYESYES = "deleteallyesyesyes";
RB_HELP = "help";
RB_REALMLIST = "realmlist";
RB_TEST = "test";

--messages
RB_CLEAREDOUT = "|cff00ff00Recipe Box Cleared Out, player data as well as local recipes";
RB_FOUNDIN = " found in";
RB_NOCHARACTERS = "|cff00ff00No characters found with ";
RB_NOCHARACTERS2 = " in their RecipeBox_ByPlayer.";
RB_INTERUPT = "|cff00ff00Recipe collection was interupted, ";
RB_INTERUPT2 = " was cleared.";
RB_INTERUPT3 = " recipes stored locally were cleared.";
RB_OUTOFDATE = "|cff00ff00RecipeBox version was out of date, RecipeBox data reset, all RB data cleared since recipe format changed, please re-aquire.";
RB_NOVERSION = "|cff00ff00RecipeBox version was missing, RecipeBox data reset, all RB data cleared since recipe format changed, please re-aquire.";
RB_FIRSTLOAD = "|cff00ff00RecipeBox loaded for first time and initialized";
RB_RECIPESIN = " recipes in ";
RB_RECIPESAND = " recipes, and ";
RB_RECIPESADDED = " reagents added to total recipe/reagent data";
RB_SAFE = "|cff00ff00Safe to close your ";
RB_WINDOW = " window.";
RB_INITIALIZED = "|cff00ff00RecipeBox data was not present, it has been initialized.";
RB_SLOWDOWN = "|cff00ff00Slow down, let the other addition you requested finish";
RB_DONOTCLOSETRADE = "|cff00ff00DO NOT CLOSE OR CHANGE tradeskill window until you see ending message.";
RB_SAFETOCLOSETRADE = "Need to open a tradeskill menu";
RB_DONOTCLOSECRAFT = "|cff00ff00DO NOT CLOSE Enchanting window until you see ending message.";
RB_SAFETOCLOSECRAFT = "Need to open a enchanting menu";

if(GetLocale() == "frFR") then
-- Version French

elseif(GetLocale() == "deDE") then
	-- Version German
	RB_SkillList = {
		"Schneidern",
		"Alchimie",
		"Verzauberkunst",
		"Kochkunst",
		"Schmiedekunst",
		"Erste Hilfe",
		"Lederverarbeitung",
		"Gifte",
		"Ingenieurskunst",
	  "Bergbau",
		};
	RB_ENCHANTING = "Verzauberkunst";
end