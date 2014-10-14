OZ_Windows	= {};

OZ_Config	= {};
OZ_Bars		= {};
OZ_Input	= {};

local function gg(text)
	local ret = getglobal(text)
	if(not ret) then
		DEFAULT_CHAT_FRAME:AddMessage("|c00FF8800".."OzRaid: Failed to find: "..text);
	end
	return ret
end

OZ_MAX_BARS = 42
OZ_MAX_BUFFS = 4
OZ_NWINDOWS	= 8
OZ_CURRENT_VERSION = 1.42

function OZ_SetupWindowPointers(n)
	OZ_Windows[n] = {
		-- Shortcuts to various UI elements
		["frame"]		=	gg("OzRaid_Frame"..n),
		["titleFrame"]	= gg("OzRaid_Frame"..n.."Title"),
		["name"]		= gg("OzRaid_Frame"..n.."TitleName"),
		["nameText"]	= gg("OzRaid_Frame"..n.."TitleNameText"),
		["background"]	= gg("OzRaid_Frame"..n.."TitleBackground"),

		["close"]		= gg("OzRaid_Frame"..n.."TitleClose"),
		["options"]		= gg("OzRaid_Frame"..n.."TitleOptions"),

		["table"]		= gg("OzRaid_Frame"..n.."Table"),
		["bar"] = {},
	};
	for x = 1,40 do
		OZ_Windows[n].bar[x] = {
			["frame"]		= gg("OzRaid_Frame"..n.."TableRow"..x),
			["header"]		= gg("OzRaid_Frame"..n.."TableRow"..x.."Header"),
			["headerText"]	= gg("OzRaid_Frame"..n.."TableRow"..x.."HeaderText"),
			["barFrame"]	= gg("OzRaid_Frame"..n.."TableRow"..x.."BarFrame"),
			["bar"]			= gg("OzRaid_Frame"..n.."TableRow"..x.."BarFrameBar"),
			["glow"]		= gg("OzRaid_Frame"..n.."TableRow"..x.."BarFrameBarGlow"),
			["icon"]		= gg("OzRaid_Frame"..n.."TableRow"..x.."BarFrameIcon"),
			["iconTex"]		= gg("OzRaid_Frame"..n.."TableRow"..x.."BarFrameIconIcon"),
			["name"]		= gg("OzRaid_Frame"..n.."TableRow"..x.."BarFrameName"),
			["nameText"]	= gg("OzRaid_Frame"..n.."TableRow"..x.."BarFrameNameText"),
			["value"]		= gg("OzRaid_Frame"..n.."TableRow"..x.."BarFrameValue"),
			["valueText"]	= gg("OzRaid_Frame"..n.."TableRow"..x.."BarFrameValueText"),
			["buff"]		= { gg("OzRaid_Frame"..n.."TableRow"..x.."BarFrameBuff1"),
								gg("OzRaid_Frame"..n.."TableRow"..x.."BarFrameBuff2"),
								gg("OzRaid_Frame"..n.."TableRow"..x.."BarFrameBuff3"),
								gg("OzRaid_Frame"..n.."TableRow"..x.."BarFrameBuff4") },
			["buffTex"]		= { gg("OzRaid_Frame"..n.."TableRow"..x.."BarFrameBuff1Icon"),
								gg("OzRaid_Frame"..n.."TableRow"..x.."BarFrameBuff2Icon"),
								gg("OzRaid_Frame"..n.."TableRow"..x.."BarFrameBuff3Icon"),
								gg("OzRaid_Frame"..n.."TableRow"..x.."BarFrameBuff4Icon") },
			["buffVal"]		= {nil,nil,nil,nil},
		};
	end
end

