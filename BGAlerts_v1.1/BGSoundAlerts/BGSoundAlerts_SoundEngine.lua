-- This is BGSoundAlerts Sound Engine
-- Keeps track of what is to play next and when
BGSoundAlerts_SoundQueue = { };
BGSoundAlerts_Cooldowns = { };
BGSoundAlerts_NextUpdate = 0.3;
BGSoundAlerts_NextKillUpdate = 25;
BGSoundAlerts_ResourcesByUpdate = 1;
local KillSpree_Kills = 0;
local MAX_NUMBER_OF_KILLS = 7;
BGSoundAlerts_ABGameTime = 0;

BGSoundAlerts_FirstBloodPlayer = nil;
BGSoundAlerts_FirstBloodFaction = nil;

BGSoundAlerts_VoiceChatNo = 0;

-- Also contains the killing spree sounds functionality

-- Just to keep this file clean, the SoundLengths are in another file
function BGSoundAlerts_IsOnCooldown(file)

	local i;
	
	for i = 1, table.getn(BGSoundAlerts_Cooldowns) do
		if (string.upper(BGSoundAlerts_Cooldowns[i].dir) == string.upper(file)) then
			return true;
		end
	end

	return false;
	
end
	
function BGSoundAlerts_AddToQueue(file,unique)
	-- This function will add file to the sound queue to be played
	-- If the sound could not be found in the sound lengths table then just play it
	-- If a unique sound is already in the queue then don't add it (if the sound is already playing then the sound is still added to the queue)
	local i;
	local filefoundlength, cooldown;
	
	-- This is a table of soundlengths according to the selected SoundPack. DefaultPack = BGSoundAlerts_DefaultPackDurations
	if (SoundsPack == "DefaultPack") then
		local soundlengthtable = getglobal("BGSoundAlerts_" .. SoundsPack .. "Durations");
		
		-- Is .wav at the end?
		if ((not string.find(file,".wav",string.len(file) - 3)) and (not string.find(file,".WAV",string.len(file) - 3))) then
			-- Nope so add it
			file = file .. ".wav";
		end
		
		if (unique) then
			for i = 1, table.getn(BGSoundAlerts_SoundQueue) do
				if (string.upper(BGSoundAlerts_SoundQueue[i].dir) == string.upper(file)) then
					-- The unique sound was already found in the queue
					return;
				end
			end
		end
		
		-- Check if the sound is on cooldown
		if (BGSoundAlerts_IsOnCooldown(file)) then
			-- Still on cooldown
			return;
		end
		
		for i = 1, table.getn(soundlengthtable) do
			if (string.upper(soundlengthtable[i].dir) == string.upper(file)) then
				filefoundlength = soundlengthtable[i].duration;
				-- Check if need to apply a cooldown
				if (soundlengthtable[i].cooldown) then
					cooldown = soundlengthtable[i].cooldown;
				end
			end
		end
		
		if (filefoundlength) then
			local temptable = {
				dir = file,
				length = filefoundlength + 0.1
				};
			
			if (cooldown) then
				-- This sound has a cooldown.
				local atemptable = { 
					dir = file,
					cd = cooldown
					};
				table.insert(BGSoundAlerts_Cooldowns,atemptable);
			end
			
			-- Insert the sound into the queue
			table.insert(BGSoundAlerts_SoundQueue,temptable);
		else
			-- Not in the sound table so just play it
			PlaySoundFile(file);
		end
	else	
		-- We've got lengths for DefaultPack. If that's not selected just play it
		PlaySoundFile(file);
	end
end

