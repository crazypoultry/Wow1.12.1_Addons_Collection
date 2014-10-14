-- RLRP mod by:  J-Dubbs
-- version 0.50

-- DRUID
	-- abolish poison *
	-- cure poison *
	-- faerie fire
	-- healing touch
	-- moonfire
	-- rebirth *
	-- regrowth *
	-- rejuvenation
	-- remove curse *
	-- wrath

-- HUNTER
	-- aimed shot
	-- multi-shot X
	-- serpent sting

-- MAGE
	-- arcane missiles
	-- blizzard
	-- fireball
	-- frost nova
	-- frostbold
	-- pyroblast
	-- scorch
	
-- PRIEST
	-- flash heal
	-- greater heal
	-- heal
	-- lesser heal
	-- renew
	-- shadow word: pain
	-- smite

-- ROGUE
	-- backstab
	-- eviscerate
	-- kidney shot
	-- rupture
	-- sinister strike
	-- slice and dice

-- SHAMAN
	-- cure poison
	-- earth shock
	-- flame shock
	-- frost shock
	-- healing wave
	-- lesser healing wave
	-- lightning bolt
	
-- WARLOCK
	-- corruption
	-- curse of recklessness *
	-- curse of the elements X
	-- immolate
	-- shadow bolt

-- WARRIOR
	-- demoralizing shout
	-- heroic strike
	-- revenge
	-- shield block
	
function rlrp_Main_OnLoad ()
	this:RegisterEvent ("CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE");
	this:RegisterEvent ("CHAT_MSG_SPELL_SELF_BUFF");
	this:RegisterEvent ("CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS");
	this:RegisterEvent ("CHAT_MSG_SPELL_SELF_DAMAGE");
	this:RegisterEvent ("CHAT_MSG_SPELL_FRIENDLYPLAYER_BUFF");
	this:RegisterEvent ("CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_BUFFS");
	this:RegisterEvent ("CHAT_MSG_SPELL_PARTY_BUFF");
	this:RegisterEvent ("CHAT_MSG_SPELL_PERIODIC_PARTY_BUFFS");
	this:RegisterEvent ("CHAT_MSG_SPELL_FRIENDLYPLAYER_DAMAGE");
	this:RegisterEvent ("CHAT_MSG_SPELL_PARTY_DAMAGE");
	this:RegisterEvent ("VARIABLES_LOADED");
	this:RegisterEvent ("CHAT_MSG_SPELL_HOSTILEPLAYER_BUFF");
	this:RegisterEvent ("CHAT_MSG_COMBAT_FRIENDLY_DEATH");
end

