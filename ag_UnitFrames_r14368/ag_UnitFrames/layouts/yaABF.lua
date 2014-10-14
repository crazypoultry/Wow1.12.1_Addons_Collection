local L = AceLibrary("AceLocale-2.2"):new("ag_UnitFrames")

aUF.Layouts.yaABF = {
	Name = "yaABF",
	Tip = "yet another abf style",
	ResizeBars = false,
	BackgroundBarColor = true,
	AlphaBar = true,
	RaidColorName = true,
	PetClassName = true,	
	ComboGFX = true,
	HappinessBar = true,
	
	ThemeData = {
		all = {
			FrameHeight = 26,
			FrameWidth = 140,

			Combo1 = 	{ 		Point = "BOTTOMRIGHT",
								RelativePoint = "BOTTOMRIGHT",
								x = 1,
								y = -1,	
								Height = 10,
								HeightAdd = 0,									
								Width = 10,
							},
							
			HealthBar_BG = 	{ 	Point = "TOPLEFT",
								RelativePoint = "TOPLEFT",
								x = 5,
								y = -5,	
								Visibility = {"HealthBar_BG","HealthBar","BarHealthText","HealthText",},
								Height = 15,
								HeightAdd = 0,									
								PetAdjust = -4,
								Width = 90,
							},
								
			ManaBar_BG = 	{	Point = "TOPLEFT",
								RelativePoint = "TOPLEFT", 
								x = 5, 
								y = -21, 
								HeightAdd = 11,
								Visibility = {"ManaBar_BG","ManaBar","BarManaText","ManaText","ClassText",},	
								Height = 11,
								Width = 90,
							},
							
			XPBar_BG = 		{	Point = "TOPLEFT", 
								RelativeTo = "ManaBar_BG", 
								RelativeTo2 = "HealthBar_BG", 
								RelativePoint = "BOTTOMLEFT", 
								x = 0, 
								y = -1, 
								HeightAdd = 5,
								Visibility = {"XPBar_BG","XPBar",},	
								Width = 90,
								Height = 4,
							},
			
			XPBar = 		{	Width = 90,
							},
							
			XPBar_Rest = 	{	Width = 90,
							},
								
			NameBackground=	{	Hidden = true,
							},
							
				Happiness =	{	Point = "TOPLEFT",
								RelativeTo = "HealthBar_BG",
								RelativePoint = "TOPLEFT", 
								x=0,
								y=0,
								Height = 15,
								Width = 90,
								Visibility = {"Happiness",},
							},
							
			NameLabel = 	{ 	Font = "Interface\\AddOns\\ag_UnitFrames\\fonts\\yabf.ttf", 
								FontSize = 9, 
								Width = 90, 
								Point = "LEFT", 
								RelativeTo = "HealthBar", 
								RelativePoint = "LEFT", 
								x = 2, 
								y = 1,
							},
			
			ClassText =	 	{ 	Font = "Interface\\AddOns\\ag_UnitFrames\\fonts\\yabf.ttf",
								FontSize = 9, 
								Hidden = true,
							},
				
			HealthText = 	{ 	Font = "Interface\\AddOns\\ag_UnitFrames\\fonts\\yabf.ttf", 
								FontSize = 9,
								Point = "RIGHT", 
								RelativeTo = "HealthBar_BG", 
								RelativePoint = "RIGHT", 
								x = -2,
								y = 1,
							},
				
			ManaText = 		{ 	Font = "Interface\\AddOns\\ag_UnitFrames\\fonts\\yabf.ttf", 
								FontSize = 9,
								Point = "RIGHT", 
								RelativeTo = "ManaBar_BG", 
								RelativePoint = "RIGHT", 
								x = -2,
								y = 1,
							},
								
			BarHealthText = { 	Font = "Interface\\AddOns\\ag_UnitFrames\\fonts\\yabf.ttf", 
								FontSize = 9,
							},
								
			BarManaText = 	{ 	Font = "Interface\\AddOns\\ag_UnitFrames\\fonts\\yabf.ttf", 
								FontSize = 9,
							},
			
			PVPIcon = 		{ 	Point = "TOPRIGHT", 
								RelativePoint = "TOPRIGHT", 
								x = 0, 
								y= 4,
						},

			InCombatIcon = 		{ 	Point = "TOPRIGHT", 
								RelativePoint = "TOPRIGHT", 
								x = 7, 
								y= 4,
							},

			RestingIcon = 		{ 	Point = "TOPRIGHT", 
								RelativePoint = "TOPRIGHT", 
								x = 5, 
								y= 6,
						},

			RaidTargetIcon =	{	Point = "CENTER",
								RelativePoint = "TOP",
								x = 0,
								y = -3,
							},
							
			LeaderIcon = 	{ 	Point = "TOPLEFT", 
								RelativePoint = "TOPLEFT", 
								x = -2, 
								y = 2,
							},
							
			MasterIcon = 	{ 	Point = "TOPLEFT", 
								RelativePoint = "TOPLEFT", 
								x = -5, 
								y = 2,
							},
		},
		target = {				
			ManaBar_BG = 	{	Visibility = {"ManaBar_BG","ManaBar","BarManaText","ManaText","ClassText",},	
							},
			ClassText =	 	{ 	Font = "Interface\\AddOns\\ag_UnitFrames\\fonts\\yabf.ttf",
								FontSize = 9, 
								Justify = "LEFT",
								Width = 85, 
								Point = "LEFT", 
								RelativeTo = "ManaBar", 
								RelativePoint = "LEFT", 
								x = 2, 
								y = 1,
								Hidden = false,
							},
		},
		targettarget = {
			ManaBar_BG = 	{	Visibility = {"ManaBar_BG","ManaBar","BarManaText","ManaText","ClassText",},	
							},
			ClassText =	 	{ 	Font = "Interface\\AddOns\\ag_UnitFrames\\fonts\\yabf.ttf",
								FontSize = 9, 
								Justify = "LEFT",
								Width = 85, 
								Point = "LEFT", 
								RelativeTo = "ManaBar", 
								RelativePoint = "LEFT", 
								x = 2, 
								y = 1,
								Hidden = false,
							},
		},
		raid = {
			FrameWidth = 100,
			FrameHeight = 24,
			HealthBar_BG = 	{ 	Width = 90,
								Height = 16,
								HeightAdd = 1,
							},
			ManaBar_BG = 	{	Width = 90,
								Height = 5,
								HeightAdd = -5,
							},
			XPBar_BG = 		{	Width = 90,
								Hidden = true,
							},
			XPBar = 		{	Width = 90,
								Hidden = true,
							},
			XPBar_Rest = 	{	Width = 90,
								Hidden = true,
							},
			NameLabel = 	{ 	Font = "Interface\\AddOns\\ag_UnitFrames\\fonts\\yabf.ttf", 
								FontSize = 13,
								Point = "LEFT", 
								RelativeTo = "HealthBar", 
								RelativePoint = "LEFT", 
								x = 2, 
								y = 1,
							},
			HealthText = 	{ 	Font = "Interface\\AddOns\\ag_UnitFrames\\fonts\\yabf.ttf", 
								FontSize = 13,
								Point = "RIGHT", 
								RelativeTo = "HealthBar_BG", 
								RelativePoint = "RIGHT", 
								x = -2,
								y = 1,
							},
			ManaText =		{	Hidden = true,
							},
			BarHealthText =	{	Hidden = true,
							},
			BarManaText =	{	Hidden = true,
							},
		},
	},
}