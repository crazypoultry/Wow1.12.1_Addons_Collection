-- Table to hold all the anchor positions used in BeneCast
BeneCast_SnapTo = {};

-- Standard UI anchor positions
BeneCast_SnapTo.STANDARD = {

	-- Player Frame
	BeneCastPanel1 = { point = "TOPLEFT", frame = "PlayerFrame", relativePoint = "BOTTOM", x = -10, y = 30 },
	
	-- Party Frames
	BeneCastPanel2 = { point = "TOPLEFT", frame = "PartyMemberFrame1", relativePoint = "TOPRIGHT", x = 0, y = 0 },
	BeneCastPanel3 = { point = "TOPLEFT", frame = "PartyMemberFrame2", relativePoint = "TOPRIGHT", x = 0, y = 0 },
	BeneCastPanel4 = { point = "TOPLEFT", frame = "PartyMemberFrame3", relativePoint = "TOPRIGHT", x = 0, y = 0 },
	BeneCastPanel5 = { point = "TOPLEFT", frame = "PartyMemberFrame4", relativePoint = "TOPRIGHT", x = 0, y = 0 },
	
	-- Player Pet Frame
	BeneCastPanel46 = { point = "", frame = "", relativePoint = "", x = 0, y = 0 },
	
	-- Party Pet Frames
	BeneCastPanel47 = { point = "TOPLEFT", frame = "PartyMemberFrame1PetFrame", relativePoint = "TOPRIGHT", x = 0, y = 0 },
	BeneCastPanel48 = { point = "TOPLEFT", frame = "PartyMemberFrame2PetFrame", relativePoint = "TOPRIGHT", x = 0, y = 0 },
	BeneCastPanel49 = { point = "TOPLEFT", frame = "PartyMemberFrame3PetFrame", relativePoint = "TOPRIGHT", x = 0, y = 0 },
	BeneCastPanel50 = { point = "TOPLEFT", frame = "PartyMemberFrame4PetFrame", relativePoint = "TOPRIGHT", x = 0, y = 0 },
	
	-- Target Frame
	BeneCastPanel91 = { point = "TOPLEFT", frame = "TargetFrame", relativePoint = "TOPRIGHT", x = 0, y = 0 },
	
	-- Target of Target Frame
	BeneCastPanel92 = { point = "TOPLEFT", frame = "TargetofTargetFrame", relativePoint = "TOPRIGHT", x = 0, y = 0 },
	
	AddOn = 'BeneCast',
		
};

-- Perl anchor positions
BeneCast_SnapTo.PERLNYMBIA  = {

	-- Player Frame
	BeneCastPanel1 = { point = "TOPLEFT", frame = "Perl_Player_Frame", relativePoint = "TOPRIGHT", x = 0, y = 0 },
	
	-- Party Frames
	BeneCastPanel2 = { point = "TOPLEFT", frame = "Perl_party1", relativePoint = "TOPRIGHT", x = 0, y = 0 },
	BeneCastPanel3 = { point = "TOPLEFT", frame = "Perl_party2", relativePoint = "TOPRIGHT", x = 0, y = 0 },
	BeneCastPanel4 = { point = "TOPLEFT", frame = "Perl_party3", relativePoint = "TOPRIGHT", x = 0, y = 0 },
	BeneCastPanel5 = { point = "TOPLEFT", frame = "Perl_party4", relativePoint = "TOPRIGHT", x = 0, y = 0 },
	
	-- Player Pet Frame
	BeneCastPanel46 = { point = "", frame = "", relativePoint = "", x = 0, y = 0 },
	
	-- Party Pet Frames
	BeneCastPanel47 = { point = "TOPLEFT", frame = "Perl_Party_Pet1", relativePoint = "TOPRIGHT", x = 0, y = 0 },
	BeneCastPanel48 = { point = "TOPLEFT", frame = "Perl_Party_Pet2", relativePoint = "TOPRIGHT", x = 0, y = 0 },
	BeneCastPanel49 = { point = "TOPLEFT", frame = "Perl_Party_Pet3", relativePoint = "TOPRIGHT", x = 0, y = 0 },
	BeneCastPanel50 = { point = "TOPLEFT", frame = "Perl_Party_Pet4", relativePoint = "TOPRIGHT", x = 0, y = 0 },
	
	-- Target Frame
	BeneCastPanel91 = { point = "TOPLEFT", frame = "Perl_Target_Frame", relativePoint = "TOPRIGHT", x = 0, y = 0 },
	
	-- Target of Target Frame
	BeneCastPanel92 = { point = "TOPLEFT", frame = "Perl_TargetTarget_Frame", relativePoint = "BOTTOMLEFT", x = 0, y = 0 },
	
	AddOn = 'Perl',
	
};

