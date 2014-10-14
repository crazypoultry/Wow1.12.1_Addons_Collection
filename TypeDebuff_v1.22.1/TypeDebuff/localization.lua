--Version--------------------------------------------------
TYPEDEBUFF_VERSION = "v1.22";
TYPEDEBUFF_RELEASE = "13 October 2005";

--English--------------------------------------------------
if (GetLocale() == "enUS") then
	
	TYPEDEBUFF_POISON = "Poison";
	TYPEDEBUFF_DISEASE = "Disease";
	TYPEDEBUFF_CURSE = "Curse";
	TYPEDEBUFF_MAGIC = "Magic";
	
		-- Bindings	
	BINDING_HEADER_TYPEDEBUFFHEADER = "TypeDebuff";
	BINDING_NAME_TYPEDEBUFF = "TypeDebuff options menu.";
	BINDING_CATEGORY_TYPEDEBUFFHEADER = "interface";
	
	-- myAddons Help
	TypeDebuffHelp = {};
	TypeDebuffHelp[1] = "|cff00ff00TypeDebuff Help|r\n\nType |cffffff00/typedebuff|r or |cffffff00/td|r to open the options menu.";
	
	-- Options
	TYPEDEBUFFOPTIONS_TITLE = "TypeDebuff Options";
	TYPEDEBUFFOPTIONS_GENERAL = "General";
	TYPEDEBUFFOPTIONS_TEXTOPTIONS = "Text Options";
	TYPEDEBUFFOPTIONS_TEXTPOISON = "Poison Text";
	TYPEDEBUFFOPTIONS_TEXTDISEASE = "Disease Text";
	TYPEDEBUFFOPTIONS_TEXTCURSE = "Curse Text";
	TYPEDEBUFFOPTIONS_TEXTMAGIC = "Magic Text";
	TYPEDEBUFFOPTIONS_DEFAULT = "Default";
	TYPEDEBUFFOPTIONS_CLOSE = "Close";
	TYPEDEBUFFOPTIONS_COLORWATCH1 = {name = "Poison", tooltipText = "Change the color of the text of the Poison debuff."};
	TYPEDEBUFFOPTIONS_COLORWATCH2 = {name = "Disease", tooltipText = "Change the color of the text of the Disease debuff."};
	TYPEDEBUFFOPTIONS_COLORWATCH3 = {name = "Curse", tooltipText = "Change the color of the text of the Curse debuff."};
	TYPEDEBUFFOPTIONS_COLORWATCH4 = {name = "Magic", tooltipText = "Change the color of the text of the Magic debuff."};
	TYPEDEBUFFOPTIONS_SLIDER1 = { name = "Poison Horizontal", minText = "-32", maxText = "32", tooltipText = "Move the Poison text Horizontally."};
	TYPEDEBUFFOPTIONS_SLIDER2 = { name = "Poison Vertical", minText = "-32", maxText = "32", tooltipText = "Move the Poison text Vertically."};
	TYPEDEBUFFOPTIONS_SLIDER3 = { name = "Disease Horizontal", minText = "-32", maxText = "32", tooltipText = "Move the Disease text Horizontally."};
	TYPEDEBUFFOPTIONS_SLIDER4 = { name = "Disease Vertical", minText = "-32", maxText = "32", tooltipText = "Move the Disease text Vertically."};
	TYPEDEBUFFOPTIONS_SLIDER5 = { name = "Curse Horizontal", minText = "-32", maxText = "32", tooltipText = "Move the Curse text Horizontally."};
	TYPEDEBUFFOPTIONS_SLIDER6 = { name = "Curse Vertical", minText = "-32", maxText = "32", tooltipText = "Move the Curse text Vertically."};
	TYPEDEBUFFOPTIONS_SLIDER7 = { name = "Magic Horizontal", minText = "-32", maxText = "32", tooltipText = "Move the Magic text Horizontally."};
	TYPEDEBUFFOPTIONS_SLIDER8 = { name = "Magic Vertical", minText = "-32", maxText = "32", tooltipText = "Move the Magic text Vertically."};
	TYPEDEBUFFOPTIONS_SLIDER9 = { name = "Poison Size", minText = "6", maxText = "32", tooltipText = "Change the size of the Poison font."};
	TYPEDEBUFFOPTIONS_SLIDER10 = { name = "Disease Size", minText = "6", maxText = "32", tooltipText = "Change the size of the Disease font."};
	TYPEDEBUFFOPTIONS_SLIDER11 = { name = "Curse Size", minText = "6", maxText = "32", tooltipText = "Change the size of the Curse font."};
	TYPEDEBUFFOPTIONS_SLIDER12 = { name = "Magic Size", minText = "6", maxText = "32", tooltipText = "Change the size of the Magic font."};
	TYPEDEBUFFOPTIONS_CHECK1 = { name = "Enable", tooltipText = "Enable the TypeDebuff addon."};
	TYPEDEBUFFOPTIONS_CHECK2 = { name = "Text", tooltipText = "Show the text of the debuff."};
	TYPEDEBUFFOPTIONS_CHECK3 = { name = "Icon", tooltipText = "Incoming feature, stay tunned ..."};
	TYPEDEBUFFOPTIONS_CHECK4 = { name = "Poison", tooltipText = "Show the text of the Poison debuff."};
	TYPEDEBUFFOPTIONS_CHECK5 = { name = "Disease", tooltipText = "Show the text of the Disease debuff."};
	TYPEDEBUFFOPTIONS_CHECK6 = { name = "Curse", tooltipText = "Show the text of the Curse debuff."};
	TYPEDEBUFFOPTIONS_CHECK7 = { name = "Magic", tooltipText = "Show the text of the Magic debuff."};
	TYPEDEBUFFOPTIONS_EDITBOX1 = { name = "Poison" };
	TYPEDEBUFFOPTIONS_EDITBOX2 = { name = "Disease" };
	TYPEDEBUFFOPTIONS_EDITBOX3 = { name = "Curse" };
	TYPEDEBUFFOPTIONS_EDITBOX4 = { name = "Magic" };
	TYPEDEBUFFOPTIONS_DROPDOWNNAME1 = "Poison Font";
	TYPEDEBUFFOPTIONS_DROPDOWNNAME2 = "Disease Font";
	TYPEDEBUFFOPTIONS_DROPDOWNNAME3 = "Curse Font";
	TYPEDEBUFFOPTIONS_DROPDOWNNAME4 = "Magic Font";
	TYPEDEBUFFOPTIONS_DROPDOWN11 = { name="Arial", tooltipText = "This is the font for Poison."};
	TYPEDEBUFFOPTIONS_DROPDOWN12 = { name="Frizqt", tooltipText = "This is the font for Poison."};
	TYPEDEBUFFOPTIONS_DROPDOWN13 = { name="Morpheus", tooltipText = "This is the font for Poison."};
	TYPEDEBUFFOPTIONS_DROPDOWN14 = { name="Skurri", tooltipText = "This is the font for Poison."};
	TYPEDEBUFFOPTIONS_DROPDOWN21 = { name="Arial", tooltipText = "This is the font for Disease."};
	TYPEDEBUFFOPTIONS_DROPDOWN22 = { name="Frizqt", tooltipText = "This is the font for Disease."};
	TYPEDEBUFFOPTIONS_DROPDOWN23 = { name="Morpheus", tooltipText = "This is the font for Disease."};
	TYPEDEBUFFOPTIONS_DROPDOWN24 = { name="Skurri", tooltipText = "This is the font for Disease."};
	TYPEDEBUFFOPTIONS_DROPDOWN31 = { name="Arial", tooltipText = "This is the font for Curse."};
	TYPEDEBUFFOPTIONS_DROPDOWN32 = { name="Frizqt", tooltipText = "This is the font for Curse."};
	TYPEDEBUFFOPTIONS_DROPDOWN33 = { name="Morpheus", tooltipText = "This is the font for Curse."};
	TYPEDEBUFFOPTIONS_DROPDOWN34 = { name="Skurri", tooltipText = "This is the font for Curse."};
	TYPEDEBUFFOPTIONS_DROPDOWN41 = { name="Arial", tooltipText = "This is the font for Magic."};
	TYPEDEBUFFOPTIONS_DROPDOWN42 = { name="Frizqt", tooltipText = "This is the font for Magic."};
	TYPEDEBUFFOPTIONS_DROPDOWN43 = { name="Morpheus", tooltipText = "This is the font for Magic."};
	TYPEDEBUFFOPTIONS_DROPDOWN44 = { name="Skurri", tooltipText = "This is the font for Magic."};
	TYPEDEBUFFOPTIONS_RESETTOOLTIPTEXT = "This will load the default options.";