function OZ_SetupConfig(n)
	OZ_Config[n] = {
		["width"] = 120,
		["text"]		= "OzRaid "..n,
		["topCol"]		= {["r"]=0.0, ["g"]=1.0, ["b"]=1.0, ["a"]=0.5},
		["bottomCol"]	= {["r"]=0.0, ["g"]=0.0, ["b"]=0.6, ["a"]=0.5},
		["titleHeight"]		= 20,
		["barHeight"]		= 16,
		["maxBars"]			= 40,
		["minBars"]			= 2,
		["buttonSize"]		= 16,

		["active"]			= 1,
		["textSize"]		= 10,
		["refresh"]			= 1,

		-- Functions to use
		input			= 1,
		filter			= {
								injuredVal			= 0.8,
								class = { DRUID		= 1,
										  HUNTER	= 1,
										  MAGE		= 1,
										  PALADIN	= 1,
										  PRIEST	= 1,
										  ROGUE		= 1,
										  SHAMAN	= 1,
										  WARLOCK	= 1,
										  WARRIOR	= 1,

										  TARGET	= 1,

										  RANGED	= 1,
										  MELEE		= 1,
										  HEALERS	= 1,
										  TANKS		= 1 },
								group = { 1 },
								status=	{ healthy	 = 1,
										  injured	 = 1,
										  curable	 = 1,
										  notcurable = 1,
										  buffed	 = 1,
										  notbuffed	 = 1,
										  close = 1,
										  inrange = 1,
										  outofrange = 1,
										  dead = 1,
										  offline = 1,
										  online = 1,
										},
							  },
		sort1			= 2,
		sort2			= 0,
		sort3			= 0,

		heading			= {2,0,0},

		colour			= 1,
		icon			= 1,

		namePos			= 2,
		buffPos			= 1,
		buffSize		= 1,

		buffsPlayer		= {},
		buffsMob		= {},

		active			= 1,

		classNames		= 1,	-- Colour names by the class
		outlineNames	= 1,

		valuePos		= 4,	-- nil=off, 1=left, 2=bar middle, 3=bar right, 4=right
		valueType		= 2,	-- 1=number, 2=percent, 3=deficit

		nameOnStatus	= 1,	-- Change name colours given status
		barDebuffCol	= 1,	-- Colour bar if curable
		showDebuffIcon	= 1,	-- Icon if curable
	};

	-- Init buff arays with the class defaults
	local class,fileName = UnitClass("player")
	local i = 1
	for key,value in ipairs(OZ_BUFF_DEFAULT[fileName].Player) do
		local bName = "Interface\\Icons\\"..value[3]
		OZ_Config[n].buffsPlayer[key] = { value[1], value[2], bName }
	end

	for key,value in ipairs(OZ_BUFF_DEFAULT[fileName].Mob) do
		local bName = "Interface\\Icons\\"..value[3]
		OZ_Config[n].buffsMob[key] = { value[1], value[2], bName }
	end

	OZ_Bars[n]	= {
		["nBars"] = 0,
		["bar"] = {},
	};
--
--	for x = 1 , OZ_MAX_BARS do
--		OZ_Bars[n].bar[x] = {
--			-- Position of data in the raid roster
--			["roster"]		= 0,
--			["target"]		= 0,
--
--			-- Bar values (min,max,fraction)
--			["max"]			= 1000,
--			["current"]		= 500,
--			["value"]		= 0.5,
--			
--			-- Sort 
--			["sortWeight"]	= 0,
--
--			-- Bar colour
--			["colour"]		= {["r"]=1.0, ["g"]=0.0, ["b"]=0.0, ["a"]=1.0},
--
--			-- Text (header and numeral)
--			["number"]		= nil,
--			["header"]		= nil,
--
--			["class"]		= nil,
--
--			-- Buffs
--			["buffs"]		= {},
--			["buffNames"]	= {},
--			["debuff"]		= nil,
--
--			["headerVal"]	= "empty",
--		};
--	end
end


function OZ_SetupSortBuffer()
	OZ_Input	= {
		["nBars"] = 0,
		["bar"] = {},
	};

	for x = 1 , OZ_MAX_BARS do
		OZ_Input.bar[x]= {
			-- Position of data in the raid roster
			["roster"]		= 0,
			["target"]		= 0,

			-- Bar values (min,max,fraction)
			["max"]			= 1000,
			["current"]		= 500,
			["value"]		= 0.5,

			-- Buffs
			["buffs"]		= {},
			["buffNames"]	= {},
			["debuffs"]		= nil,
		};
	end
end

function OZ_ConfigTitleBar(n)
	local window = OZ_GetWindowArray(n)
	if(OZ_Config[n].hideTitle)then
		window.titleFrame:SetHeight(0.1)
		window.titleFrame:Hide()
	else
		window.titleFrame:SetHeight(OZ_Config[n].titleHeight)
		window.titleFrame:Show()

		window.background:SetHeight(42)
		window.background:SetGradientAlpha("VERTICAL",
				OZ_Config[n].bottomCol.r,
				OZ_Config[n].bottomCol.g,
				OZ_Config[n].bottomCol.b,
				OZ_Config[n].bottomCol.a,
				OZ_Config[n].topCol.r,
				OZ_Config[n].topCol.g,
				OZ_Config[n].topCol.b,
				OZ_Config[n].topCol.a);

		local tw, th, bw;
		if(OZ_Config[n].hideButtons)then
			tw = OZ_Config[n].width - 6
		else
			tw = OZ_Config[n].width - (OZ_Config[n].buttonSize*2) - 6
		end
		th = OZ_Config[n].titleHeight
		bw = OZ_Config[n].buttonSize

		window.name:SetWidth(tw)
		window.name:SetHeight(th)

		window.nameText:SetText(OZ_Config[n].text)
		window.nameText:SetWidth(tw)
		window.nameText:SetHeight(th)
		window.nameText:Show()
		
		window.close:SetWidth( bw )
		window.options:SetWidth( bw )
		window.close:SetHeight( bw)
		window.options:SetHeight( bw )

		if(OZ_Config[n].hideButtons)then
			window.close:Hide()
			window.options:Hide()
		else
			window.close:Show()
			window.options:Show()
		end

	end

	if(OZ_Config[n].hideBG)then
		window.frame:SetBackdrop(nil)
	else
		window.frame:SetBackdrop({	bgFile = "Interface/Tooltips/UI-Tooltip-Background", 
                                            edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
                                            tile = true, tileSize = 16, edgeSize = 16, 
                                            insets = { left = 4, right = 4, top = 4, bottom = 4 }});
		window.frame:SetBackdropColor(0.09, 0.09, 0.19)
		window.frame:SetBackdropBorderColor(1, 1, 1)
	end