-- Perl anchor positions
BeneCast_SnapTo.PERLCLASSIC = {

	-- Player Frame
	BeneCastPanel1 = { point = "BOTTOMLEFT", frame = "Perl_Player_Frame", relativePoint = "TOPRIGHT", x = -5, y = -25 },

	-- Party Frames
	BeneCastPanel2 = { point = "BOTTOMLEFT", frame = "Perl_Party_MemberFrame1", relativePoint = "TOPRIGHT", x = -5, y = -25 },
	BeneCastPanel3 = { point = "BOTTOMLEFT", frame = "Perl_Party_MemberFrame2", relativePoint = "TOPRIGHT", x = -5, y = -25 },
	BeneCastPanel4 = { point = "BOTTOMLEFT", frame = "Perl_Party_MemberFrame3", relativePoint = "TOPRIGHT", x = -5, y = -25 },
	BeneCastPanel5 = { point = "BOTTOMLEFT", frame = "Perl_Party_MemberFrame4", relativePoint = "TOPRIGHT", x = -5, y = -25 },

	-- Player Pet Frame
	BeneCastPanel46 = { point = "TOPLEFT", frame = "BeneCastPanel1", relativePoint = "TOPRIGHT", x = 0, y = 0 },

	-- Party Pet Frames
	BeneCastPanel47 = { point = "BOTTOMLEFT", frame = "Perl_Party_MemberFrame1_StatsFrame_PetHealthBar", relativePoint = "TOPRIGHT", x = -5, y = -25 },
	BeneCastPanel48 = { point = "BOTTOMLEFT", frame = "Perl_Party_MemberFrame2_StatsFrame_PetHealthBar", relativePoint = "TOPRIGHT", x = -5, y = -25 },
	BeneCastPanel49 = { point = "BOTTOMLEFT", frame = "Perl_Party_MemberFrame3_StatsFrame_PetHealthBar", relativePoint = "TOPRIGHT", x = -5, y = -25 },
	BeneCastPanel50 = { point = "BOTTOMLEFT", frame = "Perl_Party_MemberFrame4_StatsFrame_PetHealthBar", relativePoint = "TOPRIGHT", x = -5, y = -25 },

	-- Target Frame
	BeneCastPanel91 = { point = "BOTTOMLEFT", frame = "Perl_Target_Frame", relativePoint = "TOPRIGHT", x = -5, y = -25 },

	-- Target of Target Frame
	BeneCastPanel92 = { point = "TOPLEFT", frame = "Perl_TargetTarget_Frame", relativePoint = "BOTTOMLEFT", x = 0, y = 0 },

	AddOn = 'Perl_Target',

};

-- Minigroup anchor positions
BeneCast_SnapTo.MINIGROUP = {

	-- Player Frame
	BeneCastPanel1 = { point = "TOPLEFT", frame = "MGParty_Member0", relativePoint = "TOPRIGHT", x = 0, y = 0 },
	
	-- Party Frames
	BeneCastPanel2 = { point = "TOPLEFT", frame = "MGParty_Member1", relativePoint = "TOPRIGHT", x = 0, y = 0 },
	BeneCastPanel3 = { point = "TOPLEFT", frame = "MGParty_Member2", relativePoint = "TOPRIGHT", x = 0, y = 0 },
	BeneCastPanel4 = { point = "TOPLEFT", frame = "MGParty_Member3", relativePoint = "TOPRIGHT", x = 0, y = 0 },
	BeneCastPanel5 = { point = "TOPLEFT", frame = "MGParty_Member4", relativePoint = "TOPRIGHT", x = 0, y = 0 },
	
	-- Player Pet Frame
	BeneCastPanel46 = { point = "", frame = "", relativePoint = "", x = 0, y = 0 },
	
	-- Party Pet Frames
	BeneCastPanel47 = { point = "TOPLEFT", frame = "", relativePoint = "TOPRIGHT", x = 0, y = 0 },
	BeneCastPanel48 = { point = "TOPLEFT", frame = "", relativePoint = "TOPRIGHT", x = 0, y = 0 },
	BeneCastPanel49 = { point = "TOPLEFT", frame = "", relativePoint = "TOPRIGHT", x = 0, y = 0 },
	BeneCastPanel50 = { point = "TOPLEFT", frame = "", relativePoint = "TOPRIGHT", x = 0, y = 0 },
	
	-- Target Frame
	BeneCastPanel91 = { point = "TOPLEFT", frame = "MGTarget_Frame", relativePoint = "TOPRIGHT", x = 0, y = 0 },
	
	AddOn = 'MiniGroup',
		
};