function rlrp_Main_OnEvent (event)
	local dir = "Interface\\AddOns\\rlrp\\s\\";
	
	if (event == "VARIABLES_LOADED") then
		DEFAULT_CHAT_FRAME:AddMessage ("time to rlrp!");
	
	-- HOSTILEPLAYER BUFFS
	elseif (event == "CHAT_MSG_SPELL_HOSTILEPLAYER_BUFF") then
		arg1 = strlower (arg1);
		--DEFAULT_CHAT_FRAME:AddMessage ("RLRP hostileplayer_buff");
		
		-- DRUID
		if (strfind (arg1, "healing touch") and not strfind (arg1, "begins")) then
			PlaySoundFile (dir .. "healingtouch.mp3");
		elseif (strfind (arg1, "regrowth") and not strfind (arg1, "begins") and not strfind (arg1, "health")) then
			PlaySoundFile (dir .. "regrowth.mp3");
		
		-- PRIEST
		elseif (strfind (arg1, "lesser heal") and not strfind (arg1, "begins") and not strfind (arg1, "wave")) then
			PlaySoundFile (dir .. "lesserheal.mp3");
		elseif (strfind (arg1, "greater heal") and not strfind (arg1, "begins")) then
			PlaySoundFile (dir .. "greaterheal.mp3");
		elseif (strfind (arg1, "heal") and not strfind (arg1, "begins") and not strfind (arg1, "greater") and not strfind (arg1, "lesser") and not strfind (arg1, "flash") and not strfind (arg1, "wave") and not strfind (arg1, "first aid") and not strfind (arg1, "totem")) then
			PlaySoundFile (dir .. "heal.mp3");
		elseif (strfind (arg1, "flash heal") and not strfind (arg1, "begins")) then
			PlaySoundFile (dir .. "flashheal.mp3");
		
		-- SHAMAN
		elseif (strfind (arg1, "lesser healing wave") and not strfind (arg1, "begins")) then
			PlaySoundFile (dir .. "lesserhealingwave.mp3");
		elseif (strfind (arg1, "healing wave") and not strfind (arg1, "begins") and not strfind (arg1, "lesser")) then
			PlaySoundFile (dir .. "healingwave.mp3");
		end
	
	-- PERIODIC CREATURE DAMAGE
	elseif (event == "CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE") then
		arg1 = strlower (arg1);
		--DEFAULT_CHAT_FRAME:AddMessage ("RLRP periodic_creature_damage");
		
		-- DRUID
		if (strfind (arg1, "faerie fire") and not strfind (arg1, "suffers")) then
			PlaySoundFile (dir .. "faeriefire.mp3");
		
		-- HUNTER
		elseif (strfind (arg1, "serpent sting") and not strfind (arg1, "suffers")) then
			PlaySoundFile (dir .. "serpentsting.mp3");
		
		-- MAGE
		elseif (strfind (arg1, "blizzard") and not strfind (arg1, "suffers")) then
			PlaySoundFile (dir .. "blizzard.mp3");
		
		-- PRIEST
		elseif (strfind (arg1, "shadow word: pain") and not strfind (arg1, "suffers")) then
			PlaySoundFile (dir .. "shadowwordpain.mp3");
		
		-- ROGUE
		elseif (strfind (arg1, "kidney shot") and not strfind (arg1, "suffers")) then
			PlaySoundFile (dir .. "kidneyshot.mp3");
		elseif (strfind (arg1, "rupture") and not strfind (arg1, "suffers")) then
			PlaySoundFile (dir .. "rupture.mp3");
		
		-- SHAMAN
		elseif (strfind (arg1, "flame shock") and not strfind (arg1, "suffers")) then
			PlaySoundFile (dir .. "flameshock.mp3");
		
		-- WARLOCK
		elseif (strfind (arg1, "corruption") and not strfind (arg1, "suffers")) then
			PlaySoundFile (dir .. "corruption.mp3");
		elseif (strfind (arg1, "curse of the elements") and not strfind (arg1, "suffers")) then
			PlaySoundFile (dir .. "curseofelementals.mp3");
		elseif (strfind (arg1, "curse of recklessness") and not strfind (arg1, "suffers")) then
			PlaySoundFile (dir .. "curseofrecklessness.mp3");
		
		-- WARRIOR
		elseif (strfind (arg1, "demoralizing shout") and not strfind (arg1, "suffers")) then
			PlaySoundFile (dir .. "demoralizingshout.mp3");
		end
	
	-- FRIENDLY BUFF
	elseif (event == "CHAT_MSG_SPELL_FRIENDLYPLAYER_BUFF" or event == "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_BUFFS" or event == "CHAT_MSG_SPELL_PARTY_BUFF" or event == "CHAT_MSG_SPELL_PERIODIC_PARTY_BUFFS" or event == "CHAT_MSG_SPELL_SELF_BUFF" or event == "CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS") then
		arg1 = strlower (arg1);
		--DEFAULT_CHAT_FRAME:AddMessage ("RLRP friendlyplayer_buff");
		
		-- DRUID
		if (strfind (arg1, "healing touch") and not strfind (arg1, "begins")) then
			PlaySoundFile (dir .. "healingtouch.mp3");
		elseif (strfind (arg1, "rejuvenation") and not strfind (arg1, "begins") and not strfind (arg1, "health")) then
			PlaySoundFile (dir .. "rejuvenation.mp3");
		elseif (strfind (arg1, "regrowth") and not strfind (arg1, "begins") and not strfind (arg1, "health")) then
			PlaySoundFile (dir .. "regrowth.mp3");
		elseif (strfind (arg1, "cure poison") and not strfind (arg1, "begins")) then
			PlaySoundFile (dir .. "curepoison.mp3");
		elseif (strfind (arg1, "rebirth") and not strfind (arg1, "begins")) then
			PlaySoundFile (dir .. "rebirth.mp3");
		elseif (strfind (arg1, "remove curse") and not strfind (arg1, "begins")) then
			PlaySoundFile (dir .. "removecurse.mp3");
		elseif (strfind (arg1, "abolish poison") and not strfind (arg1, "begins")) then
			PlaySoundFile (dir .. "abolishpoison.mp3");
		
		-- PRIEST
		elseif (strfind (arg1, "lesser heal") and not strfind (arg1, "begins") and not strfind (arg1, "wave")) then
			PlaySoundFile (dir .. "lesserheal.mp3");
		elseif (strfind (arg1, "renew") and not strfind (arg1, "begins") and not strfind (arg1, "health")) then
			PlaySoundFile (dir .. "renew.mp3");
		elseif (strfind (arg1, "greater heal") and not strfind (arg1, "begins")) then
			PlaySoundFile (dir .. "greaterheal.mp3");
		elseif (strfind (arg1, "heal") and not strfind (arg1, "begins") and not strfind (arg1, "greater") and not strfind (arg1, "lesser") and not strfind (arg1, "flash") and not strfind (arg1, "wave") and not strfind (arg1, "first aid") and not strfind (arg1, "gain") and not strfind (arg1, "totem")) then
			PlaySoundFile (dir .. "heal.mp3");
		elseif (strfind (arg1, "flash heal") and not strfind (arg1, "begins")) then
			PlaySoundFile (dir .. "flashheal.mp3");
		
		-- ROGUE
		elseif (strfind (arg1, "slice and dice") and not strfind (arg1, "begins")) then
			PlaySoundFile (dir .. "sliceanddice.mp3");
		
		-- SHAMAN
		elseif (strfind (arg1, "lesser healing wave") and not strfind (arg1, "begins")) then
			PlaySoundFile (dir .. "lesserhealingwave.mp3");
		elseif (strfind (arg1, "healing wave") and not strfind (arg1, "begins") and not strfind (arg1, "lesser")) then
			PlaySoundFile (dir .. "healingwave.mp3");
		
		-- WARRIOR
		elseif (strfind (arg1, "shield block") and not strfind (arg1, "begins")) then
			PlaySoundFile (dir .. "shieldblock.mp3");
		end
	
	-- FRIENDLY DAMAGE
	elseif (event == "CHAT_MSG_SPELL_FRIENDLYPLAYER_DAMAGE" or event == "CHAT_MSG_SPELL_PARTY_DAMAGE" or event == "CHAT_MSG_SPELL_SELF_DAMAGE") then
		arg1 = strlower (arg1);
		--DEFAULT_CHAT_FRAME:AddMessage ("RLRP friendlyplayer_damage");
		
		-- DRUID
		if (strfind (arg1, "wrath") and not strfind (arg1, "begins")) then
			PlaySoundFile (dir .. "wrath.mp3");
		elseif (strfind (arg1, "moonfire") and not strfind (arg1, "begins")) then
			PlaySoundFile (dir .. "moonfire.mp3");
		
		-- HUNTER
		elseif (strfind (arg1, "aimed shot") and not strfind (arg1, "begins")) then
			PlaySoundFile (dir .. "aimedshot.mp3");
		elseif (strfind (arg1, "multi-shot") and not strfind (arg1, "begins")) then
			PlaySoundFile (dir .. "multi-shot.mp3");
		
		-- MAGE
		elseif (strfind (arg1, "fireball") and not strfind (arg1, "begins")) then
			PlaySoundFile (dir .. "fireball.mp3");
		elseif (strfind (arg1, "frostbolt") and not strfind (arg1, "begins")) then
			PlaySoundFile (dir .. "frostbolt.mp3");
		elseif (strfind (arg1, "frost nova") and not strfind (arg1, "begins")) then
			PlaySoundFile (dir .. "frostnova.mp3");
		elseif (strfind (arg1, "scorch") and not strfind (arg1, "begins")) then
			PlaySoundFile (dir .. "scorch.mp3");
		elseif (strfind (arg1, "arcane missiles") and not strfind (arg1, "begins")) then
			PlaySoundFile (dir .. "arcanemissiles.mp3");
		elseif (strfind (arg1, "pyroblast") and not strfind (arg1, "begins")) then
			PlaySoundFile (dir .. "pyroblast.mp3");
		
		-- PRIEST
		elseif (strfind (arg1, "smite") and not strfind (arg1, "begins")) then
			PlaySoundFile (dir .. "smite.mp3");
		
		-- ROGUE
		elseif (strfind (arg1, "backstab") and not strfind (arg1, "begins")) then
			PlaySoundFile (dir .. "backstab.mp3");
		elseif (strfind (arg1, "sinister strike") and not strfind (arg1, "begins")) then
			PlaySoundFile (dir .. "sinisterstrike.mp3");
		elseif (strfind (arg1, "eviscerate") and not strfind (arg1, "begins")) then
			PlaySoundFile (dir .. "eviscerate.mp3");
		
		-- SHAMAN
		elseif (strfind (arg1, "frost shock") and not strfind (arg1, "begins")) then
			PlaySoundFile (dir .. "frostshock.mp3");
		elseif (strfind (arg1, "earth shock") and not strfind (arg1, "begins")) then
			PlaySoundFile (dir .. "earthshock.mp3");
		elseif (strfind (arg1, "lightning bolt") and not strfind (arg1, "begins")) then
			PlaySoundFile (dir .. "lightningbolt.mp3");
		
		-- WARLOCK
		elseif (strfind (arg1, "shadow bolt") and not strfind (arg1, "begins")) then
			PlaySoundFile (dir .. "shadowbolt.mp3");
		elseif (strfind (arg1, "immolate") and not strfind (arg1, "begins")) then
			PlaySoundFile (dir .. "immolate.mp3");
		
		-- WARRIOR
		elseif (strfind (arg1, "revenge") and not strfind (arg1, "begins")) then
			PlaySoundFile (dir .. "revenge.mp3");
		elseif (strfind (arg1, "heroic strike") and not strfind (arg1, "begins")) then
			PlaySoundFile (dir .. "heroicstrike.mp3");
		end
	
	-- UNIT HEALTH
	elseif (event == "CHAT_MSG_COMBAT_FRIENDLY_DEATH") then
		--DEFAULT_CHAT_FRAME:AddMessage ("RLRP friendly_death");
		
		local randyell = math.random (5);
		
		if (randyell == 1) then
			PlaySoundFile (dir .. "fuck.mp3");
		elseif (randyell == 2) then
			PlaySoundFile (dir .. "whatthefuck.mp3");
		elseif (randyell == 3) then
			PlaySoundFile (dir .. "thatsafucking50dkpminus.mp3");
		elseif (randyell == 4) then
			PlaySoundFile (dir .. "whatthefuckwasthatshit.mp3");
		elseif (randyell == 5) then
			PlaySoundFile (dir .. "whothefuckwasthat.mp3");
		end
	end
end