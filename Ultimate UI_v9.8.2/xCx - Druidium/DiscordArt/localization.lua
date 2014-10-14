DART_VERSION = "1.4";
DART_DL_VERSION = 1.34;

BINDING_HEADER_DART = "Discord Art v"..DART_VERSION;
BINDING_HEADER_DART_TEXTURES = "Texture Bindings";
BINDING_NAME_DART_OPTIONS = "Toggle Options Window";
DART_ANCHORHEADER = "ANCHORS";
DART_ANCHORHEADER_FRAME = "Frame";
DART_ANCHORHEADER_POINT = "Point";
DART_ANCHORHEADER_TO = "To";
DART_ANCHORHEADER_X = "X";
DART_ANCHORHEADER_Y = "Y";
DART_CLICKTOSET = "Click to Set Texture";
DART_COORDSHEADER = "Coords:";
DART_COPYTEXT = "COPY";
DART_PASTETEXT = "PASTE";
DART_TEXTUREBROWSERHEADER = "TEXTURE BROWSER";

DART_TEXT = {
	AddTexture = "Add Texture",
	Alpha = "Alpha",
	Appearance = "APPEARANCE",
	AutoLock = "Auto-Lock Dragging",
	Backdrp = "Backdrop",
	BackgroundAlpha = "Background Alpha",
	BackgroundColor = "Background Color",
	BackgroundTexture = "Background Texture",
	BorderAlpha = "Border Alpha",
	BorderColor = "Border Color",
	BorderTexture = "Border Texture",
	CantDeleteCurrent = "You cannot delete the profile currently in use.",
	CantDeleteDefault = "You cannot delete the default profile.",
	Create = "CREATE",
	CurrentProfile = "Curent Profile: |cFFCCCC00",
	Custom = "Custom",
	Default = "Default",
	Delete = "DELETE",
	DisableMouse = "Disable Mouse",
	DisableMousewheel = "Disable Mousewheel",
	DragWarning = "Textures anchored to 2 or more points cannot be dragged.",
	EdgSize = "Edge Size",
	File = "File",
	Font = "Font:",
	FontSize = "Font Size",
	FrameFinder = "|cFFCCCC00Mouse Is Over This Frame:\n|cFFFFFFFF",
	FrameLevel = "Frame Level Offset",
	Height = "Height",
	Hide = "Hide",
	HideBackground = "Hide Background",
	HideText = "Hide Text",
	Highlight = "Highlight on Mouseover",
	HighlightAlpha = "Highlight Alpha",
	HLColor = "Highlight Color",
	HLTexture = "Highlight Texture",
	InsetBottom = "Inset Bottom",
	InsetLeft = "Inset Left",
	InsetRight = "Inset Right",
	InsetTop = "Inset Top",
	JustifyH = "Horizontal Justification",
	JustifyV = "Vertical Justification",
	LockDragging = "Lock Dragging",
	MiscOptions = "Misc Options",
	MoveAnchor = "Move Anchor",
	Name = "Name:",
	NewProfile = "New Profile:",
	NewProfileCreated = "New profile created: ",
	OptionsScale = "Options Scale",
	Padding = "Padding",
	Parent = "\n|cFFCCCC00Parent: |cFFFFFFFF",
	ParentFrame = "Parent Frame",
	ParentsParent = "\n|cFFCCCC00Parent's Parent: |cFFFFFFFF",
	PresetBackdrops = "Preset Backdrops",
	ProfileDeleted = "Profile deleted: ",
	ProfileLoaded = "Profile loaded: ",
	Scale = "Scale",
	Scripts = "SCRIPTS",
	SelectTexture = "Select Texture:",
	Set = "LOAD",
	SetProfile = "Set Profile:",
	Strata = "Frame Strata:",
	Text = "Text:",
	Text2 = "Text",
	TextAlpha = "Text Alpha",
	TextColor = "Text Color",
	TextHeight = "Text Height",
	Texture = "Texture ",
	Texture2 = "Texture",
	TextureColor = "Texture Color",
	TextureOptions = "Texture Options",
	TextWidth = "Text Width",
	Tile = "Tile",
	TileSize = "Tile Size",
	UnlockDragging = "Unlock Dragging",
	UpdatesPerSec = "Updates Per Second",
	Width = "Width",
	X1 = "ULx or X1",
	X2 = "ULy or X2",
	Y1 = "LLx or Y1",
	Y2 = "LLy or Y2",
	URX = "URx",
	URY = "URy",
	LRX = "LRx",
	LRY = "LRy",
	CoordX1 = "X1",
	CoordX2 = "X2",
	CoordY1 = "Y1",
	CoordY2 = "Y2",
	DefaultUI = "Default UI",
	MacroIcons = "Macro Icons",
	TextureTip = "Left-click to select.\nRight-click to 'sticky' texture stats.",
	CustomTextureTip = "\nMiddle-click or shift + right-click to delete."
}

DART_ANCHORS = {
		{ text = "TOPLEFT", value = 1 },
		{ text = "TOP", value = 2 },
		{ text = "TOPRIGHT", value = 3 },
		{ text = "LEFT", value = 4 },
		{ text = "CENTER", value = 5 },
		{ text = "RIGHT", value = 6 },
		{ text = "BOTTOMLEFT", value = 7 },
		{ text = "BOTTOM", value = 8 },
		{ text = "BOTTOMRIGHT", value = 9 }
	 }

DART_NUDGE_INDICES = {
	{ text=1, value=1 },
	{ text=2, value=2 },
	{ text=3, value=3 },
	{ text=4, value=4 },
	{ text="Text", value=5 }
}

DART_JUSTIFY_H = {
	{ text="LEFT", value=4 },
	{ text="CENTER", value=5 },
	{ text="RIGHT", value=6 }
}

DART_JUSTIFY_V = {
	{ text="TOP", value=2 },
	{ text="CENTER", value=5 },
	{ text="BOTTOM", value=8 }
}

DART_BACKDROPS = {
	{ text="Plain", value=1 },
	{ text="Tooltip", value=2 },
	{ text="Dialogue", value=3 },
	{ text="Slider", value=4 },
	{ text="Glue Tooltip", value=5 }
}

-- Globals, do not translate
DART_INDEX = nil;
DART_NUDGE_INDEX = 1;
DART_NUMBER_OF_SCRIPTS = 14;
DART_PROFILE_INDEX = nil;
DART_STICKY_TEXTURE = {file="", x1="0", x2="1", y1="0", y2="1", height="256", width="256"};
DART_TEXTURE_INDEX = 1;

DART_ATTACH_POINTS = { "TOPLEFT", "TOP", "TOPRIGHT", "LEFT", "CENTER", "RIGHT", "BOTTOMLEFT", "BOTTOM", "BOTTOMRIGHT" }
DART_NUDGE_TEXT = { "<", ">", "^", "v" }

DART_OPTIONS_SCALES = {
	{ text=100, value=1 },
	{ text=90, value=.9 },
	{ text=80, value=.8 },
	{ text=70, value=.7 },
	{ text=60, value=.6 },
	{ text=50, value=.5 },
	{ text=40, value=.4 },
	{ text=30, value=.3 },
	{ text=20, value=.2 },
	{ text=10, value=.1 }
}

DART_SCRIPT_LABEL = {
		"OnUpdate",
		"OnEvent",
		"OnEnter",
		"OnLeave",
		"OnShow",
		"OnHide",
		"OnClick",
		"OnMouseUp",
		"OnMouseDown",
		"KeybindingDown",
		"KeybindingUp",
		"OnMouseWheel",
		"OnReceiveDrag",
		"OnLoad"
}