-- Minigroup anchor positions
BeneCast_SnapTo.MINIGROUP2 = {

	-- Player Frame
	BeneCastPanel1 = { point = "TOPLEFT", frame = "MGplayer", relativePoint = "TOPRIGHT", x = 0, y = 0 },
	
	-- Party Frames
	BeneCastPanel2 = { point = "TOPLEFT", frame = "MGparty1", relativePoint = "TOPRIGHT", x = 0, y = 0 },
	BeneCastPanel3 = { point = "TOPLEFT", frame = "MGparty2", relativePoint = "TOPRIGHT", x = 0, y = 0 },
	BeneCastPanel4 = { point = "TOPLEFT", frame = "MGparty3", relativePoint = "TOPRIGHT", x = 0, y = 0 },
	BeneCastPanel5 = { point = "TOPLEFT", frame = "MGparty4", relativePoint = "TOPRIGHT", x = 0, y = 0 },
	
	-- Player Pet Frame
	BeneCastPanel46 = { point = "", frame = "", relativePoint = "", x = 0, y = 0 },
	
	-- Party Pet Frames
	BeneCastPanel47 = { point = "TOPLEFT", frame = "MGpartypet1", relativePoint = "TOPRIGHT", x = 0, y = 0 },
	BeneCastPanel48 = { point = "TOPLEFT", frame = "MGpartypet2", relativePoint = "TOPRIGHT", x = 0, y = 0 },
	BeneCastPanel49 = { point = "TOPLEFT", frame = "MGpartypet3", relativePoint = "TOPRIGHT", x = 0, y = 0 },
	BeneCastPanel50 = { point = "TOPLEFT", frame = "MGpartypet4", relativePoint = "TOPRIGHT", x = 0, y = 0 },
	
	-- Target Frame
	BeneCastPanel91 = { point = "TOPLEFT", frame = "MGtarget", relativePoint = "TOPRIGHT", x = 0, y = 0 },
	
	AddOn = 'MiniGroup2',
		
};

-- Nurfed anchor positions
BeneCast_SnapTo.NURFED = {

	-- Player Frame
	BeneCastPanel1 = { point = "TOPLEFT", frame = "Nurfed_player", relativePoint = "TOPRIGHT", x = 0, y = 0 },
	
	-- Party Frames
	BeneCastPanel2 = { point = "TOPLEFT", frame = "Nurfed_party1", relativePoint = "TOPRIGHT", x = 0, y = 0 },
	BeneCastPanel3 = { point = "TOPLEFT", frame = "Nurfed_party2", relativePoint = "TOPRIGHT", x = 0, y = 0 },
	BeneCastPanel4 = { point = "TOPLEFT", frame = "Nurfed_party3", relativePoint = "TOPRIGHT", x = 0, y = 0 },
	BeneCastPanel5 = { point = "TOPLEFT", frame = "Nurfed_party4", relativePoint = "TOPRIGHT", x = 0, y = 0 },
	
	-- Player Pet Frame
	BeneCastPanel46 = { point = "", frame = "", relativePoint = "", x = 0, y = 0 },
	
	-- Party Pet Frames
	BeneCastPanel47 = { point = "TOPLEFT", frame = "Nurfed_partypet1", relativePoint = "TOPRIGHT", x = 0, y = 0 },
	BeneCastPanel48 = { point = "TOPLEFT", frame = "Nurfed_partypet2", relativePoint = "TOPRIGHT", x = 0, y = 0 },
	BeneCastPanel49 = { point = "TOPLEFT", frame = "Nurfed_partypet3", relativePoint = "TOPRIGHT", x = 0, y = 0 },
	BeneCastPanel50 = { point = "TOPLEFT", frame = "Nurfed_partypet4", relativePoint = "TOPRIGHT", x = 0, y = 0 },
	
	-- Target Frame
	BeneCastPanel91 = { point = "TOPLEFT", frame = "Nurfed_target", relativePoint = "TOPRIGHT", x = 0, y = 0 },
	
	AddOn = 'Nurfed_UnitFrames',
		
};

