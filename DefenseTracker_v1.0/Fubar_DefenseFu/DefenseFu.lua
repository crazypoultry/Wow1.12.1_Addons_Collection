local DF_BLUE 			= "|cff8888ff";
local DF_GREY 			= "|cff999999";
local DF_GREN			= "|cff66cc33";
local DF_RED			= "|cffff2020";
local DF_YEL			= "|cffffff40";
local DF_BGREY			= "|c00D0D0D0";
local DF_WHITE			= "|c00FFFFFF";
local DF_ORANGE			= "|cffff9930";

-- Options
local DefenseFu_warningDuration = 40;

local DefenseFu_showSubzonesByTime = true;
local DefenseFu_showZonesByTime = true;
local DefenseFu_showSubzonesBySum = true;
local DefenseFu_showZonesBySum = true;
local DefenseFu_numSubzonesByTime = 5;
local DefenseFu_numZonesByTime = 5;
local DefenseFu_numSubzonesBySum = 5;
local DefenseFu_numZonesBySum = 5;

local compost = CompostLib:GetInstance('compost-1')
local tablet = TabletLib:GetInstance('1.0')
local dewdrop = DewdropLib:GetInstance('1.0')
local metro = Metrognome:GetInstance('1')
local abacus = AbacusLib:GetInstance('1.0')
local crayon = CrayonLib:GetInstance('1.0')

DefenseFu = FuBarPlugin:GetInstance("1.2"):new({
	name          = "DefenseFu",
	description   = "DefenseTracker for FuBar",
	version       = "1.0.",
	releaseDate   = "2006-08-18",
	aceCompatible = 103,
	author        = "tenvan",
	email         = "tenvan@kingzerg.de",
	website       = "http://www.wowinterface.com/",
	category      = "interface",
	db            = AceDatabase:new("DefenseFuDB"),
	hasIcon       = false
})

function DefenseFu:Enable()
	-- self:RegisterEvent("CHAT_MSG_CHANNEL", "OnUpdate")
	metro:Register(self.name, self.OnUpdate, 1, self)
	metro:Start(self.name)
end

function DefenseFu:Disable()
	metro:Unregister(self.name)
end

function DefenseFu:OnUpdate()
	self:Update();
end

function DefenseFu:UpdateText()
	local att, islocal, atttime = DefenseTracker_getLastAttack();
	local DeFuText;
	
	if (not att) then 
		att = DF_WHITE..DefenseTracker_GetNumAttText();
		DeFuText = att;
	elseif (atttime + 60 < time()) then
		att = DF_ORANGE..DefenseTracker_GetNumAttText();
		DeFuText = att;
	elseif (islocal) then
		DeFuText = DF_GREN..att;
	else
		DeFuText = DF_RED..att;
	end

	self:SetText(string.format("DeFu: %s", DeFuText))
end

function DefenseFu:UpdateTooltip()
	local cat = tablet:AddCategory(
		'text', "Defense Tracker Status:",
		'columns', 4,
		'child_textR', 1,
		'child_textG', 1,
		'child_textB', 1,
		'child_textR2', 1,
		'child_textG2', 1,
		'child_textB2', 0,
		'child_textR3', 0.6,
		'child_textG3', 0.6,
		'child_textB3', 1,
		'child_textR4', 0.8,
		'child_textG4', 1,
		'child_textB4', 0.8,
		'textR', 1,
		'textG', 1,
		'textB', 1 );
		
	cat:AddLine( 'text', DefenseTracker_GetNumAttText() );
		
	if (DefenseTracker_numAttacks == 0) then
		return;
	end

	local rawdataset = {
		{"------SubzoneSum-----\n", DefenseTracker_SortedSubzoneSum},
		{"------ZoneSum-----\n", DefenseTracker_SortedZoneSum},
		{"------SubzoneTime-----\n", DefenseTracker_SortedSubzoneTimestamp},
		{"------ZoneTime-----\n", DefenseTracker_SortedZoneTimestamp},
		{"------Unknowns-----\n", DefenseTracker_unknowns},
		{"------Attacks-----\n", DefenseTracker_attacks}
	};
	
	local dataset = {
		{DEFENSETRACKER_STRINGS_SZTIMETITLE, DefenseFu_showSubzonesByTime,
			DefenseFu_numSubzonesByTime, DefenseTracker_SortedSubzoneTimestamp, true},
		{DEFENSETRACKER_STRINGS_ZTIMETITLE, DefenseFu_showZonesByTime,
			DefenseFu_numZonesByTime, DefenseTracker_SortedZoneTimestamp, false},
		{DEFENSETRACKER_STRINGS_SZFRQTITLE, DefenseFu_showSubzonesBySum, 
			DefenseFu_numSubzonesBySum, DefenseTracker_SortedSubzoneSum, true},
		{DEFENSETRACKER_STRINGS_ZFRQTITLE, DefenseFu_showZonesBySum, 
			DefenseFu_numZonesBySum, DefenseTracker_SortedZoneSum, false}
	};

	for i,arrayinfo in dataset do
		if (arrayinfo[2]) then
			cat:AddLine( 'text', " " );
			cat:AddLine( 'text', arrayinfo[1]..":" );
			DefenseFu_GetTooltipData(cat, arrayinfo[4], arrayinfo[3], arrayinfo[5]);
		end
	end
	
end

function DefenseFu_GetTooltipData(cat, dataarray, numvals, isSubzone)	
	local t1, t2, t3, t4;

	for i=1,numvals do
		if (dataarray[i]) then
			local zone = dataarray[i];
			local atttime = 0;
			local numatt = 0;
			
			if (isSubzone) then
				numatt = DefenseTracker_SubzoneSum[zone];
				atttime = DefenseTracker_SubzoneTimestamp[zone];
			else
				numatt = DefenseTracker_ZoneSum[zone];
				atttime = DefenseTracker_ZoneTimestamp[zone];
			end
			
			local elapsedtime = DefenseTracker_GetTimeText(time() - atttime);
			local mainzone = DefenseTracker_getMainZone(zone);
			
			t1 = "";
			t2 = "";
			t3 = DF_BLUE.." ("..numatt..")";
			t4 = elapsedtime.. DEFENSETRACKER_STRINGS_AGOENDER;
			if (isSubzone) then
				if (DefenseTracker_isLocal(zone)) then
					t1 = DEFENSETRACKER_STRINGS_LOCALHEADER..zone;
				elseif (mainzone == loc) then
					t1 = zone;
				else
					t1 = mainzone.. ": ";
					t2 = zone;
				end
			else
				t1 = zone;
			end
			cat:AddLine( 'text', DF_BLUE..t1, 'text2', t2, 'text3', t3, 'text4', t4 );
		end
	end

end

DefenseFu:RegisterForLoad()