function BGSoundAlerts_AddNumberToQueue(number)

	-- This function will add a number to the sound queue
	local i, x;
	number = tostring(number);
	if (tonumber(number) < 20 and tonumber(number) > 10) then
		-- It's between 10 and 20
		BGSoundAlerts_AddToQueue("Interface\\AddOns\\BGSoundAlerts\\DefaultPack\\" .. number .. ".wav");
	else
		-- Play the score numbers
		if (tonumber(string.sub(number,string.len(number) - 1,string.len(number))) > 10 and tonumber(string.sub(number,string.len(number) - 1,string.len(number))) < 20) then
			for i = 1, string.len(number) - 2 do
				local file = "Interface\\AddOns\\BGSoundAlerts\\DefaultPack\\" .. string.sub(number,i,i);
				for x = string.len(number) - 1, i, -1 do
					file = file .. "0";						-- Add 0s
				end
				file = file .. ".wav";
				BGSoundAlerts_AddToQueue(file);
			end
			BGSoundAlerts_AddToQueue("Interface\\AddOns\\BGSoundAlerts\\DefaultPack\\" .. string.sub(number,string.len(number) - 1,string.len(number)));
		else
			for i = 1, string.len(number) do
				local file = "Interface\\AddOns\\BGSoundAlerts\\DefaultPack\\" .. string.sub(number,i,i);
				for x = string.len(number) - 1, i, -1 do
					file = file .. "0";						-- Add 0s
				end
				file = file .. ".wav";
				BGSoundAlerts_AddToQueue(file);
			end
		end
	end
end
	

function BGSoundAlerts_ClearSoundQueue()
	-- This function will clear all the sound queue
	-- This is used for example in the end of a battle where you no longer need to hear any more announcements
	local i;
	
	for i = table.getn(BGSoundAlerts_SoundQueue), 1 do
		table.remove(BGSoundAlerts_SoundQueue,i);
	end
end

function BGSoundAlerts_PlayNextSound()
	-- This function will play the next sound in the queue and return how long that sound will play
	-- If there is no sound in the queue it will just return 0.3
	if (BGSoundAlerts_SoundInQueue()) then
		if ((BGSoundAlerts_VoiceChatNo <= 0) or (PauseInVoiceChat == 0)) then
			-- Play a sound only if no one is speaking on voicechat
			local x;
			
			PlaySoundFile(BGSoundAlerts_SoundQueue[1].dir);
			x = BGSoundAlerts_SoundQueue[1].length;
			table.remove(BGSoundAlerts_SoundQueue,1);
			return x;
		else
			return 0.3;			-- If someone is speaking on voicechat then pause the queue
		end
	else
		return 0.3;
	end
end

function BGSoundAlerts_SoundInQueue()
	-- This function will return 1 if there is a sound in the queue, nil otherwise
	if (table.getn(BGSoundAlerts_SoundQueue) > 0) then
		return 1;
	else
		return nil;
	end
end

function BGSoundAlerts_SoundEngineEvent(event,name,unitId)

	if (event == "VOICE_PLATE_START") then
		-- Someone started voicechat
		BGSoundAlerts_VoiceChatNo = BGSoundAlerts_VoiceChatNo + 1;
	elseif (event == "VOICE_PLATE_STOP") then
		-- Someone stopped voicechat
		BGSoundAlerts_VoiceChatNo = BGSoundAlerts_VoiceChatNo - 1;
	end
	
	if (BGSoundAlerts_VoiceChatNo < 0) then
		-- Validate
		BGSoundAlerts_VoiceChatNo = 0;
	end

end

function BGSoundAlerts_UpdateSoundEngine(elapsed)

	local i;

	-- Do cooldowns
	for i = table.getn(BGSoundAlerts_Cooldowns), 1, -1 do
		BGSoundAlerts_Cooldowns[i].cd = BGSoundAlerts_Cooldowns[i].cd - elapsed;
		if (BGSoundAlerts_Cooldowns[i].cd <= 0) then
			-- Cooldown ended
			table.remove(BGSoundAlerts_Cooldowns,i);
		end
	end

	this.TimeSinceLastUpdate = this.TimeSinceLastUpdate + elapsed; 	
	while (this.TimeSinceLastUpdate > BGSoundAlerts_NextUpdate) do
		this.TimeSinceLastUpdate = this.TimeSinceLastUpdate - BGSoundAlerts_NextUpdate;
		BGSoundAlerts_NextUpdate = BGSoundAlerts_PlayNextSound();
	end