-- Noctambul anchor positions
BeneCast_SnapTo.NOCTAMBUL = {

	-- Player Frame
	BeneCastPanel1 = { point = "TOPLEFT", frame = "NUFPlayerFrame", relativePoint = "TOPRIGHT", x = 0, y = 0, orientation = "down" },
	
	-- Party Frames
	BeneCastPanel2 = { point = "TOPLEFT", frame = "NUFPartyMemberFrame1", relativePoint = "TOPRIGHT", x = 0, y = 0, orientation = "down" },
	BeneCastPanel3 = { point = "TOPLEFT", frame = "NUFPartyMemberFrame2", relativePoint = "TOPRIGHT", x = 0, y = 0, orientation = "down" },
	BeneCastPanel4 = { point = "TOPLEFT", frame = "NUFPartyMemberFrame3", relativePoint = "TOPRIGHT", x = 0, y = 0, orientation = "down" },
	BeneCastPanel5 = { point = "TOPLEFT", frame = "NUFPartyMemberFrame4", relativePoint = "TOPRIGHT", x = 0, y = 0, orientation = "down" },
	
	-- Player Pet Frame
	BeneCastPanel46 = { point = "TOPLEFT", frame = "NUFPetFrame", relativePoint = "BOTTOMLEFT", x = 0, y = 0, orientation = "right" },
	
	-- Party Pet Frames
	BeneCastPanel47 = { point = "TOPLEFT", frame = "NUFPartyPet1", relativePoint = "BOTTOMLEFT", x = 0, y = 0, orientation = "right" },
	BeneCastPanel48 = { point = "TOPLEFT", frame = "NUFPartyPet2", relativePoint = "BOTTOMLEFT", x = 0, y = 0, orientation = "right" },
	BeneCastPanel49 = { point = "TOPLEFT", frame = "NUFPartyPet3", relativePoint = "BOTTOMLEFT", x = 0, y = 0, orientation = "right" },
	BeneCastPanel50 = { point = "TOPLEFT", frame = "NUFPartyPet4", relativePoint = "BOTTOMLEFT", x = 0, y = 0, orientation = "right" },
		
	-- Target Frame
	BeneCastPanel91 = { point = "TOPLEFT", frame = "NUFTargetFrame", relativePoint = "TOPRIGHT", x = 0, y = 0, orientation = "down" },
	
	-- Target of Target Frame
	BeneCastPanel92 = { point = "TOPLEFT", frame = "Dag_TargetTargetFrame", relativePoint = "TOPRIGHT", x = 0, y = 0, orientation = "down" },
	
	AddOn = 'NUF',
		
};

-- SAE_PartyFrame 
BeneCast_SnapTo.SAE_PARTYFRAME = { 

	-- Player Frame 
	BeneCastPanel1 = { point = "TOPLEFT", frame = "PlayerFrame", relativePoint = "BOTTOM", x = -10, y = 30 }, 

	-- Party Frames 
	BeneCastPanel2 = { point = "TOPLEFT", frame = "SAE_PartyMemberFrame1", relativePoint = "TOPRIGHT", x = -5, y = -5 }, 
	BeneCastPanel3 = { point = "TOPLEFT", frame = "SAE_PartyMemberFrame2", relativePoint = "TOPRIGHT", x = -5, y = -5 }, 
	BeneCastPanel4 = { point = "TOPLEFT", frame = "SAE_PartyMemberFrame3", relativePoint = "TOPRIGHT", x = -5, y = -5 }, 
	BeneCastPanel5 = { point = "TOPLEFT", frame = "SAE_PartyMemberFrame4", relativePoint = "TOPRIGHT", x = -5, y = -5 }, 

	-- Player Pet Frame 
	BeneCastPanel46 = { point = "", frame = "", relativePoint = "", x = 0, y = 0 }, 

	-- Party Pet Frames 
	BeneCastPanel47 = { point = "TOPLEFT", frame = "SAE_PartyMemberFrame1PetFrame", relativePoint = "TOPRIGHT", x = 0, y = 2 }, 
	BeneCastPanel48 = { point = "TOPLEFT", frame = "SAE_PartyMemberFrame2PetFrame", relativePoint = "TOPRIGHT", x = 0, y = 2 }, 
	BeneCastPanel49 = { point = "TOPLEFT", frame = "SAE_PartyMemberFrame3PetFrame", relativePoint = "TOPRIGHT", x = 0, y = 2 }, 
	BeneCastPanel50 = { point = "TOPLEFT", frame = "SAE_PartyMemberFrame4PetFrame", relativePoint = "TOPRIGHT", x = 0, y = 2 }, 

	-- Target Frame 
	BeneCastPanel91 = { point = "LEFT", frame = "TargetFrame", relativePoint = "RIGHT", x = -20, y = 7 }, 

	AddOn = 'SAE_PartyFrame', 
}; 