end

--German---------------------------------------------------
if (GetLocale() == "deDE") then

	-- translated by kevdamaster
	TYPEDEBUFF_POISON = "Gift";
	TYPEDEBUFF_DISEASE = "Krankheit";
	TYPEDEBUFF_CURSE = "Fluch";
	TYPEDEBUFF_MAGIC = "Magie";
	
		-- Bindings	
	BINDING_HEADER_TYPEDEBUFFHEADER = "TypeDebuff";
	BINDING_NAME_TYPEDEBUFF = "TypeDebuff options menu.";
	BINDING_CATEGORY_TYPEDEBUFFHEADER = "interface";
	
	-- myAddons Help
	TypeDebuffHelp = {};
	TypeDebuffHelp[1] = "|cff00ff00TypeDebuff Help|r\n\nType |cffffff00/typedebuff|r or |cffffff00/td|r to open the options menu.";

	-- Options
	TYPEDEBUFFOPTIONS_TITLE = "TypeDebuff Options";
	TYPEDEBUFFOPTIONS_GENERAL = "General";
	TYPEDEBUFFOPTIONS_TEXTOPTIONS = "Text Options";
	TYPEDEBUFFOPTIONS_TEXTPOISON = "Poison Text";
	TYPEDEBUFFOPTIONS_TEXTDISEASE = "Disease Text";
	TYPEDEBUFFOPTIONS_TEXTCURSE = "Curse Text";
	TYPEDEBUFFOPTIONS_TEXTMAGIC = "Magic Text";
	TYPEDEBUFFOPTIONS_DEFAULT = "Default";
	TYPEDEBUFFOPTIONS_CLOSE = "Close";
	TYPEDEBUFFOPTIONS_COLORWATCH1 = {name = "Poison", tooltipText = "Change the color of the text of the Poison debuff."};
	TYPEDEBUFFOPTIONS_COLORWATCH2 = {name = "Disease", tooltipText = "Change the color of the text of the Disease debuff."};
	TYPEDEBUFFOPTIONS_COLORWATCH3 = {name = "Curse", tooltipText = "Change the color of the text of the Curse debuff."};
	TYPEDEBUFFOPTIONS_COLORWATCH4 = {name = "Magic", tooltipText = "Change the color of the text of the Magic debuff."};
	TYPEDEBUFFOPTIONS_SLIDER1 = { name = "Poison Horizontal", minText = "-32", maxText = "32", tooltipText = "Move the Poison text Horizontally."};
	TYPEDEBUFFOPTIONS_SLIDER2 = { name = "Poison Vertical", minText = "-32", maxText = "32", tooltipText = "Move the Poison text Vertically."};
	TYPEDEBUFFOPTIONS_SLIDER3 = { name = "Disease Horizontal", minText = "-32", maxText = "32", tooltipText = "Move the Disease text Horizontally."};
	TYPEDEBUFFOPTIONS_SLIDER4 = { name = "Disease Vertical", minText = "-32", maxText = "32", tooltipText = "Move the Disease text Vertically."};
	TYPEDEBUFFOPTIONS_SLIDER5 = { name = "Curse Horizontal", minText = "-32", maxText = "32", tooltipText = "Move the Curse text Horizontally."};
	TYPEDEBUFFOPTIONS_SLIDER6 = { name = "Curse Vertical", minText = "-32", maxText = "32", tooltipText = "Move the Curse text Vertically."};
	TYPEDEBUFFOPTIONS_SLIDER7 = { name = "Magic Horizontal", minText = "-32", maxText = "32", tooltipText = "Move the Magic text Horizontally."};
	TYPEDEBUFFOPTIONS_SLIDER8 = { name = "Magic Vertical", minText = "-32", maxText = "32", tooltipText = "Move the Magic text Vertically."};
	TYPEDEBUFFOPTIONS_SLIDER9 = { name = "Poison Size", minText = "6", maxText = "32", tooltipText = "Change the size of the Poison font."};
	TYPEDEBUFFOPTIONS_SLIDER10 = { name = "Disease Size", minText = "6", maxText = "32", tooltipText = "Change the size of the Disease font."};
	TYPEDEBUFFOPTIONS_SLIDER11 = { name = "Curse Size", minText = "6", maxText = "32", tooltipText = "Change the size of the Curse font."};
	TYPEDEBUFFOPTIONS_SLIDER12 = { name = "Magic Size", minText = "6", maxText = "32", tooltipText = "Change the size of the Magic font."};
	TYPEDEBUFFOPTIONS_CHECK1 = { name = "Enable", tooltipText = "Enable the TypeDebuff addon."};
	TYPEDEBUFFOPTIONS_CHECK2 = { name = "Text", tooltipText = "Show the text of the debuff."};
	TYPEDEBUFFOPTIONS_CHECK3 = { name = "Icon", tooltipText = "Incoming feature, stay tunned ..."};
	TYPEDEBUFFOPTIONS_CHECK4 = { name = "Poison", tooltipText = "Show the text of the Poison debuff."};
	TYPEDEBUFFOPTIONS_CHECK5 = { name = "Disease", tooltipText = "Show the text of the Disease debuff."};
	TYPEDEBUFFOPTIONS_CHECK6 = { name = "Curse", tooltipText = "Show the text of the Curse debuff."};
	TYPEDEBUFFOPTIONS_CHECK7 = { name = "Magic", tooltipText = "Show the text of the Magic debuff."};
	TYPEDEBUFFOPTIONS_EDITBOX1 = { name = "Poison" };
	TYPEDEBUFFOPTIONS_EDITBOX2 = { name = "Disease" };
	TYPEDEBUFFOPTIONS_EDITBOX3 = { name = "Curse" };
	TYPEDEBUFFOPTIONS_EDITBOX4 = { name = "Magic" };
	TYPEDEBUFFOPTIONS_DROPDOWNNAME1 = "Poison Font";
	TYPEDEBUFFOPTIONS_DROPDOWNNAME2 = "Disease Font";
	TYPEDEBUFFOPTIONS_DROPDOWNNAME3 = "Curse Font";
	TYPEDEBUFFOPTIONS_DROPDOWNNAME4 = "Magic Font";
	TYPEDEBUFFOPTIONS_DROPDOWN11 = { name="Arial", tooltipText = "This is the font for Poison."};
	TYPEDEBUFFOPTIONS_DROPDOWN12 = { name="Frizqt", tooltipText = "This is the font for Poison."};
	TYPEDEBUFFOPTIONS_DROPDOWN13 = { name="Morpheus", tooltipText = "This is the font for Poison."};
	TYPEDEBUFFOPTIONS_DROPDOWN14 = { name="Skurri", tooltipText = "This is the font for Poison."};
	TYPEDEBUFFOPTIONS_DROPDOWN21 = { name="Arial", tooltipText = "This is the font for Disease."};
	TYPEDEBUFFOPTIONS_DROPDOWN22 = { name="Frizqt", tooltipText = "This is the font for Disease."};
	TYPEDEBUFFOPTIONS_DROPDOWN23 = { name="Morpheus", tooltipText = "This is the font for Disease."};
	TYPEDEBUFFOPTIONS_DROPDOWN24 = { name="Skurri", tooltipText = "This is the font for Disease."};
	TYPEDEBUFFOPTIONS_DROPDOWN31 = { name="Arial", tooltipText = "This is the font for Curse."};
	TYPEDEBUFFOPTIONS_DROPDOWN32 = { name="Frizqt", tooltipText = "This is the font for Curse."};
	TYPEDEBUFFOPTIONS_DROPDOWN33 = { name="Morpheus", tooltipText = "This is the font for Curse."};
	TYPEDEBUFFOPTIONS_DROPDOWN34 = { name="Skurri", tooltipText = "This is the font for Curse."};
	TYPEDEBUFFOPTIONS_DROPDOWN41 = { name="Arial", tooltipText = "This is the font for Magic."};
	TYPEDEBUFFOPTIONS_DROPDOWN42 = { name="Frizqt", tooltipText = "This is the font for Magic."};
	TYPEDEBUFFOPTIONS_DROPDOWN43 = { name="Morpheus", tooltipText = "This is the font for Magic."};
	TYPEDEBUFFOPTIONS_DROPDOWN44 = { name="Skurri", tooltipText = "This is the font for Magic."};
	TYPEDEBUFFOPTIONS_RESETTOOLTIPTEXT = "This will load the default options.";