end

function BGSoundAlerts_UpdateABScore(elapsed)
	-- This should happen only in Arathi Basin
	if (GetRealZoneText() == "Arathi Basin" and ABScore == 1) then
		if (not WorldMapFrame:IsVisible()) then
			-- It appears there's a problem when the World Map is open
			this.TimeSinceLastUpdate = this.TimeSinceLastUpdate + elapsed;
		end
		while (this.TimeSinceLastUpdate > ABScoreDelay * 60) do
			BGSoundAlerts_ABGameTime = BGSoundAlerts_ABGameTime + ABScoreDelay;
			
			local _,_,AllianceScore = GetWorldStateUIInfo(1);
			local _,_,HordeScore = GetWorldStateUIInfo(2);			
			
			AllianceScore = tonumber(string.sub(AllianceScore,21,string.find(AllianceScore,"/") - 1));
			HordeScore = tonumber(string.sub(HordeScore,21,string.find(HordeScore,"/") - 1));
			
			if (AllianceScore == 0) and (HordeScore == 0) then
				-- No score
				this.TimeSinceLastUpdate = this.TimeSinceLastUpdate - ABScoreDelay * 60;
				return;
			end
			
			if (SoundsPack == "DefaultPack") then
				
				BGSoundAlerts_AddToQueue("Interface\\AddOns\\BGSoundAlerts\\DefaultPack\\After.wav");
				BGSoundAlerts_AddNumberToQueue(BGSoundAlerts_ABGameTime);
				BGSoundAlerts_AddToQueue("Interface\\AddOns\\BGSoundAlerts\\DefaultPack\\MinutesArathiBasin.wav");
				
				if (not AllianceScore) or (not HordeScore) then
					-- Invalid score parsing
					this.TimeSinceLastUpdate = this.TimeSinceLastUpdate - ABScoreDelay * 60;
					return;
				end
				
				-- See who's in the lead
				if (AllianceScore > HordeScore) then
						BGSoundAlerts_AddToQueue("Interface\\AddOns\\BGSoundAlerts\\DefaultPack\\Alliance.wav");
				elseif (AllianceScore <= HordeScore) then
						BGSoundAlerts_AddToQueue("Interface\\AddOns\\BGSoundAlerts\\DefaultPack\\Horde.wav");
				end
				
				BGSoundAlerts_AddToQueue("Interface\\AddOns\\BGSoundAlerts\\DefaultPack\\InTheLead.wav");
				
				if (BGSoundAlerts_ResourcesByUpdate == 1) then
				    local Diff = 0;
				    BGSoundAlerts_AddToQueue("Interface\\AddOns\\BGSoundAlerts\\DefaultPack\\By.wav");
				    -- Work out score difference
				    if (AllianceScore > HordeScore) then
						Diff = AllianceScore - HordeScore;
				    else
						Diff = HordeScore - AllianceScore;
				    end
					-- Play score difference
					BGSoundAlerts_AddNumberToQueue(Diff);
				else                 				
					-- Here comes the important bit
					
					BGSoundAlerts_AddToQueue("Interface\\AddOns\\BGSoundAlerts\\DefaultPack\\Alliance.wav");				
					
					-- Play the Alliance score
					BGSoundAlerts_AddNumberToQueue(AllianceScore);
					
					BGSoundAlerts_AddToQueue("Interface\\AddOns\\BGSoundAlerts\\DefaultPack\\Resources.wav");
					BGSoundAlerts_AddToQueue("Interface\\AddOns\\BGSoundAlerts\\DefaultPack\\And.wav");
					BGSoundAlerts_AddToQueue("Interface\\AddOns\\BGSoundAlerts\\DefaultPack\\Horde.wav");
					
					-- Play the Horde score
					BGSoundAlerts_AddNumberToQueue(HordeScore);
			    end
				
				BGSoundAlerts_AddToQueue("Interface\\AddOns\\BGSoundAlerts\\DefaultPack\\Resources.wav");
			end
			this.TimeSinceLastUpdate = this.TimeSinceLastUpdate - ABScoreDelay * 60;
		end
	else
		-- We're not in AB so reset the timers
		this.TimeSinceLastUpdate = 0;
		BGSoundAlerts_ABGameTime = 0;
	end