-- Watchdog anchor positions
BeneCast_SnapTo.WATCHDOG = {

	-- Player Frame
	BeneCastPanel1 = { point = "TOPLEFT", frame = "WatchDogFrame_player", relativePoint = "TOPRIGHT", x = 0, y = 0 },
	
	-- Party Frames
	BeneCastPanel2 = { point = "TOPLEFT", frame = "WatchDogFrame_party1", relativePoint = "TOPRIGHT", x = 0, y = 0 },
	BeneCastPanel3 = { point = "TOPLEFT", frame = "WatchDogFrame_party2", relativePoint = "TOPRIGHT", x = 0, y = 0 },
	BeneCastPanel4 = { point = "TOPLEFT", frame = "WatchDogFrame_party3", relativePoint = "TOPRIGHT", x = 0, y = 0 },
	BeneCastPanel5 = { point = "TOPLEFT", frame = "WatchDogFrame_party4", relativePoint = "TOPRIGHT", x = 0, y = 0 },
	
	-- Player Pet Frame
	BeneCastPanel46 = { point = "", frame = "", relativePoint = "", x = 0, y = 0 },
	
	-- Party Pet Frames
	BeneCastPanel47 = { point = "TOPLEFT", frame = "WatchDogFrame_partypet1", relativePoint = "TOPRIGHT", x = 0, y = 0 },
	BeneCastPanel48 = { point = "TOPLEFT", frame = "WatchDogFrame_partypet2", relativePoint = "TOPRIGHT", x = 0, y = 0 },
	BeneCastPanel49 = { point = "TOPLEFT", frame = "WatchDogFrame_partypet3", relativePoint = "TOPRIGHT", x = 0, y = 0 },
	BeneCastPanel50 = { point = "TOPLEFT", frame = "WatchDogFrame_partypet4", relativePoint = "TOPRIGHT", x = 0, y = 0 },
	
	-- Target Frame
	BeneCastPanel91 = { point = "TOPLEFT", frame = "WatchDogFrame_target", relativePoint = "TOPRIGHT", x = 0, y = 0 },
	
	AddOn = 'WatchDog',
		
};

-- Discord anchor positions
BeneCast_SnapTo.DISCORD = {

	-- Player Frame
	BeneCastPanel1 = { point = "TOPLEFT", frame = "DUF_PlayerFrame", relativePoint = "TOPRIGHT", x = 0, y = 0 },
	
	-- Party Frames
	BeneCastPanel2 = { point = "TOPLEFT", frame = "DUF_PartyFrame1", relativePoint = "TOPRIGHT", x = 0, y = 0 },
	BeneCastPanel3 = { point = "TOPLEFT", frame = "DUF_PartyFrame2", relativePoint = "TOPRIGHT", x = 0, y = 0 },
	BeneCastPanel4 = { point = "TOPLEFT", frame = "DUF_PartyFrame3", relativePoint = "TOPRIGHT", x = 0, y = 0 },
	BeneCastPanel5 = { point = "TOPLEFT", frame = "DUF_PartyFrame4", relativePoint = "TOPRIGHT", x = 0, y = 0 },
	
	-- Player Pet Frame
	--WINTROW.1 BeneCastPanel46 = { point = "", frame = "", relativePoint = "", x = 0, y = 0 },
	BeneCastPanel46 = { point = "TOPLEFT", frame = "DUF_PetFrame", relativePoint = "TOPRIGHT", x = 0, y = 0 },
	
	-- Party Pet Frames
	BeneCastPanel47 = { point = "TOPLEFT", frame = "DUF_PartyPetFrame1", relativePoint = "TOPRIGHT", x = 0, y = 0 },
	BeneCastPanel48 = { point = "TOPLEFT", frame = "DUF_PartyPetFrame2", relativePoint = "TOPRIGHT", x = 0, y = 0 },
	BeneCastPanel49 = { point = "TOPLEFT", frame = "DUF_PartyPetFrame3", relativePoint = "TOPRIGHT", x = 0, y = 0 },
	BeneCastPanel50 = { point = "TOPLEFT", frame = "DUF_PartyPetFrame4", relativePoint = "TOPRIGHT", x = 0, y = 0 },
	
	-- Target Frame
	BeneCastPanel91 = { point = "TOPLEFT", frame = "DUF_TargetFrame", relativePoint = "TOPRIGHT", x = 0, y = 0 },
	
	-- Target of Target Frame
	BeneCastPanel92 = { point = "TOPLEFT", frame = "DUF_TargetOfTargetFrame", relativePoint = "TOPRIGHT", x = 0, y = 0 },
	
	AddOn = 'DiscordUnitFrames',
		
};

BeneCast_SnapTo.CUSTOM = {
	AddOn = 'Custom',	
};