end

function OZ_InitDefaultConfig()
	OZ_Config = {}
	for i=1,OZ_NWINDOWS do
		OZ_SetupConfig(i)
	end

	-- Temporarily disable the other windows till defaults are woring
	OZ_Config[2].active = nil
	OZ_Config[3].active = nil
	OZ_Config[4].active = nil
	OZ_Config[5].active = nil
	OZ_Config[6].active = nil
	OZ_Config[7].active = nil
	OZ_Config[8].active = nil

	OZ_Config.minimapAngle = 40
	OZ_Config.minimapDist  = 80
	OZ_Config.minimapShow  = 1
	OZ_Config.version = OZ_CURRENT_VERSION
end

function OzRaid_OnLoad()
local alloc1 = gcinfo()
	local i
	DEFAULT_CHAT_FRAME:AddMessage("|c0033CCFF".."OzRaid Loaded!");
	this:RegisterForDrag("LeftButton");
	this:RegisterEvent("VARIABLES_LOADED")
	this:RegisterEvent("RAID_ROSTER_UPDATE")

	OZ_InitDefaultConfig()
	OZ_OptionsInit()
	OZ_SetupFunctions()
	OZ_SetupRaidRoster()
	OZ_SetupSortBuffer()
if(alloc1)then
	local alloc2 = gcinfo()
	DEFAULT_CHAT_FRAME:AddMessage("|c0033CCFF".."Load 1 = "..alloc2 - alloc1.."kB");
end
end

function OzRaidLoadSavedVariables()
local alloc1 = gcinfo()
	OZ_SetupAfterLoad()
	if(alloc1)then
		local alloc2 = gcinfo()
		DEFAULT_CHAT_FRAME:AddMessage("|c0033CCFF".."Load 2 = "..alloc2 - alloc1.."kB");
	end
end

function OZ_InitWindow(n)
	local i

	OZ_SetupWindowPointers(n)
	local window = OZ_Windows[n]

	window.frame:RegisterForDrag("LeftButton") 
	window.frame:SetMovable(true)
	window.frame:SetUserPlaced(true)

	window.frame:SetWidth(OZ_Config[n].width)
	window.frame:SetHeight(200)

	OZ_ConfigTitleBar(n)

	-- Apply formating
	for row = 1, 40 do
		window.bar[row].frame:SetHeight(OZ_Config[n].barHeight);
		OZ_FormatRow(n,row)
	end
	OZ_OptionsSetOptionsFromConfig(n)
	OZ_OptionsSetConfigFromOptions()
	-- reset all the text sizes
	OZ_CheckVisibility(n)
end


function OZ_SetupAfterLoad()
	local i,key,val
	local version = 0
	if(	OZ_Config.version ) then
		version = OZ_Config.version
	end

	-- Update config with any new variables that have been added
	-- OLD version of the setting...
	if(version < 1.0)then
		-- Pre-relase version, reset all settings
		for i=1,6 do
			OZ_SetupConfig(i)
		end
	end
	if(version < 1.1)then
		for i=1,6 do
			OZ_Config[i].valuePos		= nil
			OZ_Config[i].valueType		= 2
			OZ_Config[i].nameOnStatus	= 1
			OZ_Config[i].barDebuffCol	= 1
			OZ_Config[i].showDebuffIcon	= nil
		end
	end
	if(version < 1.2)then
		OZ_Config.minimapAngle = 40
		OZ_Config.minimapDist  = 80
		OZ_Config.minimapShow  = 1

		OZ_SetupConfig(7)
		OZ_Config[7].active = nil
		OZ_SetupConfig(8)
		OZ_Config[8].active = nil
	end

	if(version < 1.4)then
		-- "Mark of the Wild/Gift of the Wild" ->"Mark of the Wild"
		for i=1,OZ_NWINDOWS do
			if(OZ_Config[i])then
				for key,val in ipairs(OZ_Config[i].buffsPlayer) do
					if( val[2] == "Mark of the Wild/Gift of the Wild" )then
						val[2] = "Mark of the Wild"
					end
					if( val[2] == "Prayer Of Fortitude" )then
						val[2] = "Prayer of Fortitude"
					end
				end
				-- Fill in icon base state
				if(not OZ_Config[i].showDebuffIcon)then
					OZ_Config[i].hideIcon = 1
				end
			end
		end
		OZ_Config[1].hideIcon = nil
	end
	OZ_Config.version = OZ_CURRENT_VERSION

	OZ_UpdateRoster()
--	for i=1,OZ_NWINDOWS do
--		OZ_InitWindow(i)
--	end
	OZ_SetMinimapPos()

	OZ_Initialised = 1
end

function OZ_GetWindowArray( n )
	if(not OZ_Windows[n])then
		OZ_InitWindow(n)
	end
	return OZ_Windows[n]
end