--[[ 

Carnival_EnemyCastBar

Description:
------------
Displays a replication of your targets spell casting bar on your UI, which can be moved around.
Spell casting time is not something that is available to your WoW client, so I have provided cast times for most (if not all spells).
As talents can be a factor on the cast time of some spells, the lowest cast time possible is used
ie. all Shadow Bolt cast times will display at 2.5 seconds even though the player you have targetted doesnt have those specific talents.
Interruptions on your target, ie. they get hit, will not adjust the display on your cast bar, as again, its impossible to know if it affected the cast.
This currently works for both Alliance and Horde, but has only been really tested playing against alliance characters.
Will display either a green cast bar for friendly targets, or a red for a hostile target.

To move the bars, simply do...

/cenemycast lock
/cenemycast show

...then click and drag the bar that appears, then lock again

/cenemycast lock


Support:
--------
Please post on my guilds forums (http://www.carnivalguild.co.uk)
I'm no longer going to be checking the comments on www.curse-gaming.com or ui.worldofwar.net


Author:
-------
Miranda on Al'Akir (EU)
But please, don't ask me for support while im in game!
If you want to thank me however, feel free to do so on my forums...
http://www.carnivalguild.co.uk


Revision History:
-----------------
18/01/06  v1.0 ALPHA
* Initial Alpha Release

24/01/06  v1.1 BETA
* Adjusted bars so that they "grow" from the bottom up
* Adjusted cast time on several spells,
* Added timers for warlock pet spells,
* Added timers for most trinkets, talisman of power, zandalarian hero charm, to show remaining time
* Added timers for gained abilities, arcane power, sprint, to show remaining time,
* Added timers for racial talents, perception, war stomp, will of the forsaken, to show cast time or remaining time depending on the talent,
* Added timers for various PvE events,
 - Molten Core
   - Lucifron (Impending Doom, Lucifron's Curse)
   - Magmadar (Fear)
   - Gehennas (Gehennas' Curse)
   - Majordomo (Magic Reflection, Damage Shield)
   - Ragnaros (Submerge, Knockback and Sons of the Flame)
 - Blackwing Lair
   - Firemaw (Wing Buffet, Shadow Flame)
   - Ebonroc (Wing Buffet, Shadow Flame)
   - Flamegor (Wing Buffet, Shadow Flame)
   - Chromaggus (Frost Burn, Time Lapse, Ignite Flesh, Corrosive Acid, Incinerate)
   - Neferian (Event Start, Bellowing Roar, Class Calls)
* Fixed some possibly laggy code

24/01/06  v1.2 BETA
* Fixed a major problem with the XML frame

27/01/06  v1.3 BETA
* Added Slash Commands
 - /cenemycast enable/disable
 - /cenemycast show
 - /cenemycast pvp
 - /cenemycast pve
* Fixed issue with "X gains Y" events
* Added Stoneform,
* Added Shadowguard,
* Added Priest - Mana Burn,
* Added Priest - Holy Fire,
* Added Priest - Mind Soothe,
* Added Priest - Prayer of Healing,
* Added Priest - Shackle Undead,
* Added Druid - Hibernate,
* Added Druid - Soothe Animal,
* Added Druid - Bark Skin,
* Added Druid - Innervate,
* Added Mage - Conjure Mana Ruby,
* Added Mage - Conjure Mana Citrine,
* Added Mage - Conjure Mana Jade,
* Added Mage - Conjure Mana Agate,
* Added Mage - Slow Fall,
* Added Warrior - Bloodrage,
* Added Warrior - Shield Wall,
* Added Warrior - Recklessness,
* Added Warrior - Berserker Rage,

31/01/06  v1.4 BETA
* Fixed an error about FADESTEP,
* Fixed problem with Bellowing Roar on Nefarian/Onyxia, Onyxia's is 1.5sconds, Nefarain's is 2.0seconds
* Fixed debug output saying "ECB Control - Running i"
* Added cooldown data to the spell database, however the data is not in use yet
* Added timer for Hakkar in Zul'Gurrub
* Added German localization!
* Added /ecb lock - Locks or Unlocks the Casting Bars
* Added /ecb reset - Resets the bar position
* Adjusted Mage - Fireball,
* Adjusted Driud - Bark Skin,
* Adjusted Driud - Innervate,
* Adjusted Druid - Healing Touch,
* Adjusted Druid - Regrowth,
* Adjusted Hunter - Scare Beast,
* Adjusted Mage - Conjure Water,
* Adjusted Mage - Conjure Food,
* Adjusted Paladin - Howl of Terror,
* Adjusted Paladin - Summon Charger,
* Adjusted Paladin - Summon Warhorse
* Adjusted Warlock - Summon Felsteed,
* Adjusted Warlock - Summon Dreadsteed,
* Adjusted Warlock - Imp - Firebolt,
* Adjusted Warrior - Slam,
* Added Paladin - Divine Protection,
* Added Paladin - Divine Shield,
* Added Hunter - Dismiss Pet,
* Added Hunter - Revive Pet,
* Added Hunter - Eyes of the Beast,
* Added Hunter - Rapid Fire,
* Added Mage - Fire Ward,
* Added Mage - Frost Ward,
* Added Mage - Teleport: Darnassus,
* Added Mage - Teleport: Thunder Bluff,
* Added Mage - Teleport: Ironforge,
* Added Mage - Teleport: Orgrimmar,
* Added Mage - Teleport: Stormwind,
* Added Mage - Teleport: Undercity,
* Added Mage - Portal: Darnassus,
* Added Mage - Portal: Thunder Bluff,
* Added Mage - Portal: Ironforge,
* Added Mage - Portal: Orgrimmar,
* Added Mage - Portal: Stormwind,
* Added Mage - Portal: Undercity,
* Added Druid - Teleport: Moonglade,
* Added Druid - Tiger's Fury,
* Added Druid - Frenzied Regeneration,
* Added Druid - Rejuvenation
* Added Druid - Abolish Poison
* Added Priest - Fade,
* Added Priest - Renew,
* Added Priest - Abolish Disease,
* Added Rogue - Evasion,
* Added Rogue - Mind-numbing Poison,
* Added Rogue - Mind-numbing Poison II,
* Added Rogue - Mind-numbing Poison III,
* Added Rogue - Pick Lock,
* Added Shaman - Far Sight,
* Added Shaman - Fire Nova Totem,
* Added Shaman - Mana Tide Totem,
* Added Shaman - Stoneclaw Totem,
* Added Warrior - Slam,
* Added Warrior - Retaliation,
* Added Warlock - Ritual of Doom,
* Added Warlock - Enslave Demon,
* Added Warlock - Inferno, 
* Added Warlock - Shadow Ward,
* Added Warlock - Create Spellstone,
* Added Warlock - Create Healthstone,
* Added Warlock - Create Soulstone,
* Added Warlock - Create Firestone,
* Added Warlock - Voidwalker - Consume Shadows,

20/02/06  v1.5
* Added French Localization
* Added "/cenemycast timer" to toggle the timer text
* Fixed the time issue with Flamestrike and BWL mobs
* Fixed Nefarian/Ragnaros Timers so that they actually work
* Fixed (maybe) the issue with the bars not locking
* Fixed (maybe) the issue with multiple bars for the same mob (BWL Drakes)
* Fixed most (if not all) the issues with some PvE bars not appearing on MC bosses
* Removed the /ecb alias so that it doesnt clash with eCastingBar
* Guessed at a fix for the clash with WarriorAlert 
* Added PvE - BWL - Flamegor - Frenzy
* Added PvE - BWL - Chromaggus - Frenzy
* Added PvE - BWL - Nefarian - Landing Warning
* Added PvE - Outdoor - Azuregos - Manastorm
* Added PvE - AQ40 - Obsidian Eradicator Respawn - 15minutes
* Added PvE - AQ20 - Anubisath - Explode - 5 seconds?
* Added General - First Aid - 8 seconds
* Added Engineering - Frost Reflector
* Added Engineering - Shadow Reflector
* Added Engineering - Fire Reflector
* (Reflectors *should* work, however have had NO testing)
* Added Mage - Ice Block - 10 seconds
* Added Paladin - Blessing of Freedom - 16 seconds
* Added Paladin - Blessing of Protection - 10 seconds
* Added Paladin - Blessing of Sacrifice - 10 seconds
* Adjusted - Hakkar - Blood Siphon - 90 seconds
* Adjusted - Warlock - Summon Imp - 6 seconds
* Adjusted - Warlock - Summon Succubus - 6 seconds
* Adjusted - Warlock - Summon Voidwalker - 6 seconds
* Adjusted - Warlock - Summon Felhunter - 6 seconds

21/02/06  v1.5b
* Fixed problem with French localization
* Fixed problem with German localization
* Adjusted PvE - AQ20 - Anubisath - Explode - 6 seconds

04/04/06 v1.6 Final BETA
* Added the ability to target the player/mob from left clicking the bars, Thanks Astalia
* Added the ability to hide an active bar by shift + left clicking it,
* Added more French spell translations,
* Added more German spell translations, Thanks Tarci,
* Added Carnival - Head Honcho support (private addon),
* Added "/cenemycast clear" will stop and hide all currently showing bars, Thanks Naturfreund
* Added "/cenemycast buffet" will manually start a timer for the first wing buffet, Thanks Naturfreund
* Added "/cenemycast countsec sss" will start a countdown timer with the seconds value "sss", Thanks Naturfreund
* Added "/cenemycast countmin sss" will start a countdown timer with the minute value "sss", Thanks Naturfreund
* Added "/cenemycast scale x" will set the scaling of the bars, Thanks Naturfreund
* Added "/cenemycast alpha x" will set the alpha rating of the bars, Thanks Naturfreund
* Added "/cenemycast repeat x" will repeat a countdown bar until closed  for the time specified, Thanks Naturfreund
* Cleared out some old test code,
* Changed the bar label order, its now "spellname - mobname",
* Changed the way the bar displays timers, if over a minute will display in the format "mm:ss", if under "ss.d"
* Changed the way unique bars work in such a way that they will reset themselves if called again
* Fixed (possibly) the issue with the Wing Buffet not always appearing,
* Fixed the random bars from appearing on mobs, should work correctly now,
* Fixed German localization for the "gain" abilities,
* Fixed German localization for the "afflicttion" abilities, Thanks Naturfreund
* Fixed German localization for the "spell damage" abilities, Thanks Naturfreund
* Fixed the "YELL" issue that was confusing so many people,

This is the last version of the addon I will probably now release
Development has been handed over to someone else now who is re-coding it
If you have any suggestions for him, please post on my forums
http://www.carnivalguild.co.uk
Also, if you need a good host for either your comms server or hosting for any multiplayer game, speak to the nice people at
http://www.multiplay.co.uk
They also run the biggest gaming LAN events in the UK, come <s>harass</s> see me at i27 ;P

]]--
 
carniactive = true;
mobname = "Mob";
mob = "Mob";
spell = "Cast Bar";

function Carnival_EnemyCastBar_OnLoad()

	this:RegisterEvent("CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_HOSTILEPLAYER_BUFF");
	
	this:RegisterEvent("CHAT_MSG_SPELL_FRIENDLYPLAYER_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_FRIENDLYPLAYER_BUFF");
	
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_BUFFS");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_BUFFS");
	
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE");
	
	this:RegisterEvent("CHAT_MSG_SPELL_PARTY_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_PARTY_BUFF");
	
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_PARTY_BUFFS");
	
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS");
	this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE");
	
	this:RegisterEvent("CHAT_MSG_MONSTER_YELL");
	this:RegisterEvent("CHAT_MSG_MONSTER_EMOTE");
	
	this:RegisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH");
	
	this:RegisterEvent("VARIABLES_LOADED");
	
	
	SLASH_CARNIVALENEMYCASTBAR1 = "/cenemycast";  
	SLASH_CARNIVALENEMYCASTBAR2 = "/cecb";  
	SlashCmdList["CARNIVALENEMYCASTBAR"] = function(msg,msg1)
		Carnival_EnemyCastBar_Handler(msg,msg1);
	end
	
	for i=1, 20 do
	
		local button = getglobal("Carni_ECB_"..i);
		local fauxbutton = getglobal("FauxTargetBtn"..i);
		button:Hide();
		fauxbutton:Hide();
		
	end
	
	if( DEFAULT_CHAT_FRAME ) then
	
		DEFAULT_CHAT_FRAME:AddMessage("Carnival_EnemyCastBar AddOn loaded - /cenemycast");
	
	end
  
end

function Carnival_EnemyCastBar_TargetPlayer(txt)

	TargetByName(MobTargetName[tonumber(txt)]);
	DEFAULT_CHAT_FRAME:AddMessage("EnemyCastBar - Targetting \""..MobTargetName[tonumber(txt)].."\"");
	
end

function Carnival_EnemyCastBar_HideBar(num)

	local button = getglobal("Carni_ECB_"..num);
	local fauxbutton = getglobal("FauxTargetBtn"..num);
	fauxbutton:Hide();
	button:Hide();
	DEFAULT_CHAT_FRAME:AddMessage("EnemyCastBar - Deleted \""..button.label.."\"");
	button.spell = nil;
	button.active = false;
	mobname = "";
	
end

function Carnival_EnemyCastBar_LockPos()
	
	Carnival_EnemyCastBar.bLocked = not Carnival_EnemyCastBar.bLocked;
	
	if (Carnival_EnemyCastBar.bLocked) then
	
		for i=1, 20 do
	
			local frame = getglobal("Carni_ECB_"..i);
			local fauxframe = getglobal("FauxTargetBtn"..i);
			frame:StopMovingOrSizing();
			frame:EnableMouse(0);
			fauxframe:EnableMouse(1);
			
		end
		
		DEFAULT_CHAT_FRAME:AddMessage("Carnival_EnemyCastBar - Bars Locked");
	
	else
	
		for i=1, 20 do
	
			local frame = getglobal("Carni_ECB_"..i);
			local fauxframe = getglobal("FauxTargetBtn"..i);
			frame:EnableMouse(1);
			fauxframe:EnableMouse(0);
			
		end	
		
		DEFAULT_CHAT_FRAME:AddMessage("Carnival_EnemyCastBar - Bars Unlocked");
		
	end
	
end

function Carnival_EnemyCastBar_ResetPos()

	Carnival_EnemyCastBar.bScale = 1;
	Carnival_EnemyCastBar.bAlpha = 1;
	local frame = getglobal("Carni_ECB_1");
	local fauxframe = getglobal("FauxTargetBtn1");
	frame:Hide();
	fauxframe:Hide();
	frame:ClearAllPoints();
	frame:SetPoint("BOTTOMLEFT", "UIParent", "CENTER", 0, 0);

	for i=2, 20 do
	
		o = i - 1;
		local frame = getglobal("Carni_ECB_"..i);
		local fauxframe = getglobal("FauxTargetBtn"..i);
		frame:Hide();
		fauxframe:Hide();
		frame:ClearAllPoints();
		frame:SetPoint("TOPLEFT", "Carni_ECB_"..o, "TOPLEFT", 0, 20);
		
	end

end

function Carnival_EnemyCastBar_Options(var)

	if (var) then
	
		return "on";
		
	else
	
		return "off";
		
	end

end

function Carnival_EnemyCastBar_Handler(msg,msg1)

	if (msg == "" or msg == "help") then
	
		DEFAULT_CHAT_FRAME:AddMessage("<Carnival> PvE/PvP Enemy Cast Bar (/cecb)")
		DEFAULT_CHAT_FRAME:AddMessage("/cenemycast enable/disable ("..Carnival_EnemyCastBar_Options(Carnival_EnemyCastBar.bStatus)..") - Enables or Disables the Addon")
		DEFAULT_CHAT_FRAME:AddMessage("/cenemycast show - Shows the bar, this will allow you to move it around")
		DEFAULT_CHAT_FRAME:AddMessage("/cenemycast reset - Resets the bars to their original position")
		DEFAULT_CHAT_FRAME:AddMessage("/cenemycast lock ("..Carnival_EnemyCastBar_Options(Carnival_EnemyCastBar.bLocked)..") - Toggle - Will lock and unlock the bars into position")
		DEFAULT_CHAT_FRAME:AddMessage("/cenemycast pvp ("..Carnival_EnemyCastBar_Options(Carnival_EnemyCastBar.bPvP)..") - Toggles the cast bar for PvP spells on and off")
		DEFAULT_CHAT_FRAME:AddMessage("/cenemycast pve ("..Carnival_EnemyCastBar_Options(Carnival_EnemyCastBar.bPvE)..") - Toggles the cast bar for PvE spells on and off")
		DEFAULT_CHAT_FRAME:AddMessage("/cenemycast timer ("..Carnival_EnemyCastBar_Options(Carnival_EnemyCastBar.bTimer)..") - Toggles the cast bar timer text on and off")
		DEFAULT_CHAT_FRAME:AddMessage("/cenemycast alpha ("..Carnival_EnemyCastBar.bAlpha..") - Alpha blending of the castbar (allowed values from 0.1 to 1.0)")
		DEFAULT_CHAT_FRAME:AddMessage("/cenemycast scale ("..Carnival_EnemyCastBar.bScale..") - Scaling of the castbar, e.g. 0.8 = 80% size (allowed values from 0.1 to 5.0)")
		DEFAULT_CHAT_FRAME:AddMessage("/cenemycast clear - Stops all castbars")                                                                     
		DEFAULT_CHAT_FRAME:AddMessage("/cenemycast buffet - Manually starts the Wingbuffet timer for Firemaw/Ebonroc/Flamegor")                     
		DEFAULT_CHAT_FRAME:AddMessage("/cenemycast countsec sss - Starts a countdown of sss seconds")                                               
		DEFAULT_CHAT_FRAME:AddMessage("/cenemycast countmin mmm - Starts a countdown of mmm minutes")         
		DEFAULT_CHAT_FRAME:AddMessage("/cenemycast repeat sss - Starts a countdown of sss seconds which repeats itself")		
	
	elseif (msg == "enable") then

		Carnival_EnemyCastBar.bStatus = true;
		DEFAULT_CHAT_FRAME:AddMessage("Addon is now enabled")
		
	elseif (msg == "disable") then

		Carnival_EnemyCastBar.bStatus = false;
		DEFAULT_CHAT_FRAME:AddMessage("Addon is now disabled")
		
	elseif (msg == "lock") then

		Carnival_EnemyCastBar_LockPos()
		
	elseif (msg == "reset") then

		Carnival_EnemyCastBar_ResetPos()
		DEFAULT_CHAT_FRAME:AddMessage("Bars are now reset")
		
	elseif (msg == "show") then

		Carnival_EnemyCastBar_Show("Mob", "Spell Name", 20.0, "friendly");
		
	elseif (msg == "timer") then

		if (Carnival_EnemyCastBar.bTimer) then
	
			Carnival_EnemyCastBar.bTimer = false;
			DEFAULT_CHAT_FRAME:AddMessage("Cast Bar time display disabled")
		
		else
		
			Carnival_EnemyCastBar.bTimer = true;
			DEFAULT_CHAT_FRAME:AddMessage("Cast Bars time display enabled")
		
		end
		
	elseif (msg == "pvp") then

		if (Carnival_EnemyCastBar.bPvP) then
	
			Carnival_EnemyCastBar.bPvP = false;
			DEFAULT_CHAT_FRAME:AddMessage("Cast Bars for PvP spells are now disabled")
		
		else
		
			Carnival_EnemyCastBar.bPvP = true;
			DEFAULT_CHAT_FRAME:AddMessage("Cast Bars for PvP spells are now enabled")
		
		end

	elseif (msg == "pve") then

		if (Carnival_EnemyCastBar.bPvE) then
	
			Carnival_EnemyCastBar.bPvE = false;
			DEFAULT_CHAT_FRAME:AddMessage("Cast Bars for PvE spells are now disabled")
		
		else
		
			Carnival_EnemyCastBar.bPvE = true;
			DEFAULT_CHAT_FRAME:AddMessage("Cast Bars for PvE spells are now enabled")
		
		end
		
	elseif (msg == "clear") then		
		
		for i=1, 20 do
	
			local frame = getglobal("Carni_ECB_"..i);
			local fauxframe = getglobal("FauxTargetBtn"..i);
			fauxframe:Hide();
			frame:Hide();
			frame.spell = nil;
			frame.active = false;
			
		end	

	elseif (msg == "buffet") then

		Carnival_EnemyCastBar_Show("BWL", "Wingbuffet", 30.0, "cooldown");

	elseif (string.sub (msg, 1, 8) == "countsec") then

		local msg1 = tonumber (string.sub (msg, 10, 12));

		if ( msg1 < 0.1) then

			DEFAULT_CHAT_FRAME:AddMessage("Invalid value to start the countdown!")

		else

			Carnival_EnemyCastBar_Show(msg1.." Seconds", "Countdown", msg1, "grey");

		end

	elseif (string.sub (msg, 1, 8) == "countmin") then

		local msg1 = tonumber (string.sub (msg, 10, 12));

		if ( msg1 * 60 < 0.1) then

			DEFAULT_CHAT_FRAME:AddMessage("Invalid value to start the countdown!")

		else

			Carnival_EnemyCastBar_Show(msg1.." Minutes", "Countdown", msg1 * 60, "grey");

		end
		
	elseif (string.sub (msg, 1, 5) == "scale") then

		local msg1 = tonumber (string.sub (msg, 7, 9));

		if ( msg1 > 5 or msg1 < 0.1) then

			DEFAULT_CHAT_FRAME:AddMessage("Scale out of range!")

		else

			Carnival_EnemyCastBar.bScale = msg1;
			DEFAULT_CHAT_FRAME:AddMessage("Scale set to: "..msg1)

		end
		
	elseif (string.sub (msg, 1, 5) == "alpha") then

		local msg1 = tonumber (string.sub (msg, 7, 9));

		if ( msg1 > 1 or msg1 < 0.1) then

			DEFAULT_CHAT_FRAME:AddMessage("Alpha out of range!")

		else

			Carnival_EnemyCastBar.bAlpha = msg1;
			DEFAULT_CHAT_FRAME:AddMessage("Alpha set to: "..msg1)

		end

	elseif (string.sub (msg, 1, 6) == "repeat") then

		local msg1 = tonumber (string.sub (msg, 8, 10));

		if ( msg1 < 0.1) then

			DEFAULT_CHAT_FRAME:AddMessage("Invalid value to start the repeater!")

		else

			Carnival_EnemyCastBar_Show(msg1.." Seconds", "Repeater", msg1, "grey");

		end
		
	end
	
end

function Carnival_EnemyCastBar_Show(mob, spell, castime, ctype)

	local showing = false;
	local i = 1;
	local o = 20;
	
	while (i < o) do
	
		local button = getglobal("Carni_ECB_"..i);
		local fauxbutton = getglobal("FauxTargetBtn"..i);
	
		if (not button:IsVisible()) then
		
			if (showing == false) then
			
				if (ctype == "hostile") then
				
					red = 1.0;
					green = 0.0;
					blue = 0.0;					
				
				elseif (ctype == "friendly") then
				
					red = 0.0;
					green = 1.0;
					blue = 0.0;	
					
				elseif (ctype == "cooldown") then
				
					red = 0.0;
					green = 0.0;
					blue = 1.0;	
				
				elseif (ctype == "gains") then
				
					red = 1.0;
					green = 0.0;
					blue = 1.0;
					
				elseif (ctype == "grey") then
				
					red = 0.8;
					green = 0.8;
					blue = 0.8;
				
				end
		
				getglobal("Carni_ECB_"..i).startTime = GetTime();
				getglobal("Carni_ECB_"..i).active = true;
				getglobal("Carni_ECB_"..i).label = spell .." - ".. mob;
				getglobal("Carni_ECB_"..i).spell = spell;
				getglobal("Carni_ECB_"..i).mob = mob;
				getglobal("Carni_ECB_"..i).endTime = getglobal("Carni_ECB_"..i).startTime + castime;
				getglobal("Carni_ECB_"..i.."_StatusBar"):SetMinMaxValues(button.startTime,button.endTime);
				getglobal("Carni_ECB_"..i.."_StatusBar"):SetValue(button.startTime);
				getglobal("Carni_ECB_"..i.."_StatusBar"):SetStatusBarColor(red, green, blue, Carnival_EnemyCastBar.bAlpha);
				fauxbutton:SetScale(Carnival_EnemyCastBar.bScale);
				fauxbutton:Show();
				button:SetScale(Carnival_EnemyCastBar.bScale);
				button:Show();
				MobTargetName[i]=mob;
				showing = true;
			
			end
		
		end
		
		i = i + 1;
		
	end
	
	showing = false;
  
end

function Carnival_EnemyCastBar_Enable()
	
	Carnival_EnemyCastBar.bStatus = true;

end

function Carnival_EnemyCastBar_Disable()

	Carnival_EnemyCastBar.bStatus = false;

end

function Carnival_EnemyCastBar_OnEvent(event)
  
	if (event == "VARIABLES_LOADED") then
	
		if ( not Carnival_EnemyCastBar ) then
		
			Carnival_EnemyCastBar = { };
			Carnival_EnemyCastBar.bStatus = true;
			Carnival_EnemyCastBar.bPvP = true;
			Carnival_EnemyCastBar.bPvE = true;
			Carnival_EnemyCastBar.bLocked = true;
			Carnival_EnemyCastBar.bDebug = false;
			Carnival_EnemyCastBar.bTimer = true;
			Carnival_EnemyCastBar.bScale = 1;
			Carnival_EnemyCastBar.bAlpha = 1;
			
			for i=1, 20 do
		
				local frame = getglobal("Carni_ECB_"..i);
				frame:StopMovingOrSizing();
				frame:EnableMouse(0);
				Carnival_EnemyCastBar.bLocked = true;
				
			end
			
		end
		
		if ( Carnival_EnemyCastBar.bScale == nil) then
		
			Carnival_EnemyCastBar.bScale = 1;
		
		end

		if ( Carnival_EnemyCastBar.bAlpha == nil) then
		
			Carnival_EnemyCastBar.bAlpha = 1;
		
		end
		
		if (not Carnival_EnemyCastBar.bLocked) then
		
			Carnival_EnemyCastBar.bLocked = not Carnival_EnemyCastBar.bLocked;
			Carnival_EnemyCastBar_LockPos(true);
		 
		end
		
		if ( not MobTargetName ) then
		
			MobTargetName = { };
			
		end
		
		if ( IsAddOnLoaded("Carnival_HeadHoncho") ) then
			
			Carnival_HeadHoncho_NewAddon("Carnival_EnemyCastBar","Provides a replication of your enemies cast bar, works for both PvE and PvP");
		
		end
			
	elseif (event == "CHAT_MSG_MONSTER_YELL") then
	
		Carnival_EnemyCastBar_Yells(arg1, arg2);
		
	elseif (event == "CHAT_MSG_MONSTER_EMOTE") then
	
		Carnival_EnemyCastBar_Emotes(arg1, arg2);
	
	else
	
		Carnival_EnemyCastBar_Gfind(arg1);
	
	end
	
end

function Carnival_EnemyCastBar_Gfind(arg1)

	if (Carnival_EnemyCastBar.bStatus) then

		if (arg1 ~= nil) then
	
			for mob, spell in string.gfind(arg1, Carnival_EnemyCastBar_SPELL_CAST) do
					
				Carnival_EnemyCastBar_Control(mob, spell, "casts");
				return;
				
			end	
			
			for mob, spell in string.gfind(arg1, Carnival_EnemyCastBar_SPELL_PERFORM) do
					
				Carnival_EnemyCastBar_Control(mob, spell, "performs");
				return;
				
			end
		
			for mob, spell in string.gfind(arg1, Carnival_EnemyCastBar_SPELL_GAINS) do
					
				Carnival_EnemyCastBar_Control(mob, spell, "gains");
				return;
				
			end
		
			for mob in string.gfind(arg1, Carnival_EnemyCastBar_MOB_DIES) do
				
				Carnival_EnemyCastBar_Control(mob, mob, "cooldown");
				return;
				
			end
			
			for mob, crap, spell in string.gfind(arg1, Carnival_EnemyCastBar_SPELL_AFFLICTED) do

				Carnival_EnemyCastBar_Control(mob, spell, "afflicted");
				return;
				
			end

			for mob, damage, from, spell in string.gfind(arg1, Carnival_EnemyCastBar_SPELL_DAMAGE) do
				
				if (mob == "Hakkar") then
				
					Carnival_EnemyCastBar_Control(mob, spell, "yells");
					return;
				
				end
				
			end
		
		end
	
	end

end

function Carnival_EnemyCastBar_UniqueCheck(spellname, castime, mobname)

	alreadyshowing = 0;
	repushing = 0;

	for i=1, 20 do
	
		local spell = getglobal("Carni_ECB_"..i).spell;
		local mob = getglobal("Carni_ECB_"..i).mob;
		
		if (spell == spellname and mob == mobname) then
		
			alreadyshowing = 1;
			repushing = 1;
			
			local button = getglobal("Carni_ECB_"..i); --START unique updater
			getglobal("Carni_ECB_"..i).startTime = GetTime();
			getglobal("Carni_ECB_"..i).endTime = getglobal("Carni_ECB_"..i).startTime + castime;
			getglobal("Carni_ECB_"..i.."_StatusBar"):SetMinMaxValues(button.startTime,button.endTime);
			getglobal("Carni_ECB_"..i.."_StatusBar"):SetValue(button.startTime); --END unique updater
			break;
		
		end
		
	end
	
	if (Carnival_EnemyCastBar_Raids[spellname].i ~= nil and repushing == 1 and alreadyshowing == 1) then

		castime = Carnival_EnemyCastBar_Raids[spellname].i;
		Carnival_EnemyCastBar_Show(mobname, spellname, castime, "hostile");
	
	end
	
	return alreadyshowing;

end

function Carnival_EnemyCastBar_Control(mob, spell, special)

	if (Carnival_EnemyCastBar_Raids[spell] ~= nil) then
		
		if (Carnival_EnemyCastBar.bPvE) then
				
			castime = Carnival_EnemyCastBar_Raids[spell].t;
			ctype = Carnival_EnemyCastBar_Raids[spell].c;
			
			-- Spell might have the same name but a different cast time on another mob, ie. Onyxia/Nefarian on Bellowing Roar
			if (Carnival_EnemyCastBar_Raids[spell].r) then
			
				if (mob == Carnival_EnemyCastBar_Raids[spell].r) then
				
					castime = Carnival_EnemyCastBar_Raids[spell].a;
				
				end
			
			end
			
			if (Carnival_EnemyCastBar_Raids[spell].m) then
			
				mob = Carnival_EnemyCastBar_Raids[spell].m
			
			end
			
			alreadyshowing = 0;
			
			if (Carnival_EnemyCastBar_Raids[spell].u) then
				
				unique = Carnival_EnemyCastBar_Raids[spell].u
				
				if (unique == "true") then
				
					alreadyshowing = Carnival_EnemyCastBar_UniqueCheck(spell, castime, mob)
				
				end
			
			end
			
			targetok = 0;
			hadtotarget = 0;
			
			if (alreadyshowing == 0) then
				
				-- What is our current target?
				oldtarget = nil;
				oldtarget = UnitName("target");
				
				-- Is out current target the mob casting the recognised spell?
				if (oldtarget ~= mob) then
				
					-- If it isnt, target the mob
					hadtotarget = 1;
					TargetByName(mob);
					--DEFAULT_CHAT_FRAME:AddMessage("EnemyCastBar - Targetting \""..mob.."\" for NPC check for the spell \""..spell.."\"");
				
				else
				
					-- Apparently the current target is the mob
					hadtotarget = 0;
					--DEFAULT_CHAT_FRAME:AddMessage("EnemyCastBar - Already Targetting \""..mob.."\", no need to target again");
				
				end
			
				-- Is now our new target (the mob) a NPC? Also confirm that our new target is in fact the mob
				if (UnitName("target") == mob and not UnitIsPlayer("target")) then
				
					--DEFAULT_CHAT_FRAME:AddMessage("EnemyCastBar - Mob \""..mob.."\" is a NPC");
					-- Target is the mob, and the target is an NPC
					targetok = 1;
					-- Show the bar
					Carnival_EnemyCastBar_Show(mob, spell, castime, ctype);
				
				end
				
				-- If we had to switch to the mob to check if it was an NPC we need to target our old target
				if (hadtotarget == 1) then
				
					-- If the old target was blank, or nil, it means we didnt have a target, so instead lets just target their last
					if (oldtarget == "" or oldtarget == nil) then
					
						-- Target last known target
						TargetLastTarget()
						
					else
					
						-- Otherwise, we know the name of the last targetting mob when we switched it, so target that again
						TargetByName(oldtarget);
					
					end
					
				end
			
			end
			
			if (Carnival_EnemyCastBar_Raids[spell].i ~= nil) then
			
				if (alreadyshowing == 0 and targetok == 1) then
				
					castime = Carnival_EnemyCastBar_Raids[spell].i;
					Carnival_EnemyCastBar_Show(mob, spell, castime, "hostile");
				
				end
			
			end
		
		end
		
	else
	
		if (Carnival_EnemyCastBar.bPvP) then
	
			if (UnitName("target") == mob) then
			
				if (special ~= "afflicted") then
			
					if (Carnival_EnemyCastBar_Spells[spell] ~= nil) then
					
						if (UnitIsEnemy("player", "target")) then
							ctype = "hostile";
						else
							ctype = "friendly";
						end
				
						if (Carnival_EnemyCastBar_Spells[spell].i ~= nil) then
						
							castime = Carnival_EnemyCastBar_Spells[spell].i;
							Carnival_EnemyCastBar_Show(mob, spell, castime, ctype);					
						
						end
						
						castime = Carnival_EnemyCastBar_Spells[spell].t;
						
						if (special == "gains") then
						
							if (Carnival_EnemyCastBar_Spells[spell].g) then
							
								castime = Carnival_EnemyCastBar_Spells[spell].g;
							
							end
						
						end
						
						-- Spell might have the same name but a different cast time on another mob, ie. Death Talon Hatchers/Players on Bellowing Roar
						if (Carnival_EnemyCastBar_Spells[spell].r) then
						
							if (mob == Carnival_EnemyCastBar_Spells[spell].r) then
							
								castime = Carnival_EnemyCastBar_Spells[spell].a;
							
							end
						
						end
						
						if (Carnival_EnemyCastBar_Spells[spell].c ~= nil) then
						
							ctype = Carnival_EnemyCastBar_Spells[spell].c;
						
						end
		
						Carnival_EnemyCastBar_Show(mob, spell, castime, ctype);
						
					end
					
				end
			
			end
				
		end
	
	end
		
end

function Carnival_EnemyCastBar_Yells(arg1, arg2)

	if (Carnival_EnemyCastBar.bStatus) then
	
		if (arg2 == "Nefarian") then
			
			if (

				string.find(arg1, Carnival_EnemyCastBar_NEFARIAN_SHAMAN_CALL) or
				string.find(arg1, Carnival_EnemyCastBar_NEFARIAN_DRUID_CALL) or
				string.find(arg1, Carnival_EnemyCastBar_NEFARIAN_WARLOCK_CALL) or
				string.find(arg1, Carnival_EnemyCastBar_NEFARIAN_PRIEST_CALL) or
				string.find(arg1, Carnival_EnemyCastBar_NEFARIAN_HUNTER_CALL) or
				string.find(arg1, Carnival_EnemyCastBar_NEFARIAN_WARRIOR_CALL) or
				string.find(arg1, Carnival_EnemyCastBar_NEFARIAN_ROGUE_CALL) or
				string.find(arg1, Carnival_EnemyCastBar_NEFARIAN_PALADIN_CALL) or
				string.find(arg1, Carnival_EnemyCastBar_NEFARIAN_MAGE_CALL)
				
			) then
		
				Carnival_EnemyCastBar_Control("Nefarian", "Class Call", "pve");
				return;

			end
			
		elseif (arg2 == "Lord Victor Nefarius") then
		
			if (string.find(arg1, Carnival_EnemyCastBar_NEFARIAN_STARTING)) then
			
				Carnival_EnemyCastBar_Control("Lord Victor Nefarius", "Mob Spawn", "pve");
				return;
			
			elseif (string.find(arg1, Carnival_EnemyCastBar_NEFARIAN_LAND)) then
			
				Carnival_EnemyCastBar_Control("Nefarian", "Landing", "pve");
				return;
			
			end
		
		elseif (arg2 == "Ragnaros") then
		
			if (string.find(arg1, Carnival_EnemyCastBar_RAGNAROS_STARTING)) then
		
				Carnival_EnemyCastBar_Control("Ragnaros", "Submerge", "pve");
				return;
				
			elseif (string.find(arg1, Carnival_EnemyCastBar_RAGNAROS_KICKER)) then
			
				Carnival_EnemyCastBar_Control("Ragnaros", "Knockback", "pve");
				return;
				
			elseif (string.find(arg1, Carnival_EnemyCastBar_RAGNAROS_SONS)) then
			
				Carnival_EnemyCastBar_Control("Ragnaros", "Sons of Flame", "pve");
				return;
			
			end
		
		end
	
	end

end

function Carnival_EnemyCastBar_Emotes(arg1, arg2)

	if (Carnival_EnemyCastBar.bStatus) then

		if (arg2 == "Flamegor") then
		
			if (string.find(arg1, Carnival_EnemyCastBar_FLAMEGOR_FRENZY)) then
		
				Carnival_EnemyCastBar_Control("Flamegor", "Frenzy", "pve");
				return;
				
			end
		
		elseif (arg2 == "Chromaggus") then
		
			if (string.find(arg1, Carnival_EnemyCastBar_CHROMAGGUS_FRENZY)) then
		
				Carnival_EnemyCastBar_Control("Chromaggus", "Killing Frenzy", "pve");
				return;
				
			end
		
		end
	
	end

end

function Carnival_EnemyCastBar_OnUpdate()

	local CECname=this:GetName();
	local CECno="";
	for i=1,strlen(CECname) do
		if (strsub(CECname,i,i)>="0" and strsub(CECname,i,i)<="9") then
			CECno=strsub(CECname,i,strlen(CECname));
			break;
		end
	end
	local fauxbtn=getglobal("FauxTargetBtn"..CECno);

    if (not carniactive) then
	
        -- Fade the bar out
        local alpha = this:GetAlpha() - 0.05;
        if (alpha > 0) then
		
            this:SetAlpha(alpha);
			
        else
		
            -- Hide up, reset alpha
            this:Hide();
			fauxbtn:Hide();
            this:SetAlpha(1.0);
			
        end
		
		this.active = false;
		mobname = "";
		
    else
	
		if (this.endTime ~= nil) then
	
			local label = mobname;
			local now = GetTime();
	
			-- Update the spark, status bar and label
			local remains = this.endTime - now;
			--label = label .. Carnival_EnemyCastBar_NiceTime(remains);
			local sparkPos = ((now - this.startTime) / (this.endTime - this.startTime)) * 195;
			
			getglobal(this:GetName() .. "_StatusBar"):SetValue(now);
			getglobal(this:GetName() .. "_Text"):SetText( this.label );	
			getglobal(this:GetName() .. "_StatusBar_Spark"):SetPoint("CENTER", getglobal(this:GetName() .. "_StatusBar"), "LEFT", sparkPos, 0);
			
			if (Carnival_EnemyCastBar.bTimer) then
			
				getglobal(this:GetName() .. "_CastTimeText"):SetText( Carnival_EnemyCastBar_NiceTime(remains) );
			
			end
			
			if (0 > remains) then
			
				if (getglobal(this:GetName()).spell == "Repeater") then

					local castime = getglobal(this:GetName()).endTime - getglobal(this:GetName()).startTime;
					getglobal(this:GetName()).startTime = GetTime();
					getglobal(this:GetName()).endTime = getglobal(this:GetName()).startTime + castime;
					getglobal(this:GetName().."_StatusBar"):SetMinMaxValues(getglobal(this:GetName()).startTime,getglobal(this:GetName()).endTime);
					getglobal(this:GetName().."_StatusBar"):SetValue(getglobal(this:GetName()).startTime);

				else
			
					getglobal(this:GetName()):Hide();
					fauxbtn:Hide();
					getglobal(this:GetName()).spell = nil;
					this.active = false;
					mobname = "";
				
				end
			
			end
		
		end
    end
end

-- Movable window
function Carnival_EnemyCastBar_OnDragStart()
    CarniEnemyCastBarFrame:StartMoving();
end

function Carnival_EnemyCastBar_OnDragStop()
    CarniEnemyCastBarFrame:StopMovingOrSizing();
end

-- Format seconds into m:ss
function Carnival_EnemyCastBar_NiceTime(secs)
	if (secs < 61) then
		return string.format("%.1f", secs);
	else
		return string.format("%d:%02d", secs / 60, math.mod(secs, 60));
	end
end