-- Sage anchor positions
BeneCast_SnapTo.SAGE = {

	-- Player Frame
	BeneCastPanel1 = { point = "TOPLEFT", frame = "Sageplayer", relativePoint = "TOPLEFT", x = -3, y = -62 },

	-- Party Frames
	BeneCastPanel2 = { point = "TOPLEFT", frame = "Sageparty1", relativePoint = "TOPRIGHT", x = -120, y = -14 },
	BeneCastPanel3 = { point = "TOPLEFT", frame = "Sageparty2", relativePoint = "TOPRIGHT", x = -120, y = -14 },
	BeneCastPanel4 = { point = "TOPLEFT", frame = "Sageparty3", relativePoint = "TOPRIGHT", x = -120, y = -14 },
	BeneCastPanel5 = { point = "TOPLEFT", frame = "Sageparty4", relativePoint = "TOPRIGHT", x = -120, y = -14 },

	-- Player Pet Frame
	BeneCastPanel46 = { point = "TOPLEFT", frame = "Sagepet", relativePoint = "TOPRIGHT", x = -110, y = -14 },

	-- Party Pet Frames
	BeneCastPanel47 = { point = "TOPLEFT", frame = "Sagepartypet1", relativePoint = "TOPRIGHT", x = -120, y = -14 },
	BeneCastPanel48 = { point = "TOPLEFT", frame = "Sagepartypet2", relativePoint = "TOPRIGHT", x = -120, y = -14 },
	BeneCastPanel49 = { point = "TOPLEFT", frame = "Sagepartypet3", relativePoint = "TOPRIGHT", x = -120, y = -14 },
	BeneCastPanel50 = { point = "TOPLEFT", frame = "Sagepartypet4", relativePoint = "TOPRIGHT", x = -120, y = -14 },

	-- Target Frame
	BeneCastPanel91 = { point = "TOPLEFT", frame = "Sagetarget", relativePoint = "TOPRIGHT", x = -1, y = -16 },
	
	-- Target of Target Frame
	BeneCastPanel92 = { point = "TOPLEFT", frame = "Sagetargettarget", relativePoint = "TOPRIGHT", x = -1, y = -13 },

	AddOn = 'Sage',

};

-- Constants used for Blizzard Raid UI pullout frames
local BLIZZ_MAX_RAID_PULLOUT_BUTTONS = 15;
local BLIZZ_MAX_RAID_PULLOUT_FRAMES = 12;

-- Functions for attaching raid panels
-- Functions should take the Raid Id number of a member
-- The BeneCastPanel for a Raid member is always their Raid Id number + 5

function BeneCast_AttachRaidPetToRaidPanel(raidmember,raidpet,relativepoint)
	local raidpanel = getglobal(raidmember);
	local petpanel = getglobal(raidpet);
	-- Attach the panel to the frame and set the parent
	petpanel:ClearAllPoints();
	petpanel:SetPoint('TOPLEFT',raidpanel,relativepoint);
	petpanel:SetParent(raidpanel);
	-- Set up the correct frame strata and level for the panel
	petpanel:SetFrameStrata(raidpanel:GetFrameStrata());
	petpanel:SetFrameLevel(raidpanel:GetFrameLevel() + 10);
	-- Set up the correct level for the buttons on the panel
	for x = 1, BENECAST_MAX_NUMBER_OF_BUTTONS do
		getglobal(petpanel:GetName().. 'Button' .. x):SetFrameLevel(petpanel:GetFrameLevel() + 1);
		getglobal(petpanel:GetName().. 'Button' .. x .. 'Cooldown'):SetFrameLevel(petpanel:GetFrameLevel() + 2);
	end
end

function BeneCast_GetRaidPanelFor(parentfr, unit)
	if not BENECAST_RAID_PANELS[parentfr] then
		for i = 6, 45 do
			if BENECAST_RAID_PANELS2[i] == nil then
				BENECAST_RAID_PANELS[parentfr] = i;
				BENECAST_RAID_PANELS2[i] = { unitid=unit,
				                             parentframe=parentfr };
				if BENECAST_RAID_PANELS3[unit] == nil then
					BENECAST_RAID_PANELS3[unit] = {};
				end
				table.insert(BENECAST_RAID_PANELS3[unit],parentfr);
				do break end;
			end
		end
	end
	if not BENECAST_RAID_PANELS[parentfr] then
		for i = 51, 90 do
			if BENECAST_RAID_PANELS2[i] == nil then
				BENECAST_RAID_PANELS[parentfr] = i;
				BENECAST_RAID_PANELS2[i] = { unitid=unit,
				                             parentframe=parentfr };
				if BENECAST_RAID_PANELS3[unit] == nil then
					BENECAST_RAID_PANELS3[unit] = {};
				end
				table.insert(BENECAST_RAID_PANELS3[unit],parentfr);
				do break end;
			end
		end
	end
	if not BENECAST_RAID_PANELS[parentfr] then
		if BeneCastConfig.Debug then
			local name = UnitName(unit);
			PutDebugMsg('Not enough buttonbars to attach to ' .. parentfr .. ' (' .. name .. ')');
		end
		return nil;
	end
	local id = BENECAST_RAID_PANELS[parentfr];
	if ( id ) then
		if BENECAST_RAID_PANELS2[id] == nil then
			BENECAST_RAID_PANELS2[id] = { unitid=unit,
				                      parentframe=parentfr };
		end
		if BENECAST_RAID_PANELS3[unit] == nil then
			BENECAST_RAID_PANELS3[unit] = {};
		end
		local found = false;
		for i, pframe in BENECAST_RAID_PANELS3[unit] do
			if pframe == parentfr then
				found = true;
				do break end;
			end
		end
		if not found then
			table.insert(BENECAST_RAID_PANELS3[unit],parentfr);
		end
	end
	return id;