end

function BGSoundAlerts_ApplyKillBonus(killmsg)
	
	if (MultiKillSounds == 1) then
		if (GetRealZoneText() == "Alterac Valley") or (GetRealZoneText() == "Warsong Gulch")
			or (GetRealZoneText() == "Arathi Basin") then
				if (string.find(killmsg,"You have slain") ~= nil) then
					if not (string.find(killmsg,"Chicken") or string.find(killmsg,"Rat") or (string.find(killmsg,"Stormpike") and not string.find(killmsg,"Vanndar")) or string.find(killmsg,"Frostwolf")
					or string.find(killmsg,"Alterac Ram")) then
						-- Player slain something in BGs
						-- Reset KillBonus timer and play a kill bonus sound
						this.TimeSinceLastUpdate = 0;
						KillSpree_Kills = KillSpree_Kills + 1;
						if (KillSpree_Kills > MAX_NUMBER_OF_KILLS) then
							KillSpree_Kills = MAX_NUMBER_OF_KILLS;
						end
						BGSoundAlerts_AddToQueue("Interface\\Addons\\BGSoundAlerts\\" .. SoundsPack .. "\\" .. 						KillSpree_Kills .. "Kill.wav");
					else
						return;
					end
				end
			end
		end
end

function BGSoundAlerts_UpdateKillBonus(elapsed)
	this.TimeSinceLastUpdate = this.TimeSinceLastUpdate + elapsed; 	
	while (this.TimeSinceLastUpdate > BGSoundAlerts_NextKillUpdate) do
	    this.TimeSinceLastUpdate = this.TimeSinceLastUpdate - BGSoundAlerts_NextKillUpdate;
		-- Reset Kills
		KillSpree_Kills = 0;
	end
end

function BGSoundAlerts_NewScoreReceived()

	if (BGSoundAlerts_FirstBloodPlayer ~= nil) then
		-- There already has been a first blood
		return;
	end

	local i;
	-- Start scanning each player
	for i = 1, GetNumBattlefieldScores() do
		local name, blows, _, _, _, faction = GetBattlefieldScore(i);
		if (blows > 1) then
			-- There has been more than 1 kill blow
			BGSoundAlerts_FirstBloodPlayer = "NOONE";
			return;
		end
		if (blows == 1) then
			-- It might be the first killing blow
			if (BGSoundAlerts_FirstBloodPlayer == nil) then
				BGSoundAlerts_FirstBloodPlayer = name;
				if (faction == 0) then
					BGSoundAlerts_FirstBloodFaction = "Horde";
				else
					BGSoundAlerts_FirstBloodFaction = "Alliance";
				end
			else
				-- Someone else has got a killing blow so it can't be a first blood
				BGSoundAlerts_FirstBloodPlayer = "NOONE";
				return;
			end
		end
	end
	
	if (BGSoundAlerts_FirstBloodPlayer ~= nil) then
		-- There has been a first blood
		if (BGSoundAlerts_FirstBloodPlayer == UnitName("player")) then
			-- It's the player! Well done
			if (FirstBloodSounds == 1) then
				BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\FirstBlood.wav");
			end
		else
			if (BGSoundAlerts_FirstBloodPlayer ~= nil) and (BGSoundAlerts_FirstBloodPlayer ~= "NOONE") then
				-- It's some other player
			end
		end
	end
	
end