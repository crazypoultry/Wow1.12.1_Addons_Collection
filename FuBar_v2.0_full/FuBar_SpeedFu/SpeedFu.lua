local dewdrop = AceLibrary("Dewdrop-2.0")
local tablet = AceLibrary("Tablet-2.0")
local L = AceLibrary("AceLocale-2.0"):new("SpeedFu")


SpeedFu = AceLibrary("AceAddon-2.0"):new("FuBarPlugin-2.0", "AceEvent-2.0", "AceConsole-2.0", "AceDB-2.0", "Metrognome-2.0")
SpeedFu.hasIcon = "Interface\\Icons\\Ability_Rogue_Sprint.blp"

local optionsTable = {
	type = 'group',
	args = {
		calibrate = {
			order = 1,
			type = 'execute',
			name = L["MENU_CALIBRATE"],
			desc = L["TOOLTIP_CALIBRATE"],
			func = 'ToggleRate',
		},
		reset = {
			order = 2,
			type = 'execute',
			name = L["MENU_RESET"],
			desc = L["TOOLTIP_RESET"],
			func = 'ToggleReset',
		},
		digit = {
			order = 3,
			type = 'toggle',
			name = L["MENU_DIGIT"],
			desc = L["TOOLTIP_DIGIT"],
			set = "ToggleDigit",
			get = "GetDigit",
		}
	}
}

SpeedFu.OnMenuRequest = optionsTable
SpeedFu:RegisterChatCommand( { "/speedfu" }, optionsTable )


function SpeedFu:OnInitialize()
		
		
	self:RegisterEvent("ZONE_CHANGED_NEW_AREA")
	self:RegisterDB("FuBar_SpeedDB")
	self:RegisterDefaults('account', {
		zoneBaseRate = {
			[1] = {
				[1] = 0.00182,	-- Ashenvale
				[2] = 0.00207,	-- Azshara
				[3] = 0.00160,	-- Darkshore
				[4] = 0.00992,	-- Darnassus
				[5] = 0.00234,	-- Desolace
				[6] = 0.00199,	-- Durotar
				[7] = 0.00200,	-- dustwallow marsh
				[8] = 0.00183,	-- felwood
				[9] = 0.00151,	-- feralas
				[10] = 0.00455,	-- Moonglade
				[11] = 0.00204,	-- Mulgore
				[12] = 0.00748,	-- Orgrimmar
				[13] = 0.00301,	-- Silithus
				[14] = 0.00215,	-- Stonetalon Mtns
				[15] = 0.00152,	-- Tanaris
				[16] = 0.00206,	-- Teldrassil
				[17] = 0.00104,	-- The Barrens
				[18] = 0.00239,	-- Thousand Needles
				[19] = 0.01006,	-- Thunderbluff
				[20] = 0.00284,	-- Un'Goro Crater
				[21] = 0.00148,	-- Winterspring
				[22] = 0.0001,
				[23] = 0.0001,
				[24] = 0.0001,
				[25] = 0.0001
			},		
			[2] = {
				[1] = 0.00210,	-- Alterac Mtns
				[2] = 0.00292,	-- Arathi Highlands
				[3] = 0.00422,	-- Bad Lands
				[4] = 0.00313,	-- Blasted Lands
				[5] = 0.00359,	-- Burning Steppes
				[6] = 0.00420,	-- Deadwind pass
				[7] = 0.00213,	-- Dun Morogh
				[8] = 0.00389,	-- Duskwood
				[9] = 0.00271,	-- Eastern Plaguelands
				[10] = 0.00302,	-- Elwynn Forest
				[11] = 0.00328,	-- Hillsbrad
				[12] = 0.01327,	-- Iron Forge
				[13] = 0.00381,	-- Loch Modan
				[14] = 0.00484,	-- Redridge Mnts
				[15] = 0.00470, -- Searing Gorge
				[16] = 0.00206,	-- Rut'Theran Village
				[17] = 0.00781,	-- Stormwind
				[18] = 0.00165,	-- Stranglethorn Vale
				[19] = 0.00458,	-- Swamp of Sorrows
				[20] = 0.00272,	-- Hinterlands
				[21] = 0.00232,	-- Tristfall Glades
				[22] = 0.01094,	-- Undercity
				[23] = 0.00244,	-- Western Plaguelands
				[24] = 0.00300,	-- Westfall
				[25] = 0.00254	-- Wetlands
			},		
			['special'] = {
				[L["BLACKROCK"]] = 0.0002983199214410154,
				[L["WARSONG"]] = 0.009159138767039199,
				[L["ALTERAC"]] = 0.002477872662261515,
				[L["ARATHI"]] = 0.005978692329518227
			}
		}
	})

		
	self.vars = {}
	self.text = "???%";
	
	self:RegisterMetro(self.name, self.UpdateSpeed, 0.5, self)	
	
end

function SpeedFu:OnEnable()
	self:StartMetro(self.name)
end

function SpeedFu:OnDisable()
	self:StopMetro(self.name)
end