end

function BeneCast_AttachPanelToRaidFrame(raidframe, nextraidframe, bottom)

	local attachpanel = false;
	local reattachnextframe = true;
	local RaidId = nil;
	if raidframe == nil then
		return;
	end
	local raidframetext = getglobal(raidframe:GetName() .. 'Name'):GetText();
	if raidframe:IsVisible() and raidframetext then
		local unit = BENECAST_RAID_ROSTER2[raidframetext];
		if unit then
			_, _, RaidId = string.find(unit,'raid(.+)');
			if RaidId then
				RaidId = tonumber(RaidId);
				if BENECAST_RAID_LIST[raidframetext] then
					attachpanel = true;
				else
					PutDebugMsg(raidframetext .. ' (raid' .. RaidId .. ') is not enabled to have a panel');
				end
			end
		else
			PutDebugMsg('Could not find unit of ' .. raidframetext);
		end
	end
	if attachpanel then
		PutDebugMsg('Attaching a panel to ' .. raidframe:GetName() .. ' for ' .. raidframetext .. ' (raid' .. RaidId .. ')');
		-- Dynamically get the panels out of a pool
		local panelid = BeneCast_GetRaidPanelFor(raidframe:GetName(),'raid' .. RaidId);
		local panelname, panel, petpanel;
		if panelid then
			panelname = 'BeneCastPanel' .. panelid;
			panel = getglobal(panelname);
			if ( not panel ) then
				PutDebugMsg('panel ' .. panelname .. ' for raidmember raid' .. RaidId .. ' not found');
			end
		end
		if ( panel ) then
			if BeneCastConfig.ShowRaidPets then
				if UnitExists('raidpet' .. RaidId) then
					panelid = BeneCast_GetRaidPanelFor(panel:GetName(),'raidpet' .. RaidId);
					if panelid then
						panelname = 'BeneCastPanel' .. panelid;					
						petpanel = getglobal(panelname);
					end
				end
			end
			-- Attach the panel to the frame and set the parent
			panel:ClearAllPoints();
			if bottom then
				panel:SetPoint('TOPLEFT',raidframe,'BOTTOMLEFT');
			else
				panel:SetPoint('TOPLEFT',raidframe,'TOPRIGHT');
			end
			panel:SetParent(raidframe);
			if bottom and nextraidframe then
				-- Set the next raid frame to be underneath the panel
				nextraidframe:SetPoint('TOPLEFT',panel,'BOTTOMLEFT');
				reattachnextframe = false;
			end
			-- Set up the correct frame strata and level for the panel
			panel:SetFrameStrata(raidframe:GetFrameStrata());
			panel:SetFrameLevel(raidframe:GetFrameLevel() + 10);
			-- Set up the correct level for the buttons on the panel
			for x = 1, BENECAST_MAX_NUMBER_OF_BUTTONS do
				getglobal(panel:GetName().. 'Button' .. x):SetFrameLevel(panel:GetFrameLevel() + 1);
				getglobal(panel:GetName().. 'Button' .. x .. 'Cooldown'):SetFrameLevel(panel:GetFrameLevel() + 2);
			end
			--Attach raidpets to panel of raidmember
			if petpanel then
				if bottom then
					BeneCast_AttachRaidPetToRaidPanel(panel:GetName(),petpanel:GetName(),'TOPRIGHT');
				else
					BeneCast_AttachRaidPetToRaidPanel(panel:GetName(),petpanel:GetName(),'BOTTOMLEFT');
					if nextraidframe then
						nextraidframe:SetPoint('TOPLEFT',raidframe,'BOTTOMLEFT',0,-8 - petpanel:GetHeight());
						reattachnextframe = false;
					end
				end
			end
		end
	end
	if nextraidframe and reattachnextframe then
	        nextraidframe:ClearAllPoints();
		nextraidframe:SetPoint('TOPLEFT',raidframe,'BOTTOMLEFT',0,-8);
	end
end