end

--French---------------------------------------------------
if (GetLocale() == "frFR") then

	--language specific charcodes
	agrave = "\195\160";
	acirc = "\195\162";
	ccedil = "\195\167";
	eaigu = "\195\169";
	egrave = "\195\168";
	ecirc = "\195\170";
	etrem = "\195\171";
	icirc = "\195\174";
	itrem = "\195\175";
	ocirc = "\195\180";
	ugrave = "\195\185";
	ucirc = "\195\187";
	utrem = "\195\188";
	ytrem = "\195\191";
	apost = "\194\180";

	TYPEDEBUFF_POISON = "Poison";
	TYPEDEBUFF_DISEASE = "Maladie";
	TYPEDEBUFF_CURSE = "Mal"..eaigu.."diction";
	TYPEDEBUFF_MAGIC = "Magie";
	
		-- Bindings	
	BINDING_HEADER_TYPEDEBUFFHEADER = "TypeDebuff";
	BINDING_NAME_TYPEDEBUFF = "TypeDebuff options menu.";
	BINDING_CATEGORY_TYPEDEBUFFHEADER = "interface";
	
	-- myAddons Help
	TypeDebuffHelp = {};
	TypeDebuffHelp[1] = "|cff00ff00TypeDebuff Help|r\n\nType |cffffff00/typedebuff|r or |cffffff00/td|r to open the options menu.";

	-- Options
	TYPEDEBUFFOPTIONS_TITLE = "TypeDebuff Options";
	TYPEDEBUFFOPTIONS_GENERAL = "General";
	TYPEDEBUFFOPTIONS_TEXTOPTIONS = "Text Options";
	TYPEDEBUFFOPTIONS_TEXTPOISON = "Poison Text";
	TYPEDEBUFFOPTIONS_TEXTDISEASE = "Disease Text";
	TYPEDEBUFFOPTIONS_TEXTCURSE = "Curse Text";
	TYPEDEBUFFOPTIONS_TEXTMAGIC = "Magic Text";
	TYPEDEBUFFOPTIONS_DEFAULT = "Default";
	TYPEDEBUFFOPTIONS_CLOSE = "Close";
	TYPEDEBUFFOPTIONS_COLORWATCH1 = {name = "Poison", tooltipText = "Change the color of the text of the Poison debuff."};
	TYPEDEBUFFOPTIONS_COLORWATCH2 = {name = "Disease", tooltipText = "Change the color of the text of the Disease debuff."};
	TYPEDEBUFFOPTIONS_COLORWATCH3 = {name = "Curse", tooltipText = "Change the color of the text of the Curse debuff."};
	TYPEDEBUFFOPTIONS_COLORWATCH4 = {name = "Magic", tooltipText = "Change the color of the text of the Magic debuff."};
	TYPEDEBUFFOPTIONS_SLIDER1 = { name = "Poison Horizontal", minText = "-32", maxText = "32", tooltipText = "Move the Poison text Horizontally."};
	TYPEDEBUFFOPTIONS_SLIDER2 = { name = "Poison Vertical", minText = "-32", maxText = "32", tooltipText = "Move the Poison text Vertically."};
	TYPEDEBUFFOPTIONS_SLIDER3 = { name = "Disease Horizontal", minText = "-32", maxText = "32", tooltipText = "Move the Disease text Horizontally."};
	TYPEDEBUFFOPTIONS_SLIDER4 = { name = "Disease Vertical", minText = "-32", maxText = "32", tooltipText = "Move the Disease text Vertically."};
	TYPEDEBUFFOPTIONS_SLIDER5 = { name = "Curse Horizontal", minText = "-32", maxText = "32", tooltipText = "Move the Curse text Horizontally."};
	TYPEDEBUFFOPTIONS_SLIDER6 = { name = "Curse Vertical", minText = "-32", maxText = "32", tooltipText = "Move the Curse text Vertically."};
	TYPEDEBUFFOPTIONS_SLIDER7 = { name = "Magic Horizontal", minText = "-32", maxText = "32", tooltipText = "Move the Magic text Horizontally."};
	TYPEDEBUFFOPTIONS_SLIDER8 = { name = "Magic Vertical", minText = "-32", maxText = "32", tooltipText = "Move the Magic text Vertically."};
	TYPEDEBUFFOPTIONS_SLIDER9 = { name = "Poison Size", minText = "6", maxText = "32", tooltipText = "Change the size of the Poison font."};
	TYPEDEBUFFOPTIONS_SLIDER10 = { name = "Disease Size", minText = "6", maxText = "32", tooltipText = "Change the size of the Disease font."};
	TYPEDEBUFFOPTIONS_SLIDER11 = { name = "Curse Size", minText = "6", maxText = "32", tooltipText = "Change the size of the Curse font."};
	TYPEDEBUFFOPTIONS_SLIDER12 = { name = "Magic Size", minText = "6", maxText = "32", tooltipText = "Change the size of the Magic font."};
	TYPEDEBUFFOPTIONS_CHECK1 = { name = "Enable", tooltipText = "Enable the TypeDebuff addon."};
	TYPEDEBUFFOPTIONS_CHECK2 = { name = "Text", tooltipText = "Show the text of the debuff."};
	TYPEDEBUFFOPTIONS_CHECK3 = { name = "Icon", tooltipText = "Incoming feature, stay tunned ..."};
	TYPEDEBUFFOPTIONS_CHECK4 = { name = "Poison", tooltipText = "Show the text of the Poison debuff."};
	TYPEDEBUFFOPTIONS_CHECK5 = { name = "Disease", tooltipText = "Show the text of the Disease debuff."};
	TYPEDEBUFFOPTIONS_CHECK6 = { name = "Curse", tooltipText = "Show the text of the Curse debuff."};
	TYPEDEBUFFOPTIONS_CHECK7 = { name = "Magic", tooltipText = "Show the text of the Magic debuff."};
	TYPEDEBUFFOPTIONS_EDITBOX1 = { name = "Poison" };
	TYPEDEBUFFOPTIONS_EDITBOX2 = { name = "Disease" };
	TYPEDEBUFFOPTIONS_EDITBOX3 = { name = "Curse" };
	TYPEDEBUFFOPTIONS_EDITBOX4 = { name = "Magic" };
	TYPEDEBUFFOPTIONS_DROPDOWNNAME1 = "Poison Font";
	TYPEDEBUFFOPTIONS_DROPDOWNNAME2 = "Disease Font";
	TYPEDEBUFFOPTIONS_DROPDOWNNAME3 = "Curse Font";
	TYPEDEBUFFOPTIONS_DROPDOWNNAME4 = "Magic Font";
	TYPEDEBUFFOPTIONS_DROPDOWN11 = { name="Arial", tooltipText = "This is the font for Poison."};
	TYPEDEBUFFOPTIONS_DROPDOWN12 = { name="Frizqt", tooltipText = "This is the font for Poison."};
	TYPEDEBUFFOPTIONS_DROPDOWN13 = { name="Morpheus", tooltipText = "This is the font for Poison."};
	TYPEDEBUFFOPTIONS_DROPDOWN14 = { name="Skurri", tooltipText = "This is the font for Poison."};
	TYPEDEBUFFOPTIONS_DROPDOWN21 = { name="Arial", tooltipText = "This is the font for Disease."};
	TYPEDEBUFFOPTIONS_DROPDOWN22 = { name="Frizqt", tooltipText = "This is the font for Disease."};
	TYPEDEBUFFOPTIONS_DROPDOWN23 = { name="Morpheus", tooltipText = "This is the font for Disease."};
	TYPEDEBUFFOPTIONS_DROPDOWN24 = { name="Skurri", tooltipText = "This is the font for Disease."};
	TYPEDEBUFFOPTIONS_DROPDOWN31 = { name="Arial", tooltipText = "This is the font for Curse."};
	TYPEDEBUFFOPTIONS_DROPDOWN32 = { name="Frizqt", tooltipText = "This is the font for Curse."};
	TYPEDEBUFFOPTIONS_DROPDOWN33 = { name="Morpheus", tooltipText = "This is the font for Curse."};
	TYPEDEBUFFOPTIONS_DROPDOWN34 = { name="Skurri", tooltipText = "This is the font for Curse."};
	TYPEDEBUFFOPTIONS_DROPDOWN41 = { name="Arial", tooltipText = "This is the font for Magic."};
	TYPEDEBUFFOPTIONS_DROPDOWN42 = { name="Frizqt", tooltipText = "This is the font for Magic."};
	TYPEDEBUFFOPTIONS_DROPDOWN43 = { name="Morpheus", tooltipText = "This is the font for Magic."};
	TYPEDEBUFFOPTIONS_DROPDOWN44 = { name="Skurri", tooltipText = "This is the font for Magic."};
	TYPEDEBUFFOPTIONS_RESETTOOLTIPTEXT = "This will load the default options.";

end