-- This will be called from FuBar.
function SpeedFu:OnTextUpdate()
	self:SetText(self.text)
end

function SpeedFu:OnTooltipUpdate()
	local cat = tablet:AddCategory()
	cat:AddLine('text', self.text)
end

	
	
function SpeedFu:ToggleRate()
	self.vars.setRate = true;
end
	
function SpeedFu:ToggleReset()
	StaticPopupDialogs["BPSPEED_RESET"] = {
		text = TEXT(L["RESET_CONFIRM"]),
		button1 = TEXT(OKAY),
		button2 = TEXT(CANCEL),
		OnAccept = function()
			self:Reset();
		end,
		timeout = 0,
		exclusive = 1
	};
	StaticPopup_Show("BPSPEED_RESET");
end

function SpeedFu:ToggleDigit()
	self.db.profile.digit = not self.db.profile.digit;
end	

function SpeedFu:GetDigit()
	return self.db.profile.digit
end

function SpeedFu:ZONE_CHANGED_NEW_AREA()
	SetMapToCurrentZone();
end
	
function SpeedFu:Reset()
	local digit = self.db.profile.digit
	self:ResetDB('account')
	self.db.profile.digit = digit

	self:Print(L["RESET_BASERATE"]);
end

function SpeedFu:UpdateSpeed(difference)
	
	-- Initialize.
	if (self.vars.lastPos == nil) then
		self.vars.lastTime = time()
		self.vars.setRate = false;
		self.vars.iDeltaTime = 0;
		self.vars.fSpeed = 0.0;
		self.vars.fSpeedDist = 0.0;
		self.vars.CurrPos = {};
		self.vars.lastPos = {};
		self.vars.lastPos.x, self.vars.lastPos.y = GetPlayerMapPosition("player");	
	end

		
	self.vars.iDeltaTime = self.vars.iDeltaTime + difference;
	self.vars.CurrPos.x, self.vars.CurrPos.y = GetPlayerMapPosition("player");
	
	if ((self.vars.CurrPos.x == 0) and (self.vars.CurrPos.y == 0)) then
	
		self.vars.fSpeed = "-";	
		self.vars.fSpeedDist = 0.0;
		self.vars.iDeltaTime = 0.0;		
		
	else
	
		local dist = math.sqrt(
				((self.vars.lastPos.x - self.vars.CurrPos.x) * (self.vars.lastPos.x - self.vars.CurrPos.x) * 2.25 ) +
				((self.vars.lastPos.y - self.vars.CurrPos.y) * (self.vars.lastPos.y - self.vars.CurrPos.y))
				);	
				
		self.vars.fSpeedDist = self.vars.fSpeedDist + dist;
		
		if (self.vars.iDeltaTime >= .5) then	
			local continent = GetCurrentMapContinent();
			local zone = GetCurrentMapZone();
			local displacement = (self.vars.fSpeedDist / self.vars.iDeltaTime);
			local baserate; 
			
			if zone == 0 then
				continent = "special";
				zone = GetZoneText();
			end
			

			if (self.vars.setRate == true) then
				-- recalibrate this zone, the user should know this should be done when running at 100%
				self.db.account.zoneBaseRate[continent][zone] = displacement;
				self:Print(L["NEW_BASERATE_FORMAT"], zone, displacement);
				-- done calibrating
				self.vars.setRate = false;
			end
				
			baserate = self.db.account.zoneBaseRate[continent][zone];
			
			if (baserate ~= nil and baserate ~= 0) then
				self.vars.fSpeed = self:Round( (displacement / baserate) * 100);	
				self.vars.fSpeedDist = 0.0;
				self.vars.iDeltaTime = 0.0;				
			else
				self.vars.fSpeed = "-";	
				self.vars.fSpeedDist = 0.0;
				self.vars.iDeltaTime = 0.0;		
			end
			
			
		end -- if (self.vars.iDeltaTime >= .5) 
		
	end -- if  ((self.vars.CurrPos.x == 0) and (self.vars.CurrPos.y == 0)) 
	
	self.vars.lastPos.x = self.vars.CurrPos.x;
	self.vars.lastPos.y = self.vars.CurrPos.y;
	
	local text;
	if self.vars.fSpeed == nil or self.vars.fSpeed == "-" then
		text = "???%";
	else
		if self.db.profile.digit then
			text = string.format("%03d", self.vars.fSpeed) .. "%";
		else
			text = self.vars.fSpeed .. "%";
		end
		if self.vars.fSpeed == 100 then
			text = string.format("|cffffffff%s|r", text)
		elseif self.vars.fSpeed > 100 then
			text = string.format("|cff00ff00%s|r", text)
		elseif self.vars.fSpeed < 100 then
			text = string.format("|cffff0000%s|r", text)
		end
	end
	
	self.text = text
	
	self:Update();
	
end

function SpeedFu:Round(x)
	if(x - floor(x) > 0.5) then
		x = floor(x + 0.5);
	else
		if(x - floor(x) > 0.25) then
			x = floor(x) + 0.5;
		else x = floor(x);
		end
	end
	return x;
end