-- Attach function for the Standard Raid UI (bottom)
function BeneCast_RaidAttachSTANDARDBOTTOM()

	PutDebugMsg('BeneCast_RaidAttachSTANDARDBOTTOM() called');

	local raidframe, nextraidframe;
	-- Attach the panel to the correct frame
	for i = 1, BLIZZ_MAX_RAID_PULLOUT_FRAMES do
		for j = 1, BLIZZ_MAX_RAID_PULLOUT_BUTTONS do
			raidframe = getglobal('RaidPullout' .. i .. 'Button' .. j);
			if raidframe then
				nextraidframe = nil;
				-- Setup the next raid frame if there it is not the last button in the pullout
				-- And if there's a next frame
				nextraidframe = getglobal('RaidPullout' .. i .. 'Button' .. j+1);
				if nextraidframe then
					if ( j >= BLIZZ_MAX_RAID_PULLOUT_BUTTONS or not nextraidframe:IsVisible() ) then
						nextraidframe = nil;
					end
				end
				BeneCast_AttachPanelToRaidFrame(raidframe, nextraidframe, true);
			end
		end
	end
	
end

-- Attach function for the Standard Raid UI (right)
function BeneCast_RaidAttachSTANDARDRIGHT()

	PutDebugMsg('BeneCast_RaidAttachSTANDARDRIGHT() called')

	local raidframe, nextraidframe;
	-- Attach the panel to the correct frame
	for i = 1, BLIZZ_MAX_RAID_PULLOUT_FRAMES do
		for j = 1, BLIZZ_MAX_RAID_PULLOUT_BUTTONS do
			raidframe = getglobal('RaidPullout' .. i .. 'Button' .. j);
			if raidframe then
				nextraidframe = nil;
				-- Setup the next raid frame if there it is not the last button in the pullout
				-- And if there's a next frame
				nextraidframe = getglobal('RaidPullout' .. i .. 'Button' .. j+1);
				if nextraidframe then
					if ( j >= BLIZZ_MAX_RAID_PULLOUT_BUTTONS or not nextraidframe:IsVisible() ) then
						nextraidframe = nil;
					end
				end
				BeneCast_AttachPanelToRaidFrame(raidframe, nextraidframe, false);
			end
		end
	end
	
end

-- Attach function for CT_RA (bottom)
function BeneCast_RaidAttachCT_RAIDBOTTOM()

	PutDebugMsg('BeneCast_RaidAttachCT_RAIDBOTTOM() called');

	local raidframe, nextraidframe;
	-- Attach the panel to the correct frame
	for i = 1, BLIZZ_MAX_RAID_PULLOUT_FRAMES do
		local group = getglobal("CT_RAGroup" .. i);
		if group then
			local raidframe = group.next;
			while raidframe do
				nextraidframe = nil;
				-- Setup the next raid frame if there it is not the last button in the pullout
				if ( raidframe.next ) then
					nextraidframe = raidframe.next;
				else
					nextraidframe = nil;
				end
				BeneCast_AttachPanelToRaidFrame(raidframe, nextraidframe, true);
				
				raidframe = nextraidframe;
			end
		end
	end
	
end

-- Attach function for CT_RA (right)
function BeneCast_RaidAttachCT_RAIDRIGHT()

	PutDebugMsg('BeneCast_RaidAttachCT_RAIDRIGHT() called');

	local raidframe, nextraidframe;
	-- Attach the panel to the correct frame
	for i = 1, BLIZZ_MAX_RAID_PULLOUT_FRAMES do
		local group = getglobal("CT_RAGroup" .. i);
		if group then
			local raidframe = group.next;
			while raidframe do
				nextraidframe = nil;
				-- Setup the next raid frame if there it is not the last button in the pullout
				if ( raidframe.next ) then
					nextraidframe = raidframe.next;
				else
					nextraidframe = nil;
				end
				BeneCast_AttachPanelToRaidFrame(raidframe, nextraidframe, false);
				
				raidframe = nextraidframe;
			end
		end
	end
	
end

-- Table for raid AddOn options in BeneCast
BeneCast_RaidSnapTo = {};

-- Standard UI Raid Anchors
BeneCast_RaidSnapTo.STANDARDBOTTOM = {

	AddOn = 'BeneCast',
	Funct = BeneCast_RaidAttachSTANDARDBOTTOM,

}

BeneCast_RaidSnapTo.STANDARDRIGHT = {

	AddOn = 'BeneCast',
	Funct = BeneCast_RaidAttachSTANDARDRIGHT,

}

-- CT_Raid Anchors
BeneCast_RaidSnapTo.CT_RAIDBOTTOM = {

	AddOn = 'CT_RaidAssist',
	Funct = BeneCast_RaidAttachCT_RAIDBOTTOM,

}

BeneCast_RaidSnapTo.CT_RAIDRIGHT = {

	AddOn = 'CT_RaidAssist',
	Funct = BeneCast_RaidAttachCT_RAIDRIGHT,

}
