--just close your eyes... and die away with me...
BINDING_HEADER_FeralSkills = "Feral Skills";
BINDING_NAME_Settings = "Feral Skills Settings";
BINDING_NAME_Maul = "Maul+";
BINDING_NAME_Claw = "Claw+";
BINDING_NAME_Shred = "Shred+";
BINDING_NAME_Shift = "Shift+";
BINDING_NAME_ShiftBear = "Shift to [Dire] Bear Form";
BINDING_NAME_ShiftCat = "Shift to Cat Form";
BINDING_NAME_ShiftTravel = "Shift to Travel/Aquatic Form";
BINDING_NAME_ShiftMount = "Mount and Cast Instant";

FeralSkills_CurrentVersion = 1.1;

function FeralSkills_SetDefaultSettings()
	FeralSkills_Immunities = {}
	FeralSkills_Settings = {
		DontAutoTarget = true;
		TrackImmunities = true;
		LastVersion = 1.1;
		Maul = {
			AutoShift = true;
			Growl = {
				Enabled = true;
				NotAggroed = true;
				TargetTargetSquishy = true;
			};
			FeralCharge = {
				Enabled = true;
			};
			Enrage = {
				Enabled = true;
				MaxRageEnabled = true;
				MaxRage = 25;
			};
			FaerieFire = {
				Enabled = true;
				NotDebuffed = true;
			};
			DemoralizingRoar = {
				Enabled = true;
				MinRageEnabled = true;
				MinRage = 19;
				NotDebuffed = true;
			};
			Swipe = {
				Enabled = true;
				MinRageEnabled = true;
				MinRage = 24;
				GroupOnly = false;
			};
		};
		Claw = {
			AutoShift = true;
			TigersFury = {
				Enabled = true;
				Extra = true;
			};
			Rake = {
				Enabled = true;
				HighArmor = true;
				MinHealthEnabled = true;
				MinHealth = 50;
			};
			Cower = {
				Enabled = nil;
				Aggroed = nil;
			};
			FaerieFire = {
				Enabled = true;
				NotDebuffed = true;
			};
			Rip = {
				Enabled = true;
				ComboPoints = 3;
				HighArmor = true;
				MinHealthEnabled = true;
				MinHealth = 60;
			};
			FerociousBite = {
				Enabled = true;
				ComboPoints = 4;
				MinEnergyEnabled = nil;
				MinEnergy = 70;
				MaxHealthEnabled = nil;
				MaxHealth = 30;
				Killshot = true;
			};
		};
		Shred = {
			AutoShift = true;
			TigersFury = {
				Enabled = true;
				Extra = true;
			};
			Pounce = {
				Enabled = true;
				GroupOnly = false;
				ModifierEnabled = true;
				Modifier = 2;
			};
			Cower = {
				Enabled = true;
				Aggroed = true;
			};
			FaerieFire = {
				Enabled = true;
				NotDebuffed = true;
			};
			Rip = {
				Enabled = true;
				ComboPoints = 3;
				HighArmor = true;
				MinHealthEnabled = true;
				MinHealth = 60;
			};
			FerociousBite = {
				Enabled = true;
				ComboPoints = 4;
				MinEnergyEnabled = nil;
				MinEnergy = 70;
				MaxHealthEnabled = nil;
				MaxHealth = 30;
				Killshot = true;
			};
		};
		Shift = {
			Bear = {
				Enabled = true;
				Modifier = 2;
				Enrage = nil;
				Caster = true;
			};
			Cat = {
				Enabled = true;
				Modifier = 1;
				Prowl = nil;
				Caster = true;
			};
			Travel = {
				Enabled = true;
				Modifier = 3;
				Caster = true;
			};
			Mount = {
				Enabled = true;
				Modifier = 4;
				Name = "";
				SpellEnabled = nil;
				Spell = "";
				Caster = true;
			};
		};
	};
end

FeralSkills_SetDefaultSettings();

--FeralSkills_Settings["Maul_GrowlLevel"] = 1; --0=No Growl, 1=Growl when not target"s target, 2=Growl always
--FeralSkills_Settings["Maul_FeralChargeLevel"] = 1; --0=No Feral Charge, 1=Feral Charge always
--FeralSkills_Settings["Maul_EnrageMaxRage"] = 15; --Enrage when rage is less than this. 0=Never enrage, 101=Always Enrage
--FeralSkills_Settings["Maul_DemoralizingRoarLevel"] = 0; --0=No DR, 1=DR when target not DR"d, 2=DR always
--FeralSkills_Settings["Maul_DemoralizingRoarMinRage"] = 20; --Demoralizing Roar when rage is more than this. 100=Never Demoralizing Roar, 0=Always Demoralizing Roar
--FeralSkills_Settings["Maul_FaerieFireLevel"] = 1; --0=No FF, 1=FF when target not FF"d, 2=FF always
--FeralSkills_Settings["Maul_SwipeMinRage"] = 49; --Swipe when rage is more than this. 100=Never swipe, 0=Always Swipe
--FeralSkills_Settings["Maul_SwipeOnlyInGroup"] = 0; --0=Swipe regarless of being grouped. 1=Swipe only when in a group.

--FeralSkills_Settings["Claw_TigersFuryLevel"] = 1; --0=No TF, 1=TF when you have extra energy, 2=TF always
--FeralSkills_Settings["Claw_RakeMinTargetHealth"] = 50; --Rake when target"s health is at least this %. 0=Always Rake, 101=Never Rake
--FeralSkills_Settings["Claw_RakeHighArmor"] = 1; --0=Target can be any class, 1=Target class must be Paladin or Warrior
--FeralSkills_Settings["Claw_CowerLevel"] = 0; --0=No Cower, 1=Cower when in a group and am target"s target, 2=Cower always
--FeralSkills_Settings["Claw_FaerieFireLevel"] = 1; --0=No FF, 1=FF when target not FF"d, 2=FF always
--FeralSkills_Settings["Claw_RipMinComboPoints"] = 3; --Min combo points to use Rip. 6=Never use Rip
--FeralSkills_Settings["Claw_RipHighArmor"] = 1; --0=Target can be any class, 1=Target class must be Paladin or Warrior
--FeralSkills_Settings["Claw_RipMinTargetHealth"] = 60; --Rip when target"s health is at least this %. 0=Always Rip, 101=Never Rip
--FeralSkills_Settings["Claw_FerociousBiteMinComboPoints"] = 4; --Min combo points to use Ferocious Bite. 6=Never use Ferocious Bite
--FeralSkills_Settings["Claw_FerociousBiteMinEnergy"] = 0; --Min energy to use Ferocious Bite. 0=Always use Ferocious Bite. 101=Never use Ferocious Bite
--FeralSkills_Settings["Claw_FerociousBiteMaxTargetHealth"] = 101; --Ferocious Bite when target"s health is at or below this %. 0=Never Ferocious Bite, 101=Always Ferocious Bite

--FeralSkills_Settings["Shred_TigersFuryLevel"] = 1; --0=No TF, 1=TF when you have extra energy, 2=TF always
--FeralSkills_Settings["Shred_PounceLevel"] = 2; --0=No Pounce, 1=Pounce when in a group, 2=Pounce always
--FeralSkills_Settings["Shred_PounceModifier"] = 1; --0=No Modifier, 1=Shift, 2=Control, 3=Alt, 4=Command
--FeralSkills_Settings["Shred_CowerLevel"] = 1; --0=No Cower, 1=Cower when in a group and am target"s target, 2=Cower always
--FeralSkills_Settings["Shred_FaerieFireLevel"] = 1; --0=No FF, 1=FF when target not FF"d, 2=FF always
--FeralSkills_Settings["Shred_RipMinComboPoints"] = 3; --Min combo points to use Rip. 6=Never use Rip
--FeralSkills_Settings["Shred_RipHighArmor"] = 1; --0=Target can be any class, 1=Target class must be Paladin or Warrior
--FeralSkills_Settings["Shred_RipMinTargetHealth"] = 60; --Rip when target"s health is at least this %. 0=Always Rip, 101=Never Rip
--FeralSkills_Settings["Shred_FerociousBiteMinComboPoints"] = 4; --Min combo points to use Ferocious Bite. 6=Never use Ferocious Bite
--FeralSkills_Settings["Shred_FerociousBiteMinEnergy"] = 0; --Min energy to use Ferocious Bite. 0=Always use Ferocious Bite. 101=Never use Ferocious Bite
--FeralSkills_Settings["Shred_FerociousBiteMaxTargetHealth"] = 101; --Ferocious Bite when target"s health is at or below this %. 0=Never Ferocious Bite, 101=Always Ferocious Bite

--FeralSkills_Settings["Shift_CatModifier"] = 0; -- -1=Off, 0=No Modifier, 1=Shift, 2=Control, 3=Alt, 4=Command
--FeralSkills_Settings["Shift_CatProwl"] = 0; -- 0=Off, 1=Prowl if already in Cat Form
--FeralSkills_Settings["Shift_BearModifier"] = 1; -- -1=Off, 0=No Modifier, 1=Shift, 2=Control, 3=Alt, 4=Command
--FeralSkills_Settings["Shift_BearEnrage"] = 1; -- 0=Off, 1=Enrage if already in Bear Form
--FeralSkills_Settings["Shift_TravelModifier"] = 2; -- -1=Off, 0=No Modifier, 1=Shift, 2=Control, 3=Alt, 4=Command
--FeralSkills_Settings["Shift_MountModifier"] = 3; -- -1=Off, 0=No Modifier, 1=Shift, 2=Control, 3=Alt, 4=Command
--FeralSkills_Settings["Shift_MountName"] = ""; -- The name of the mount item to use, must be on an action bar
--FeralSkills_Settings["Shift_MountSpell"] = ""; -- The name of the mount spell to use, must be on an action bar

FeralSkills_Modifiers = {"None","Shift","Control","Alt"};

FeralSkills_Strings = FeralSkills_Localization[GetLocale()];

function FeralSkills_OnLoad()
	SlashCmdList["FS"] = FeralSkills_SlashCommand;
	SLASH_FS1 = "/fs"
	SlashCmdList["FERALSKILLS"] = FeralSkills_SlashCommand;
	SLASH_FERALSKILLS1 = "/feralskills"
	FeralSkills_TurnOffReallyStupidDruidBarUseActionOverload();
	
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE");
end

function FeralSkills_OnEvent()
	if(event=="CHAT_MSG_SPELL_SELF_DAMAGE") then
		FeralSkills_WatchForImmunes(arg1);
	else --Must be VARIABLES_LOADED
		if(not FeralSkills_Settings or not FeralSkills_Settings.Maul or not FeralSkills_Settings.LastVersion == FeralSkills_CurrentVersion) then
			FeralSkills_SetDefaultSettings();
		end
		
		if ( Khaos ) then 
			FeralSkills_RegisterForKhaos();
		else
			--save enabled values if not using cosmos
			--RegisterForSave("FeralSkills_Settings");
		end
	end
end

FeralSkills_ImmunityProblemCreatures = {
	"Scarlet",
	"Crimson",
	"Phasing",
	"Doan",
	"Gurubashi",
	"Springvale",
	"Arugal"
}

function FeralSkills_WatchForImmunes(text)
	if FeralSkills_Settings.TrackImmunities then
		for spell, creature in string.gfind(text, "Your (.+) failed. (.+) is immune." ) do
			--Ignore non-targets (or at least, try, based on name), banished targets, or known problematic targets (targets that have temporary immunities)		
			if(UnitName('target') ~= creature or FeralSkills_UnitHasDebuff('target', 'Cripple')) then return; end;
			for _,problemCreature in FeralSkills_ImmunityProblemCreatures do if string.find(creature, problemCreature) then return end end
			
			fsprint("[FeralSkills]: IMMUNITY DETECTED! Spell: "..spell.."      Creature: "..creature);
			
			if not FeralSkills_Immunities[spell] then
				FeralSkills_Immunities[spell] = {};
			end
			FeralSkills_Immunities[spell][creature] = true;
		end
	end
end

function FeralSkills_RegisterForKhaos()
	local optionSet = {
		id="FeralSkills";
		text="FeralSkills";
		helptext="Combines most feral skills into 4 conveniant buttons";
		difficulty=1;
		default=false;
		options={
			{	id="HeaderMacros";
				text="FeralSkills Macros";
				helptext="Click Create Macros to create Character-Specific macros for FeralSkills";
				type=K_HEADER;
				difficulty=1;
			};
			{	id="CreateMacrosGlobal";
				type=K_BUTTON;
				text="Create Global Macros";
				helptext="Click Create Macros to create *-->Global<--* Maul+ / Claw+ / Shred+ / Shift+ macros for FeralSkills";
				callback=function()FeralSkills_CreateMacrosGlobal()end;
				setup={buttonText="Create Macros"};
			};
			{	id="CreateMacrosCharacterSpecific";
				type=K_BUTTON;
				text="Create Character-Specific Macros";
				helptext="Click Create Macros to create *-->Character-Specific<--* Maul+ / Claw+ / Shred+ / Shift+ macros for FeralSkills";
				callback=function()FeralSkills_CreateMacrosCharacterSpecific()end;
				setup={buttonText="Create Macros"};
			};
			{	id="CreateShiftMacrosGlobal";
				type=K_BUTTON;
				text="Create Global ShiftMacros";
				helptext="Click Create Macros to create *-->Global<--* individual shapeshifting macros for FeralSkills";
				callback=function()FeralSkills_CreateMacrosGlobal()end;
				setup={buttonText="Create Macros"};
			};
			{	id="CreateMacrosCharacterSpecific";
				type=K_BUTTON;
				text="Create Character-Specific Shift Macros";
				helptext="Click Create Macros to create *-->Character-Specific<--* individual shapeshifting macros for FeralSkills";
				callback=function()FeralSkills_CreateMacrosCharacterSpecific()end;
				setup={buttonText="Create Macros"};
			};
			{	id="DontAutoTarget";
				text="Don't auto target";
				helptext="If this is off and you Maul+, Claw+, or Shred+, it will automatically target the next nearest enemy if you have no target or your target is dead. Recommended to be ON.";
				type = K_TEXT;
				check = true;
				callback = function(state) FeralSkills_Settings.DontAutoTarget = state.checked; end;   
				feedback = function(state) end;
				default = {checked = true;};
				disabled = {checked = false;};
			};
			{	id="TrackImmunities";
				text="Track Immunities";
				helptext="When enabled, will watch for 'Immune' messages, and will not use that skill against that mob again. Recommended to be ON.";
				type = K_TEXT;
				check = true;
				callback = function(state) FeralSkills_Settings.TrackImmunities = state.checked; end;   
				feedback = function(state) end;
				default = {checked = true;};
				disabled = {checked = false;};
			};
			{	id="ResetImmunities";
				type=K_BUTTON;
				text="Reset Immunities";
				helptext="This will clear FeralSkills' list of immunities. Use this if an incorrect immunity is tracked.";
				callback=function() FeralSkills_Immunities = {}; end;
				setup={buttonText="Reset Immunities"};
			};
			
			{	id="HeaderMaul";
				text="Maul+";
				helptext="Skill for use in Bear or Dire Bear form.";
				type=K_HEADER;
				difficulty=1;
			};
			{	id="Maul.AutoShift";
				text="Automatically shift to Bear Form while Mauling";
				helptext="Automatically shift to Bear Form while Mauling";
				type = K_TEXT;
				check = true;
				callback = function(state) FeralSkills_Settings.Maul.AutoShift = state.checked; end;   
				feedback = function(state) end;
				default = {checked = true;};
				disabled = {checked = false;};
			};
			{	id="Maul.Growl.Enabled";
				text="Use Growl while Mauling";
				helptext="Use Growl while Mauling";
				type = K_TEXT;
				check = true;
				callback = function(state) FeralSkills_Settings.Maul.Growl.Enabled = state.checked; end;   
				feedback = function(state) end;
				default = {checked = true;};
				disabled = {checked = false;};
			};
			{	id="Maul.Growl.NotAggroed";
				text=" -Only Growl if I don't have aggro";
				helptext="Only Growl if I don't have aggro";
				type = K_TEXT;
				check = true;
				callback = function(state) FeralSkills_Settings.Maul.Growl.NotAggroed = state.checked; end;   
				feedback = function(state) end;
				default = {checked = true;};
				disabled = {checked = false;};
				dependencies = {["Maul.Growl.Enabled"] = {checked = true;};};
			};
			{	id="Maul.Growl.TargetTargetSquishy";
				text=" -Only Growl if target's target is squishy";
				helptext="Only Growl if target's current target is not high armor, or has less than 40% health";
				type = K_TEXT;
				check = true;
				callback = function(state) FeralSkills_Settings.Maul.Growl.TargetTargetSquishy = state.checked; end;   
				feedback = function(state) end;
				default = {checked = true;};
				disabled = {checked = false;};
				dependencies = {["Maul.Growl.Enabled"] = {checked = true;};};
			};
			{	id="Maul.FeralCharge.Enabled";
				text="Use Feral Charge while Mauling";
				helptext="Use Feral Charge while Mauling";
				type = K_TEXT;
				check = true;
				callback = function(state) FeralSkills_Settings.Maul.FeralCharge.Enabled = state.checked; end;   
				feedback = function(state) end;
				default = {checked = true;};
				disabled = {checked = false;};
			};
			{	id="Maul.Enrage.Enabled";
				text="Use Enrage while Mauling";
				helptext="Use Enrage while Mauling";
				type = K_TEXT;
				check = true;
				callback = function(state) FeralSkills_Settings.Maul.Enrage.Enabled = state.checked; end;   
				feedback = function(state) end;
				default = {checked = true;};
				disabled = {checked = false;};
			};
			{	id="Maul.Enrage.MaxRage";
				text=" -Enrage Max Rage";
				helptext="Only Enrage when I have less rage than this";
				type = K_SLIDER;
				check = true;
				callback = function(state) FeralSkills_Settings.Maul.Enrage.MaxRageEnabled = state.checked; FeralSkills_Settings.Maul.Enrage.MaxRage = state.slider; end;   
				feedback = function(state) end;
				default = {checked = true; slider=25};
				disabled = {checked = false;};
				dependencies = {["Maul.Enrage.Enabled"] = {checked = true;};};
				setup = {sliderMin=0; sliderMax=100; sliderStep=1;};
			};
			{	id="Maul.FaerieFire.Enabled";
				text="Use Faerie Fire while Mauling";
				helptext="Use Faerie Fire while Mauling";
				type = K_TEXT;
				check = true;
				callback = function(state) FeralSkills_Settings.Maul.FaerieFire.Enabled = state.checked; end;   
				feedback = function(state) end;
				default = {checked = true;};
				disabled = {checked = false;};
			};
			{	id="Maul.FaerieFire.NotDebuffed";
				text=" -Don't Faerie Fire multiple times";
				helptext="Only Faerie Fire when the target is not already Faerie Fired";
				type = K_TEXT;
				check = true;
				callback = function(state) FeralSkills_Settings.Maul.FaerieFire.NotDebuffed = state.checked; end;   
				feedback = function(state) end;
				default = {checked = true;};
				disabled = {checked = false;};
				dependencies = {["Maul.FaerieFire.Enabled"] = {checked = true;};};
			};
			{	id="Maul.DemoralizingRoar.Enabled";
				text="Use Demoralizing Roar while Mauling";
				helptext="Use Demoralizing Roar while Mauling";
				type = K_TEXT;
				check = true;
				callback = function(state) FeralSkills_Settings.Maul.DemoralizingRoar.Enabled = state.checked; end;   
				feedback = function(state) end;
				default = {checked = true;};
				disabled = {checked = false;};
			};
			{	id="Maul.DemoralizingRoar.MinRage";
				text=" -Demoralizing Roar Min Rage";
				helptext="Only Demoralizing Roar when I have more rage than this";
				type = K_SLIDER;
				check = true;
				callback = function(state) FeralSkills_Settings.Maul.DemoralizingRoar.MinRageEnabled = state.checked; FeralSkills_Settings.Maul.DemoralizingRoar.MinRage = state.slider; end;   
				feedback = function(state) end;
				default = {checked = true; slider=19};
				disabled = {checked = false;};
				dependencies = {["Maul.DemoralizingRoar.Enabled"] = {checked = true;};};
				setup = {sliderMin=0; sliderMax=100; sliderStep=1;};
			};
			{	id="Maul.DemoralizingRoar.NotDebuffed";
				text=" -Don't Demoralize multiple times";
				helptext="Only Demoralizing Roar when the target is not already Demoralized";
				type = K_TEXT;
				check = true;
				callback = function(state) FeralSkills_Settings.Maul.DemoralizingRoar.NotDebuffed = state.checked; end;   
				feedback = function(state) end;
				default = {checked = true;};
				disabled = {checked = false;};
				dependencies = {["Maul.DemoralizingRoar.Enabled"] = {checked = true;};};
			};
			{	id="Maul.Swipe.Enabled";
				text="Use Swipe while Mauling";
				helptext="Use Swipe while Mauling";
				type = K_TEXT;
				check = true;
				callback = function(state) FeralSkills_Settings.Maul.Swipe.Enabled = state.checked; end;   
				feedback = function(state) end;
				default = {checked = true;};
				disabled = {checked = false;};
			};
			{	id="Maul.Swipe.MinRage";
				text=" -Swipe Min Rage";
				helptext="Only Swipe when I have more rage than this";
				type = K_SLIDER;
				check = true;
				callback = function(state) FeralSkills_Settings.Maul.Swipe.MinRageEnabled = state.checked; FeralSkills_Settings.Maul.Swipe.MinRage = state.slider; end;
				feedback = function(state) end;
				default = {checked = true; slider=24};
				disabled = {checked = false;};
				dependencies = {["Maul.Swipe.Enabled"] = {checked = true;};};
				setup = {sliderMin=0; sliderMax=100; sliderStep=1;};
			};
			{	id="Maul.Swipe.GroupOnly";
				text=" -Only Swipe when in a group";
				helptext="Only Swipe when in a group";
				type = K_TEXT;
				check = true;
				callback = function(state) FeralSkills_Settings.Maul.Swipe.GroupOnly = state.checked; end;   
				feedback = function(state) end;
				default = {checked = false;};
				disabled = {checked = false;};
				dependencies = {["Maul.Swipe.Enabled"] = {checked = true;};};
			};
			
			{	id="HeaderClaw";
				text="Claw+";
				helptext="Skill for use in Cat form, frontal skills.";
				type=K_HEADER;
				difficulty=1;
			};
			{	id="Claw.AutoShift";
				text="Automatically shift to Cat Form while Clawing";
				helptext="Automatically shift to Cat Form while Clawing";
				type = K_TEXT;
				check = true;
				callback = function(state) FeralSkills_Settings.Claw.AutoShift = state.checked; end;   
				feedback = function(state) end;
				default = {checked = true;};
				disabled = {checked = false;};
			};
			{	id="Claw.TigersFury.Enabled";
				text="Use Tiger's Fury while Clawing";
				helptext="Use Tiger's Fury while Clawing";
				type = K_TEXT;
				check = true;
				callback = function(state) FeralSkills_Settings.Claw.TigersFury.Enabled = state.checked; end;   
				feedback = function(state) end;
				default = {checked = true;};
				disabled = {checked = false;};
			};
			{	id="Claw.TigersFury.Extra";
				text=" -Only Tiger's Fury if I have extra energy";
				helptext="Only Tiger's Fury if I have extra energy";
				type = K_TEXT;
				check = true;
				callback = function(state) FeralSkills_Settings.Claw.TigersFury.Extra = state.checked; end;   
				feedback = function(state) end;
				default = {checked = true;};
				disabled = {checked = false;};
				dependencies = {["Claw.TigersFury.Enabled"] = {checked = true;};};
			};
			{	id="Claw.Rake.Enabled";
				text="Use Rake while Clawing";
				helptext="Use Rake while Clawing";
				type = K_TEXT;
				check = true;
				callback = function(state) FeralSkills_Settings.Claw.Rake.Enabled = state.checked; end;   
				feedback = function(state) end;
				default = {checked = true;};
				disabled = {checked = false;};
			};
			{	id="Claw.Rake.HighArmor";
				text=" -Only Rake if target has high armor";
				helptext="Only Rake if target has high armor";
				type = K_TEXT;
				check = true;
				callback = function(state) FeralSkills_Settings.Claw.Rake.HighArmor = state.checked; end;   
				feedback = function(state) end;
				default = {checked = true;};
				disabled = {checked = false;};
				dependencies = {["Claw.Rake.Enabled"] = {checked = true;};};
			};
			{	id="Claw.Rake.MinHealth";
				text=" -Rake Target Min Health %";
				helptext="Only Rake when target has at least this much health (%)";
				type = K_SLIDER;
				check = true;
				callback = function(state) FeralSkills_Settings.Claw.Rake.MinHealthEnabled = state.checked; FeralSkills_Settings.Claw.Rake.MinHealth = state.slider; end;   
				feedback = function(state) end;
				default = {checked = true; slider=50};
				disabled = {checked = false;};
				dependencies = {["Claw.Rake.Enabled"] = {checked = true;};};
				setup = {sliderMin=0; sliderMax=100; sliderStep=1;};
			};
			{	id="Claw.Cower.Enabled";
				text="Use Cower while Clawing";
				helptext="Use Cower while Clawing";
				type = K_TEXT;
				check = true;
				callback = function(state) FeralSkills_Settings.Claw.Cower.Enabled = state.checked; end;   
				feedback = function(state) end;
				default = {checked = false;};
				disabled = {checked = false;};
			};
			{	id="Claw.Cower.Aggroed";
				text=" -Only Cower when aggroed and in group";
				helptext="Only Cower when aggroed and in group";
				type = K_TEXT;
				check = true;
				callback = function(state) FeralSkills_Settings.Claw.Cower.Aggroed = state.checked; end;   
				feedback = function(state) end;
				default = {checked = true;};
				disabled = {checked = false;};
				dependencies = {["Claw.Cower.Enabled"] = {checked = true;};};
			};
			{	id="Claw.FaerieFire.Enabled";
				text="Use Faerie Fire while Clawing";
				helptext="Use Faerie Fire while Clawing";
				type = K_TEXT;
				check = true;
				callback = function(state) FeralSkills_Settings.Claw.FaerieFire.Enabled = state.checked; end;   
				feedback = function(state) end;
				default = {checked = true;};
				disabled = {checked = false;};
			};
			{	id="Claw.FaerieFire.NotDebuffed";
				text=" -Don't Faerie Fire multiple times";
				helptext="Only Faerie Fire when the target is not already Faerie Fired";
				type = K_TEXT;
				check = true;
				callback = function(state) FeralSkills_Settings.Claw.FaerieFire.NotDebuffed = state.checked; end;   
				feedback = function(state) end;
				default = {checked = true;};
				disabled = {checked = false;};
				dependencies = {["Claw.FaerieFire.Enabled"] = {checked = true;};};
			};
			{	id="Claw.Rip.Enabled";
				text="Use Rip while Clawing at";
				helptext="Use Rip while Clawing when having at least this many combo points";
				type = K_SLIDER;
				check = true;
				callback = function(state) FeralSkills_Settings.Claw.Rip.Enabled = state.checked; FeralSkills_Settings.Claw.Rip.ComboPoints = state.slider; end;   
				feedback = function(state) end;
				default = {checked = true; slider=3};
				disabled = {checked = false;};
				setup = {sliderMin=1; sliderMax=5; sliderStep=1; sliderLow="1"; sliderHigh="5"; sliderText="Combo Points"};
			};
			{	id="Claw.Rip.HighArmor";
				text=" -Only Rip if target has high armor";
				helptext="Only Rip if target has high armor";
				type = K_TEXT;
				check = true;
				callback = function(state) FeralSkills_Settings.Claw.Rip.HighArmor = state.checked; end;   
				feedback = function(state) end;
				default = {checked = true;};
				disabled = {checked = false;};
				dependencies = {["Claw.Rip.Enabled"] = {checked = true;};};
			};
			{	id="Claw.Rip.MinHealth";
				text=" -Rip Target Min Health %";
				helptext="Only Rip when target has at least this much health (%)";
				type = K_SLIDER;
				check = true;
				callback = function(state) FeralSkills_Settings.Claw.Rip.MinHealthEnabled = state.checked; FeralSkills_Settings.Claw.Rip.MinHealth = state.slider; end;   
				feedback = function(state) end;
				default = {checked = true; slider=60};
				disabled = {checked = false;};
				dependencies = {["Claw.Rip.Enabled"] = {checked = true;};};
				setup = {sliderMin=0; sliderMax=100; sliderStep=1;};
			};
			{	id="Claw.FerociousBite.Enabled";
				text="Use Ferocious Bite while Clawing at";
				helptext="Use Ferocious Bite while Clawing when having at least this many combo points";
				type = K_SLIDER;
				check = true;
				callback = function(state) FeralSkills_Settings.Claw.FerociousBite.Enabled = state.checked; FeralSkills_Settings.Claw.FerociousBite.ComboPoints = state.slider; end;   
				feedback = function(state) end;
				default = {checked = true; slider=4};
				disabled = {checked = false;};
				setup = {sliderMin=1; sliderMax=5; sliderStep=1; sliderLow="1"; sliderHigh="5"; sliderText="Combo Points"};
			};
			{	id="Claw.FerociousBite.MinEnergy";
				text=" -Ferocious Bite Min Energy";
				helptext="Only Ferocious Bite when I have at least this much energy";
				type = K_SLIDER;
				check = true;
				callback = function(state) FeralSkills_Settings.Claw.FerociousBite.MinEnergyEnabled = state.checked; FeralSkills_Settings.Claw.FerociousBite.MinEnergy = state.slider; end;   
				feedback = function(state) end;
				default = {checked = false; slider=70};
				disabled = {checked = false;};
				dependencies = {["Claw.FerociousBite.Enabled"] = {checked = true;};};
				setup = {sliderMin=0; sliderMax=100; sliderStep=1;};
			};
			{	id="Claw.FerociousBite.MaxHealth";
				text=" -Ferocious Bite Max Health %";
				helptext="Only Ferocious Bite when target has less than this muc health (%)";
				type = K_SLIDER;
				check = true;
				callback = function(state) FeralSkills_Settings.Claw.FerociousBite.MaxHealthEnabled = state.checked; FeralSkills_Settings.Claw.FerociousBite.MaxHealth = state.slider; end;   
				feedback = function(state) end;
				default = {checked = false; slider=30};
				disabled = {checked = false;};
				dependencies = {["Claw.FerociousBite.Enabled"] = {checked = true;};};
				setup = {sliderMin=0; sliderMax=100; sliderStep=1;};
			};
			{	id="Claw.FerociousBite.Killshot";
				text=" -Immediately FB if it will Kill";
				helptext="Immediately Ferocious Bite if it will Kill";
				type = K_TEXT;
				check = true;
				callback = function(state) FeralSkills_Settings.Claw.FerociousBite.Killshot = state.checked; end;   
				feedback = function(state) end;
				default = {checked = true;};
				disabled = {checked = false;};
				dependencies = {["Claw.FerociousBite.Enabled"] = {checked = true;};};
			};
			
			{	id="HeaderShred";
				text="Shred+";
				helptext="Skill for use in Cat form, rear skills.";
				type=K_HEADER;
				difficulty=1;
			};
			{	id="Shred.AutoShift";
				text="Automatically shift to Cat Form while Shreding";
				helptext="Automatically shift to Cat Form while Shreding";
				type = K_TEXT;
				check = true;
				callback = function(state) FeralSkills_Settings.Shred.AutoShift = state.checked; end;   
				feedback = function(state) end;
				default = {checked = true;};
				disabled = {checked = false;};
			};
			{	id="Shred.TigersFury.Enabled";
				text="Use Tiger's Fury while Shreding";
				helptext="Use Tiger's Fury while Shreding";
				type = K_TEXT;
				check = true;
				callback = function(state) FeralSkills_Settings.Shred.TigersFury.Enabled = state.checked; end;   
				feedback = function(state) end;
				default = {checked = true;};
				disabled = {checked = false;};
			};
			{	id="Shred.TigersFury.Extra";
				text=" -Only Tiger's Fury if I have extra energy";
				helptext="Only Tiger's Fury if I have extra energy";
				type = K_TEXT;
				check = true;
				callback = function(state) FeralSkills_Settings.Shred.TigersFury.Extra = state.checked; end;   
				feedback = function(state) end;
				default = {checked = true;};
				disabled = {checked = false;};
				dependencies = {["Shred.TigersFury.Enabled"] = {checked = true;};};
			};
			{	id="Shred.Pounce.Enabled";
				text="Use Pounce instead of Ravage";
				helptext="Use Pounce instead of Ravage while Shreding";
				type = K_TEXT;
				check = true;
				callback = function(state) FeralSkills_Settings.Shred.Pounce.Enabled = state.checked; end;   
				feedback = function(state) end;
				default = {checked = true;};
				disabled = {checked = false;};
			};
			{	id="Shred.Pounce.GroupOnly";
				text=" -Only Pounce if in a group";
				helptext="Only Pounce if in a group";
				type = K_TEXT;
				check = true;
				callback = function(state) FeralSkills_Settings.Shred.Pounce.GroupOnly = state.checked; end;   
				feedback = function(state) end;
				default = {checked = true;};
				disabled = {checked = false;};
				dependencies = {["Shred.Pounce.Enabled"] = {checked = true;};};
			};
			{	id="Shred.Pounce.Modifier";
				text=" -Pounce Modifier Key";
				helptext="Only Pounce instead of Ravage when this modifier is held down";
				type = K_PULLDOWN;
				check = true;
				callback = function(state) FeralSkills_Settings.Shred.Pounce.ModifierEnabled = state.checked; FeralSkills_Settings.Shred.Pounce.Modifier = state.value; end;   
				feedback = function(state) end;
				default = {checked = true; value=2};
				disabled = {checked = false;};
				dependencies = {["Shred.Rake.Enabled"] = {checked = true;};};
				setup = {options={["Alt"]=4;["Control"]=3;["Shift"]=2;}; multiSelect=false;};
			};
			{	id="Shred.Cower.Enabled";
				text="Use Cower while Shreding";
				helptext="Use Cower while Shreding";
				type = K_TEXT;
				check = true;
				callback = function(state) FeralSkills_Settings.Shred.Cower.Enabled = state.checked; end;   
				feedback = function(state) end;
				default = {checked = false;};
				disabled = {checked = false;};
			};
			{	id="Shred.Cower.Aggroed";
				text=" -Only Cower when aggroed and in group";
				helptext="Only Cower when aggroed and in group";
				type = K_TEXT;
				check = true;
				callback = function(state) FeralSkills_Settings.Shred.Cower.Aggroed = state.checked; end;   
				feedback = function(state) end;
				default = {checked = true;};
				disabled = {checked = false;};
				dependencies = {["Shred.Cower.Enabled"] = {checked = true;};};
			};
			{	id="Shred.FaerieFire.Enabled";
				text="Use Faerie Fire while Shreding";
				helptext="Use Faerie Fire while Shreding";
				type = K_TEXT;
				check = true;
				callback = function(state) FeralSkills_Settings.Shred.FaerieFire.Enabled = state.checked; end;   
				feedback = function(state) end;
				default = {checked = true;};
				disabled = {checked = false;};
			};
			{	id="Shred.FaerieFire.NotDebuffed";
				text=" -Don't Faerie Fire multiple times";
				helptext="Only Faerie Fire when the target is not already Faerie Fired";
				type = K_TEXT;
				check = true;
				callback = function(state) FeralSkills_Settings.Shred.FaerieFire.NotDebuffed = state.checked; end;   
				feedback = function(state) end;
				default = {checked = true;};
				disabled = {checked = false;};
				dependencies = {["Shred.FaerieFire.Enabled"] = {checked = true;};};
			};
			{	id="Shred.Rip.Enabled";
				text="Use Rip while Shreding at";
				helptext="Use Rip while Shreding when having at least this many combo points";
				type = K_SLIDER;
				check = true;
				callback = function(state) FeralSkills_Settings.Shred.Rip.Enabled = state.checked; FeralSkills_Settings.Shred.Rip.ComboPoints = state.slider; end;   
				feedback = function(state) end;
				default = {checked = true; slider=3};
				disabled = {checked = false;};
				setup = {sliderMin=1; sliderMax=5; sliderStep=1; sliderLow="1"; sliderHigh="5"; sliderText="Combo Points"};
			};
			{	id="Shred.Rip.HighArmor";
				text=" -Only Rip if target has high armor";
				helptext="Only Rip if target has high armor";
				type = K_TEXT;
				check = true;
				callback = function(state) FeralSkills_Settings.Shred.Rip.HighArmor = state.checked; end;   
				feedback = function(state) end;
				default = {checked = true;};
				disabled = {checked = false;};
				dependencies = {["Shred.Rip.Enabled"] = {checked = true;};};
			};
			{	id="Shred.Rip.MinHealth";
				text=" -Rip Target Min Health %";
				helptext="Only Rip when target has at least this much health (%)";
				type = K_SLIDER;
				check = true;
				callback = function(state) FeralSkills_Settings.Shred.Rip.MinHealthEnabled = state.checked; FeralSkills_Settings.Shred.Rip.MinHealth = state.slider; end;   
				feedback = function(state) end;
				default = {checked = true; slider=60};
				disabled = {checked = false;};
				dependencies = {["Shred.Rip.Enabled"] = {checked = true;};};
				setup = {sliderMin=0; sliderMax=100; sliderStep=1;};
			};
			{	id="Shred.FerociousBite.Enabled";
				text="Use Ferocious Bite while Shreding at";
				helptext="Use Ferocious Bite while Shreding when having at least this many combo points";
				type = K_SLIDER;
				check = true;
				callback = function(state) FeralSkills_Settings.Shred.FerociousBite.Enabled = state.checked; FeralSkills_Settings.Shred.FerociousBite.ComboPoints = state.slider; end;   
				feedback = function(state) end;
				default = {checked = true; slider=4};
				disabled = {checked = false;};
				setup = {sliderMin=1; sliderMax=5; sliderStep=1; sliderLow="1"; sliderHigh="5"; sliderText="Combo Points"};
			};
			{	id="Shred.FerociousBite.MinEnergy";
				text=" -Ferocious Bite Min Energy";
				helptext="Only Ferocious Bite when I have at least this much energy";
				type = K_SLIDER;
				check = true;
				callback = function(state) FeralSkills_Settings.Shred.FerociousBite.MinEnergyEnabled = state.checked; FeralSkills_Settings.Shred.FerociousBite.MinEnergy = state.slider; end;   
				feedback = function(state) end;
				default = {checked = false; slider=70};
				disabled = {checked = false;};
				dependencies = {["Shred.FerociousBite.Enabled"] = {checked = true;};};
				setup = {sliderMin=0; sliderMax=100; sliderStep=1;};
			};
			{	id="Shred.FerociousBite.MaxHealth";
				text=" -Ferocious Bite Max Health %";
				helptext="Only Ferocious Bite when target has less than this muc health (%)";
				type = K_SLIDER;
				check = true;
				callback = function(state) FeralSkills_Settings.Shred.FerociousBite.MaxHealthEnabled = state.checked; FeralSkills_Settings.Shred.FerociousBite.MaxHealth = state.slider; end;   
				feedback = function(state) end;
				default = {checked = false; slider=30};
				disabled = {checked = false;};
				dependencies = {["Shred.FerociousBite.Enabled"] = {checked = true;};};
				setup = {sliderMin=0; sliderMax=100; sliderStep=1;};
			};
			{	id="Shred.FerociousBite.Killshot";
				text=" -Immediately FB if it will Kill";
				helptext="Immediately Ferocious Bite if it will Kill";
				type = K_TEXT;
				check = true;
				callback = function(state) FeralSkills_Settings.Shred.FerociousBite.Killshot = state.checked; end;   
				feedback = function(state) end;
				default = {checked = true;};
				disabled = {checked = false;};
				dependencies = {["Shred.FerociousBite.Enabled"] = {checked = true;};};
			};
						
			{	id="HeaderShift";
				text="Shift+";
				helptext="Skill for shifting to the various forms, and mounting. Which form you shift to is based on what modifier keys you hold down and the modifiers selected for each form below.";
				type=K_HEADER;
				difficulty=1;
			};
			{	id="Shift.Bear.Enabled";
				text="[Dire] Bear Form";
				helptext="Shift to [Dire] Bear Form when you press Shift+, while holding the selected modifier key";
				type = K_PULLDOWN;
				check = true;
				callback = function(state) FeralSkills_Settings.Shift.Bear.Enabled = state.checked; FeralSkills_Settings.Shift.Bear.Modifier = state.value; end;   
				feedback = function(state) end;
				default = {checked = true; value=2};
				disabled = {checked = false;};
				setup = {options={["Alt"]=4;["Control"]=3;["Shift"]=2;["None"]=1}; multiSelect=false;};
			};
			{	id="Shift.Bear.Self";
				text=" -Or, if already in Bear Form...";
				helptext="If you attempt to shift to [Dire] Bear Form while already in [Dire] Bear Form, the selected action will be taken. (Do nothing, Enrage, or Shift to Caster)";
				type = K_PULLDOWN;
				check = false;
				callback = function(state) FeralSkills_Settings.Shift.Bear.Enrage = (state.value==2); FeralSkills_Settings.Shift.Bear.Caster= (state.value==3); end;   
				feedback = function(state) end;
				default = {checked = true; value=3};
				disabled = {checked = false;};
				setup = {options={["Do Nothing"]=1;["Enrage"]=2;["Shift to Caster"]=3}; multiSelect=false;};
				dependencies = {["Shift.Bear.Enabled"] = {checked = true;};};
			};
			--{	id="Shift.Bear.Enrage";
			--	text=" -Enrage if already in [Dire] Bear Form";
			--	helptext="If on, and alread in [Dire] Bear Form, Enrage will be used. If off, you will shift out to caster.";
			--	type = K_TEXT;
			--	check = true;
			--	callback = function(state) FeralSkills_Settings.Shift.Bear.Enrage = state.checked; end;   
			--	feedback = function(state) end;
			--	default = {checked = false;};
			--	disabled = {checked = false;};
			--	dependencies = {["Shift.Bear.Enabled"] = {checked = true;};};
			--};
			{	id="Shift.Cat.Enabled";
				text="Cat Form";
				helptext="Shift to Cat Form when you press Shift+, while holding the selected modifier key";
				type = K_PULLDOWN;
				check = true;
				callback = function(state) FeralSkills_Settings.Shift.Cat.Enabled = state.checked; FeralSkills_Settings.Shift.Cat.Modifier = state.value; end;   
				feedback = function(state) end;
				default = {checked = true; value=1};
				disabled = {checked = false;};
				setup = {options={["Alt"]=4;["Control"]=3;["Shift"]=2;["None"]=1}; multiSelect=false;};
			};
			{	id="Shift.Cat.Self";
				text=" -Or, if already in Cat Form...";
				helptext="If you attempt to shift to Cat Form while already in Cat Form, the selected action will be taken. (Do nothing, Prowl, or Shift to Caster)";
				type = K_PULLDOWN;
				check = false;
				callback = function(state) FeralSkills_Settings.Shift.Cat.Prowl = (state.value==2); FeralSkills_Settings.Shift.Cat.Caster= (state.value==3); end;   
				feedback = function(state) end;
				default = {checked = true; value=3};
				disabled = {checked = false;};
				setup = {options={["Do Nothing"]=1;["Prowl"]=2;["Shift to Caster"]=3}; multiSelect=false;};
				dependencies = {["Shift.Cat.Enabled"] = {checked = true;};};
			};
			--{	id="Shift.Cat.Prowl";
			--	text=" -Prowl if already in Cat Form";
			--	helptext="If on, and alread in Cat Form, Prowl will be used. If off, you will shift out to caster.";
			--	type = K_TEXT;
			--	check = true;
			--	callback = function(state) FeralSkills_Settings.Shift.Cat.Prowl = state.checked; end;   
			--	feedback = function(state) end;
			--	default = {checked = false;};
			--	disabled = {checked = false;};
			--	dependencies = {["Shift.Cat.Enabled"] = {checked = true;};};
			--};
			{	id="Shift.Travel.Enabled";
				text="Travel/Aquatic Form";
				helptext="Shift to Travel/Aquatic Form when you press Shift+, while holding the selected modifier key. Will choose which based on if you are in water";
				type = K_PULLDOWN;
				check = true;
				callback = function(state) FeralSkills_Settings.Shift.Travel.Enabled = state.checked; FeralSkills_Settings.Shift.Travel.Modifier = state.value; end;   
				feedback = function(state) end;
				default = {checked = true; value=3};
				disabled = {checked = false;};
				setup = {options={["Alt"]=4;["Control"]=3;["Shift"]=2;["None"]=1}; multiSelect=false;};
			};
			{	id="Shift.Travel.Self";
				text=" -Or, if already in Travel/Aquatic Form...";
				helptext="If you attempt to shift to Travel/Aquatic Form while already in Travel/Aquatic Form, the selected action will be taken. (Do nothing, or Shift to Caster)";
				type = K_PULLDOWN;
				check = false;
				callback = function(state) FeralSkills_Settings.Shift.Travel.Caster= (state.value==2); end;   
				feedback = function(state) end;
				default = {checked = true; value=2};
				disabled = {checked = false;};
				setup = {options={["Do Nothing"]=1;["Shift to Caster"]=2}; multiSelect=false;};
				dependencies = {["Shift.Travel.Enabled"] = {checked = true;};};
			};
			{	id="Shift.Mount.Enabled";
				text="Mount";
				helptext="Mount when you press Shift+, while holding the selected modifier key. Shift+ while mounted will dismount";
				type = K_PULLDOWN;
				check = true;
				callback = function(state) FeralSkills_Settings.Shift.Mount.Enabled = state.checked; FeralSkills_Settings.Shift.Mount.Modifier = state.value; end;   
				feedback = function(state) end;
				default = {checked = true; value=4};
				disabled = {checked = false;};
				setup = {options={["Alt"]=4;["Control"]=3;["Shift"]=2;["None"]=1}; multiSelect=false;};
			};
			{	id="Shift.Mount.Self";
				text=" -Or, if already Mounted...";
				helptext="If you attempt to Mount while already Mounted, the selected action will be taken. (Do nothing, or Dismount)";
				type = K_PULLDOWN;
				check = false;
				callback = function(state) FeralSkills_Settings.Shift.Travel.Caster= (state.value==2); end;   
				feedback = function(state) end;
				default = {checked = true; value=2};
				disabled = {checked = false;};
				setup = {options={["Do Nothing"]=1;["Dismount"]=2}; multiSelect=false;};
				dependencies = {["Shift.Mount.Enabled"] = {checked = true;};};
			};
			{	id="Shift.Mount.Name";
				text=" -Mount Name";
				helptext="Type the *EXACT* name of the mount item that should be used to mount. *Hit [ENTER] while your cursor is in the textbox to save the name!*";
				type = K_EDITBOX;
				check = false;
				callback = function(state) FeralSkills_Settings.Shift.Mount.Name = state.value; end;   
				feedback = function(state) end;
				default = {value = "Reins of the Swift Frostsaber";};
				disabled = {value = "Disabled";};
				dependencies = {["Shift.Mount.Enabled"] = {checked = true;};};
				setup = { callOn={"enter";"escape";"tab";"space";};};
			};
			{	id="Shift.Mount.Spell";
				text=" -Mounting Spell";
				helptext="Type the *EXACT* name of an instant spell that you'd like to cast while mounting. Shift+ will cast this spell at the same time as you start mounting. *Hit [ENTER] while your cursor is in the textbox to save the name!*";
				type = K_EDITBOX;
				check = true;
				callback = function(state) FeralSkills_Settings.Shift.Mount.SpellEnabled = state.checked; FeralSkills_Settings.Shift.Mount.Spell = state.value; end;   
				feedback = function(state) end;
				default = {checked = true; value = "Nature's Grasp";};
				disabled = {checked = false; value = "Disabled";};
				dependencies = {["Shift.Mount.Enabled"] = {checked = true;};};
				setup = { callOn={"enter";"escape";"tab";"space";};};
			};
		};
	};
	
	Khaos.registerOptionSet("combat", optionSet);
end

function FeralSkills_SlashCommand()
	FeralSkills:Show();
end

function FeralSkills_PopulateSettingsDialog()
	FeralSkills_TurnOffReallyStupidDruidBarUseActionOverload();
	
	--GlobalPage
	CheckButtonGlobalDontAutoTarget:SetChecked(FeralSkills_Settings.DontAutoTarget);
	CheckButtonGlobalTrackImmunities:SetChecked(FeralSkills_Settings.TrackImmunities);
	
	local Maul = FeralSkills_Settings.Maul;
	--Maul Page
	CheckButtonMaulAutoShift:SetChecked(Maul.AutoShift);
	CheckButtonMaulGrowl1:SetChecked(Maul.Growl.Enabled);
	CheckButtonMaulGrowl2:SetChecked(Maul.Growl.NotAggroed);
	CheckButtonMaulGrowl3:SetChecked(Maul.Growl.TargetTargetSquishy);
	CheckButtonMaulFeralCharge:SetChecked(Maul.FeralCharge.Enabled);
	CheckButtonMaulEnrage1:SetChecked(Maul.Enrage.Enabled);
	CheckButtonMaulEnrage2:SetChecked(Maul.Enrage.MaxRageEnabled);
	EditBoxMaulEnrage:SetText(Maul.Enrage.MaxRage or "25");
	CheckButtonMaulDemoralizingRoar1:SetChecked(Maul.DemoralizingRoar.Enabled);
	CheckButtonMaulDemoralizingRoar2:SetChecked(Maul.DemoralizingRoar.MinRageEnabled);
	CheckButtonMaulDemoralizingRoar3:SetChecked(Maul.DemoralizingRoar.NotDebuffed);
	EditBoxMaulDemoralizingRoar:SetText(Maul.DemoralizingRoar.MinRage or "19");
	CheckButtonMaulFaerieFire1:SetChecked(Maul.FaerieFire.Enabled);
	CheckButtonMaulFaerieFire2:SetChecked(Maul.FaerieFire.NotDebuffed);
	CheckButtonMaulSwipe1:SetChecked(Maul.Swipe.Enabled);
	CheckButtonMaulSwipe2:SetChecked(Maul.Swipe.MinRageEnabled);
	CheckButtonMaulSwipe3:SetChecked(Maul.Swipe.GroupOnly);
	EditBoxMaulSwipe:SetText(Maul.Swipe.MinRage or "24");
	
	
	local Claw = FeralSkills_Settings.Claw;
	--Claw Page
	CheckButtonClawAutoShift:SetChecked(Claw.AutoShift);
	CheckButtonClawTigersFury1:SetChecked(Claw.TigersFury.Enabled);
	CheckButtonClawTigersFury2:SetChecked(Claw.TigersFury.Extra);
	CheckButtonClawRake1:SetChecked(Claw.Rake.Enabled);
	CheckButtonClawRake2:SetChecked(Claw.Rake.HighArmor);
	CheckButtonClawRake3:SetChecked(Claw.Rake.MinHealthEnabled);
	EditBoxClawRake:SetText(Claw.Rake.MinHealth or "50");
	CheckButtonClawCower1:SetChecked(Claw.Cower.Enabled);
	CheckButtonClawCower2:SetChecked(Claw.Cower.Aggroed);
	CheckButtonClawFaerieFire1:SetChecked(Claw.FaerieFire.Enabled);
	CheckButtonClawFaerieFire2:SetChecked(Claw.FaerieFire.NotDebuffed);
	CheckButtonClawRip1:SetChecked(Claw.Rip.Enabled);
	EditBoxClawRip1:SetText(Claw.Rip.ComboPoints or "3");
	CheckButtonClawRip2:SetChecked(Claw.Rip.HighArmor);
	CheckButtonClawRip3:SetChecked(Claw.Rip.MinHealthEnabled);
	EditBoxClawRip2:SetText(Claw.Rip.MinHealth or "60");
	CheckButtonClawFerociousBite1:SetChecked(Claw.FerociousBite.Enabled);
	EditBoxClawFerociousBite1:SetText(Claw.FerociousBite.ComboPoints or "4");
	CheckButtonClawFerociousBite2:SetChecked(Claw.FerociousBite.MinEnergyEnabled);
	EditBoxClawFerociousBite2:SetText(Claw.FerociousBite.MinEnergy or "70");
	CheckButtonClawFerociousBite3:SetChecked(Claw.FerociousBite.MaxHealthEnabled);
	EditBoxClawFerociousBite3:SetText(Claw.FerociousBite.MaxHealth or "30");
	CheckButtonClawFerociousBite4:SetChecked(Claw.FerociousBite.Killshot);
	
	local Shred = FeralSkills_Settings.Shred;
	--Shred Page
	CheckButtonShredAutoShift:SetChecked(Shred.AutoShift);
	CheckButtonShredTigersFury1:SetChecked(Shred.TigersFury.Enabled);
	CheckButtonShredTigersFury2:SetChecked(Shred.TigersFury.Extra);
	CheckButtonShredPounce1:SetChecked(Shred.Pounce.Enabled);
	CheckButtonShredPounce2:SetChecked(Shred.Pounce.ModifierEnabled);
	UIDropDownMenu_Initialize(DropDownFrameShredPounce, DropDownFrameShredPounce_Initialize); 
	UIDropDownMenu_SetSelectedID(DropDownFrameShredPounce, Shred.Pounce.Modifier); 
	CheckButtonShredPounce3:SetChecked(Shred.Pounce.GroupOnly);
	CheckButtonShredCower1:SetChecked(Shred.Cower.Enabled);
	CheckButtonShredCower2:SetChecked(Shred.Cower.Aggroed);
	CheckButtonShredFaerieFire1:SetChecked(Shred.FaerieFire.Enabled);
	CheckButtonShredFaerieFire2:SetChecked(Shred.FaerieFire.NotDebuffed);
	CheckButtonShredRip1:SetChecked(Shred.Rip.Enabled);
	EditBoxShredRip1:SetText(Shred.Rip.ComboPoints or "3");
	CheckButtonShredRip2:SetChecked(Shred.Rip.HighArmor);
	CheckButtonShredRip3:SetChecked(Shred.Rip.MinHealthEnabled);
	EditBoxShredRip2:SetText(Shred.Rip.MinHealth or "60");
	CheckButtonShredFerociousBite1:SetChecked(Shred.FerociousBite.Enabled);
	EditBoxShredFerociousBite1:SetText(Shred.FerociousBite.ComboPoints or "4");
	CheckButtonShredFerociousBite2:SetChecked(Shred.FerociousBite.MinEnergyEnabled);
	EditBoxShredFerociousBite2:SetText(Shred.FerociousBite.MinEnergy or "70");
	CheckButtonShredFerociousBite3:SetChecked(Shred.FerociousBite.MaxHealthEnabled);
	EditBoxShredFerociousBite3:SetText(Shred.FerociousBite.MaxHealth or "30");
	CheckButtonShredFerociousBite4:SetChecked(Shred.FerociousBite.Killshot);
	
	local Shift = FeralSkills_Settings.Shift;
	--Shift Page
	CheckButtonShiftBear1:SetChecked(Shift.Bear.Enabled);
	UIDropDownMenu_Initialize(DropDownFrameShiftBear, DropDownFrameShiftBear_Initialize); 
	UIDropDownMenu_SetSelectedID(DropDownFrameShiftBear, Shift.Bear.Modifier); 
	CheckButtonShiftBearSelfNothing:SetChecked(not Shift.Bear.Enrage and not Shift.Bear.Caster);
	CheckButtonShiftBearSelfEnrage:SetChecked(Shift.Bear.Enrage);
	CheckButtonShiftBearSelfCaster:SetChecked(Shift.Bear.Caster);
	CheckButtonShiftCat1:SetChecked(Shift.Cat.Enabled);
	UIDropDownMenu_Initialize(DropDownFrameShiftCat, DropDownFrameShiftCat_Initialize); 
	UIDropDownMenu_SetSelectedID(DropDownFrameShiftCat, Shift.Cat.Modifier); 
	CheckButtonShiftCatSelfNothing:SetChecked(not Shift.Cat.Prowl and not Shift.Cat.Caster);
	CheckButtonShiftCatSelfProwl:SetChecked(Shift.Cat.Prowl);
	CheckButtonShiftCatSelfCaster:SetChecked(Shift.Cat.Caster);
	CheckButtonShiftTravel1:SetChecked(Shift.Travel.Enabled);
	UIDropDownMenu_Initialize(DropDownFrameShiftTravel, DropDownFrameShiftTravel_Initialize); 
	UIDropDownMenu_SetSelectedID(DropDownFrameShiftTravel, Shift.Travel.Modifier); 
	CheckButtonShiftTravelSelfNothing:SetChecked(not Shift.Travel.Caster);
	CheckButtonShiftTravelSelfCaster:SetChecked(Shift.Travel.Caster);
	CheckButtonShiftMount1:SetChecked(Shift.Mount.Enabled);
	UIDropDownMenu_Initialize(DropDownFrameShiftMount, DropDownFrameShiftMount_Initialize); 
	UIDropDownMenu_SetSelectedID(DropDownFrameShiftMount, Shift.Mount.Modifier); 
	CheckButtonShiftMountSelfNothing:SetChecked(not Shift.Mount.Caster);
	CheckButtonShiftMountSelfCaster:SetChecked(Shift.Mount.Caster);
	EditBoxShiftMountName:SetText(Shift.Mount.Name);
	CheckButtonShiftMount2:SetChecked(Shift.Mount.SpellEnabled);
	EditBoxShiftMountSpell:SetText(Shift.Mount.Spell);
end

function FeralSkills_SaveToKhaos(key, type, value)
	if(Khaos and Khaos.setSetKeyParameter) then
		if(type == "checked" and value) then
			Khaos.setSetKeyParameter("FeralSkills", key, type, true);
		else
			Khaos.setSetKeyParameter("FeralSkills", key, type, value);
		end	
	end
end

function FeralSkills_SaveSettingsFromDialog()
	--Global Page
	FeralSkills_Settings.DontAutoTarget = CheckButtonGlobalDontAutoTarget:GetChecked();
	FeralSkills_Settings.TrackImmunities = CheckButtonGlobalTrackImmunities:GetChecked();
	FeralSkills_SaveToKhaos("DontAutoTarget", "checked", FeralSkills_Settings.DontAutoTarget);
	FeralSkills_SaveToKhaos("ImmunityTracking", "checked", FeralSkills_Settings.TrackImmunities);
	
	local Maul = FeralSkills_Settings.Maul;
	--Maul Page
	Maul.AutoShift = CheckButtonMaulAutoShift:GetChecked();
	Maul.Growl.Enabled = CheckButtonMaulGrowl1:GetChecked();
	Maul.Growl.NotAggroed = CheckButtonMaulGrowl2:GetChecked();
	Maul.Growl.TargetTargetSquishy = CheckButtonMaulGrowl3:GetChecked();
	Maul.FeralCharge.Enabled = CheckButtonMaulFeralCharge:GetChecked();
	Maul.Enrage.Enabled = CheckButtonMaulEnrage1:GetChecked();
	Maul.Enrage.MaxRageEnabled = CheckButtonMaulEnrage2:GetChecked();
	Maul.Enrage.MaxRage = tonumber(EditBoxMaulEnrage:GetText());
	Maul.DemoralizingRoar.Enabled = CheckButtonMaulDemoralizingRoar1:GetChecked();
	Maul.DemoralizingRoar.MinRageEnabled = CheckButtonMaulDemoralizingRoar2:GetChecked();
	Maul.DemoralizingRoar.NotDebuffed = CheckButtonMaulDemoralizingRoar3:GetChecked();
	Maul.DemoralizingRoar.MinRage = tonumber(EditBoxMaulDemoralizingRoar:GetText());
	Maul.FaerieFire.Enabled = CheckButtonMaulFaerieFire1:GetChecked();
	Maul.FaerieFire.NotDebuffed = CheckButtonMaulFaerieFire2:GetChecked();
	Maul.Swipe.Enabled = CheckButtonMaulSwipe1:GetChecked();
	Maul.Swipe.MinRageEnabled = CheckButtonMaulSwipe2:GetChecked();
	Maul.Swipe.GroupOnly = CheckButtonMaulSwipe3:GetChecked();
	Maul.Swipe.MinRage = tonumber(EditBoxMaulSwipe:GetText());
	FeralSkills_SaveToKhaos("Maul.AutoShift", "checked", Maul.AutoShift);
	FeralSkills_SaveToKhaos("Maul.Growl.Enabled", "checked", Maul.Growl.Enabled);
	FeralSkills_SaveToKhaos("Maul.Growl.NotAggroed", "checked", Maul.Growl.NotAggroed);
	FeralSkills_SaveToKhaos("Maul.Growl.TargetTargetSquishy", "checked", Maul.Growl.TargetTargetSquishy);
	FeralSkills_SaveToKhaos("Maul.FeralCharge.Enabled", "checked", Maul.FeralCharge.Enabled);
	FeralSkills_SaveToKhaos("Maul.Enrage.Enabled", "checked", Maul.Enrage.Enabled);
	FeralSkills_SaveToKhaos("Maul.Enrage.MaxRage", "checked", Maul.Enrage.MaxRageEnabled);
	FeralSkills_SaveToKhaos("Maul.Enrage.MaxRage", "slider", Maul.Enrage.MaxRage);
	FeralSkills_SaveToKhaos("Maul.DemoralizingRoar.Enabled", "checked", Maul.DemoralizingRoar.Enabled);
	FeralSkills_SaveToKhaos("Maul.DemoralizingRoar.MinRage", "checked", Maul.DemoralizingRoar.MinRageEnabled);
	FeralSkills_SaveToKhaos("Maul.DemoralizingRoar.MinRage", "slider", Maul.DemoralizingRoar.MinRage);
	FeralSkills_SaveToKhaos("Maul.DemoralizingRoar.NotDebuffed", "checked", Maul.DemoralizingRoar.NotDebuffed);
	FeralSkills_SaveToKhaos("Maul.FaerieFire.Enabled", "checked", Maul.FaerieFire.Enabled);
	FeralSkills_SaveToKhaos("Maul.FaerieFire.NotDebuffed", "checked", Maul.FaerieFire.NotDebuffed);
	FeralSkills_SaveToKhaos("Maul.Swipe.Enabled", "checked", Maul.Swipe.Enabled);
	FeralSkills_SaveToKhaos("Maul.Swipe.MinRage", "checked", Maul.Swipe.MinRageEnabled);
	FeralSkills_SaveToKhaos("Maul.Swipe.MinRage", "slider", Maul.Swipe.MinRage);
	FeralSkills_SaveToKhaos("Maul.Swipe.GroupOnly", "checked", Maul.Swipe.GroupOnly);
	
	local Claw = FeralSkills_Settings.Claw;
	--Claw Page
	Claw.AutoShift = CheckButtonClawAutoShift:GetChecked();
	Claw.TigersFury.Enabled = CheckButtonClawTigersFury1:GetChecked();
	Claw.TigersFury.Extra = CheckButtonClawTigersFury2:GetChecked();
	Claw.Rake.Enabled = CheckButtonClawRake1:GetChecked();
	Claw.Rake.HighArmor = CheckButtonClawRake2:GetChecked();
	Claw.Rake.MinHealthEnabled = CheckButtonClawRake3:GetChecked();
	Claw.Rake.MinHealth = tonumber(EditBoxClawRake:GetText());
	Claw.Cower.Enabled = CheckButtonClawCower1:GetChecked();
	Claw.Cower.Aggroed = CheckButtonClawCower2:GetChecked();
	Claw.FaerieFire.Enabled = CheckButtonClawFaerieFire1:GetChecked();
	Claw.FaerieFire.NotDebuffed = CheckButtonClawFaerieFire2:GetChecked();
	Claw.Rip.Enabled = CheckButtonClawRip1:GetChecked();
	Claw.Rip.ComboPoints = tonumber(EditBoxClawRip1:GetText());
	Claw.Rip.HighArmor = CheckButtonClawRip2:GetChecked();
	Claw.Rip.MinHealthEnabled = CheckButtonClawRip3:GetChecked();
	Claw.Rip.MinHealth = tonumber(EditBoxClawRip2:GetText());
	Claw.FerociousBite.Enabled = CheckButtonClawFerociousBite1:GetChecked();
	Claw.FerociousBite.ComboPoints = tonumber(EditBoxClawFerociousBite1:GetText());
	Claw.FerociousBite.MinEnergyEnabled = CheckButtonClawFerociousBite2:GetChecked();
	Claw.FerociousBite.MinEnergy = tonumber(EditBoxClawFerociousBite2:GetText());
	Claw.FerociousBite.MaxHealthEnabled = CheckButtonClawFerociousBite3:GetChecked();
	Claw.FerociousBite.MaxHealth = tonumber(EditBoxClawFerociousBite3:GetText());
	Claw.FerociousBite.Killshot = CheckButtonClawFerociousBite4:GetChecked();
	FeralSkills_SaveToKhaos("Claw.AutoShift", "checked", Claw.AutoShift);
	FeralSkills_SaveToKhaos("Claw.TigersFury.Enabled", "checked", Claw.TigersFury.Enabled);
	FeralSkills_SaveToKhaos("Claw.TigersFury.Extra", "checked", Claw.TigersFury.Extra);
	FeralSkills_SaveToKhaos("Claw.Rake.Enabled", "checked", Claw.Rake.Enabled);
	FeralSkills_SaveToKhaos("Claw.Rake.HighArmor", "checked", Claw.Rake.HighArmor);
	FeralSkills_SaveToKhaos("Claw.Rake.MinHealth", "checked", Claw.Rake.MinHealthEnabled);
	FeralSkills_SaveToKhaos("Claw.Rake.MinHealth", "slider", Claw.Rake.MinHealth);
	FeralSkills_SaveToKhaos("Claw.Cower.Enabled", "checked", Claw.Cower.Enabled);
	FeralSkills_SaveToKhaos("Claw.Cower.Aggroed", "checked", Claw.Cower.Aggroed);
	FeralSkills_SaveToKhaos("Claw.FaerieFire.Enabled", "checked", Claw.FaerieFire.Enabled);
	FeralSkills_SaveToKhaos("Claw.FaerieFire.NotDebuffed", "checked", Claw.FaerieFire.NotDebuffed);
	FeralSkills_SaveToKhaos("Claw.Rip.Enabled", "checked", Claw.Rip.Enabled);
	FeralSkills_SaveToKhaos("Claw.Rip.Enabled", "slider", Claw.Rip.ComboPoints);
	FeralSkills_SaveToKhaos("Claw.Rip.HighArmor", "checked", Claw.Rip.HighArmor);
	FeralSkills_SaveToKhaos("Claw.Rip.MinHealth", "checked", Claw.Rip.MinHealthEnabled);
	FeralSkills_SaveToKhaos("Claw.Rip.MinHealth", "slider", Claw.Rip.MinHealth);
	FeralSkills_SaveToKhaos("Claw.FerociousBite.Enabled", "checked", Claw.FerociousBite.Enabled);
	FeralSkills_SaveToKhaos("Claw.FerociousBite.Enabled", "slider", Claw.FerociousBite.ComboPoints);
	FeralSkills_SaveToKhaos("Claw.FerociousBite.MinEnergy", "checked", Claw.FerociousBite.MinEnergyEnabled);
	FeralSkills_SaveToKhaos("Claw.FerociousBite.MinEnergy", "slider", Claw.FerociousBite.MinEnergy);
	FeralSkills_SaveToKhaos("Claw.FerociousBite.MaxHealth", "checked", Claw.FerociousBite.MaxHealthEnabled);
	FeralSkills_SaveToKhaos("Claw.FerociousBite.MaxHealth", "slider", Claw.FerociousBite.MaxHealth);
	FeralSkills_SaveToKhaos("Claw.FerociousBite.Killshot", "checked", Claw.FerociousBite.Killshot);
	
	local Shred = FeralSkills_Settings.Shred;
	--Shred Page
	Shred.AutoShift = CheckButtonShredAutoShift:GetChecked();
	Shred.TigersFury.Enabled = CheckButtonShredTigersFury1:GetChecked();
	Shred.TigersFury.Extra = CheckButtonShredTigersFury2:GetChecked();
	Shred.Pounce.Enabled = CheckButtonShredPounce1:GetChecked();
	Shred.Pounce.ModifierEnabled = CheckButtonShredPounce2:GetChecked();
	Shred.Pounce.Modifier = UIDropDownMenu_GetSelectedID(DropDownFrameShredPounce); 
	Shred.Pounce.GroupOnly = CheckButtonShredPounce3:GetChecked();
	Shred.Cower.Enabled = CheckButtonShredCower1:GetChecked();
	Shred.Cower.Aggroed = CheckButtonShredCower2:GetChecked();
	Shred.FaerieFire.Enabled = CheckButtonShredFaerieFire1:GetChecked();
	Shred.FaerieFire.NotDebuffed = CheckButtonShredFaerieFire2:GetChecked();
	Shred.Rip.Enabled = CheckButtonShredRip1:GetChecked();
	Shred.Rip.ComboPoints = tonumber(EditBoxShredRip1:GetText());
	Shred.Rip.HighArmor = CheckButtonShredRip2:GetChecked();
	Shred.Rip.MinHealthEnabled = CheckButtonShredRip3:GetChecked();
	Shred.Rip.MinHealth = tonumber(EditBoxShredRip2:GetText());
	Shred.FerociousBite.Enabled = CheckButtonShredFerociousBite1:GetChecked();
	Shred.FerociousBite.ComboPoints = tonumber(EditBoxShredFerociousBite1:GetText());
	Shred.FerociousBite.MinEnergyEnabled = CheckButtonShredFerociousBite2:GetChecked();
	Shred.FerociousBite.MinEnergy = tonumber(EditBoxShredFerociousBite2:GetText());
	Shred.FerociousBite.MaxHealthEnabled = CheckButtonShredFerociousBite3:GetChecked();
	Shred.FerociousBite.MaxHealth = tonumber(EditBoxShredFerociousBite3:GetText());
	Shred.FerociousBite.Killshot = CheckButtonShredFerociousBite4:GetChecked();
	FeralSkills_SaveToKhaos("Shred.AutoShift", "checked", Shred.AutoShift);
	FeralSkills_SaveToKhaos("Shred.TigersFury.Enabled", "checked", Shred.TigersFury.Enabled);
	FeralSkills_SaveToKhaos("Shred.TigersFury.Extra", "checked", Shred.TigersFury.Enabled);
	FeralSkills_SaveToKhaos("Shred.Pounce.Enabled", "checked", Shred.TigersFury.Enabled);
	FeralSkills_SaveToKhaos("Shred.Pounce.Modifier", "checked", Shred.Pounce.ModifierEnabled);
	FeralSkills_SaveToKhaos("Shred.Pounce.Modifier", "slider", Shred.Pounce.Modifier);
	FeralSkills_SaveToKhaos("Shred.Pounce.GroupOnly", "checked", Shred.Pounce.GroupOnly);
	FeralSkills_SaveToKhaos("Shred.Cower.Enabled", "checked", Shred.Cower.Enabled);
	FeralSkills_SaveToKhaos("Shred.Cower.Aggroed", "checked", Shred.Cower.Aggroed);
	FeralSkills_SaveToKhaos("Shred.FaerieFire.Enabled", "checked", Shred.FaerieFire.Enabled);
	FeralSkills_SaveToKhaos("Shred.FaerieFire.NotDebuffed", "checked", Shred.FaerieFire.NotDebuffed);
	FeralSkills_SaveToKhaos("Shred.Rip.Enabled", "checked", Shred.Rip.Enabled);
	FeralSkills_SaveToKhaos("Shred.Rip.Enabled", "slider", Shred.Rip.ComboPoints);
	FeralSkills_SaveToKhaos("Shred.Rip.HighArmor", "checked", Shred.Rip.HighArmor);
	FeralSkills_SaveToKhaos("Shred.Rip.MinHealth", "checked", Shred.Rip.MinHealthEnabled);
	FeralSkills_SaveToKhaos("Shred.Rip.MinHealth", "slider", Shred.Rip.MinHealth);
	FeralSkills_SaveToKhaos("Shred.FerociousBite.Enabled", "checked", Shred.FerociousBite.Enabled);
	FeralSkills_SaveToKhaos("Shred.FerociousBite.Enabled", "slider", Shred.FerociousBite.ComboPoints);
	FeralSkills_SaveToKhaos("Shred.FerociousBite.MinEnergy", "checked", Shred.FerociousBite.MinEnergyEnabled);
	FeralSkills_SaveToKhaos("Shred.FerociousBite.MinEnergy", "slider", Shred.FerociousBite.MinEnergy);
	FeralSkills_SaveToKhaos("Shred.FerociousBite.MaxHealth", "checked", Shred.FerociousBite.MaxHealthEnabled);
	FeralSkills_SaveToKhaos("Shred.FerociousBite.MaxHealth", "slider", Shred.FerociousBite.MaxHealth);
	FeralSkills_SaveToKhaos("Shred.FerociousBite.Killshot", "checked", Shred.FerociousBite.Killshot);
	
	local Shift = FeralSkills_Settings.Shift;
	--Shift Page
	Shift.Bear.Enabled = CheckButtonShiftBear1:GetChecked();
	Shift.Bear.Modifier = UIDropDownMenu_GetSelectedID(DropDownFrameShiftBear); 
	Shift.Bear.Enrage = CheckButtonShiftBearSelfEnrage:GetChecked();
	Shift.Bear.Caster = CheckButtonShiftBearSelfCaster:GetChecked();
	Shift.Cat.Enabled = CheckButtonShiftCat1:GetChecked();
	Shift.Cat.Modifier = UIDropDownMenu_GetSelectedID(DropDownFrameShiftCat); 
	Shift.Cat.Prowl = CheckButtonShiftCatSelfProwl:GetChecked();
	Shift.Cat.Caster = CheckButtonShiftCatSelfCaster:GetChecked();
	Shift.Travel.Enabled = CheckButtonShiftTravel1:GetChecked();
	Shift.Travel.Modifier = UIDropDownMenu_GetSelectedID(DropDownFrameShiftTravel); 
	Shift.Travel.Caster = CheckButtonShiftTravelSelfCaster:GetChecked();
	Shift.Mount.Enabled = CheckButtonShiftMount1:GetChecked();
	Shift.Mount.Modifier = UIDropDownMenu_GetSelectedID(DropDownFrameShiftMount); 
	Shift.Mount.Caster = CheckButtonShiftMountSelfCaster:GetChecked();
	Shift.Mount.Name = EditBoxShiftMountName:GetText();
	Shift.Mount.SpellEnabled = CheckButtonShiftMount2:GetChecked();
	Shift.Mount.Spell = EditBoxShiftMountSpell:GetText();
	local bearSelf = 1;
	if(Shift.Bear.Enrage) then bearSelf = 2; elseif (Shift.Bear.Caster) then bearSelf = 3; end;
	local catSelf = 1;
	if(Shift.Cat.Prol) then catSelf = 2; elseif (Shift.Cat.Caster) then catSelf = 3; end;
	local travelSelf = 1;
	if(Shift.Travel.Caster) then travelSelf = 2; end;
	local mountSelf = 1;
	if(Shift.Mount.Caster) then mountSelf = 2; end;
	FeralSkills_SaveToKhaos("Shift.Bear.Enabled", "checked", Shift.Bear.Enabled);
	FeralSkills_SaveToKhaos("Shift.Bear.Enabled", "value", Shift.Bear.Modifier);
	FeralSkills_SaveToKhaos("Shift.Bear.Self", "value", bearSelf);
	FeralSkills_SaveToKhaos("Shift.Cat.Enabled", "checked", Shift.Cat.Enabled);
	FeralSkills_SaveToKhaos("Shift.Cat.Enabled", "value", Shift.Cat.Modifier);
	FeralSkills_SaveToKhaos("Shift.Cat.Self", "value", catSelf);
	FeralSkills_SaveToKhaos("Shift.Travel.Enabled", "checked", Shift.Travel.Enabled);
	FeralSkills_SaveToKhaos("Shift.Travel.Enabled", "value", Shift.Travel.Modifier);
	FeralSkills_SaveToKhaos("Shift.Travel.Self", "value", travelSelf);
	FeralSkills_SaveToKhaos("Shift.Mount.Enabled", "checked", Shift.Mount.Enabled);
	FeralSkills_SaveToKhaos("Shift.Mount.Enabled", "value", Shift.Mount.Modifier);
	FeralSkills_SaveToKhaos("Shift.Mount.Self", "value", mountSelf);
	FeralSkills_SaveToKhaos("Shift.Mount.Name", "value", Shift.Mount.Name);
	FeralSkills_SaveToKhaos("Shift.Mount.Spell", "checked", Shift.Mount.SpellEnabled);
	FeralSkills_SaveToKhaos("Shift.Mount.Spell", "value", Shift.Mount.Spell);
end


function FeralSkills_Maul()
	
	if(not FeralSkills_Settings.Maul.AutoShift or not FeralSkills_EnsureBear()) then
		local shouldAttack = not FeralSkills_Settings.DontAutoTarget or (UnitExists("target") and UnitHealth("target")>0 and UnitCanAttack("player","target") );
	
		if(shouldAttack) then FeralSkills_EnableAutoAttack(); end
		
		local rage = UnitMana("player");
		local Maul = FeralSkills_Settings.Maul;
		
		if (Maul.Growl.Enabled and shouldAttack and (not Maul.Growl.NotAggroed or (UnitName("targettarget") and not UnitIsUnit("targettarget","player") and (not Maul.Growl.TargetTargetSquishy or FeralSkills_UnitIsSquishyOrLowHealth("targettarget"))  )) and not UnitPlayerControlled("target") and FeralSkills_IsUseable(FeralSkills_Strings.SKILL_GROWL)) then
		--if ((FeralSkills_Settings["Maul_GrowlLevel"] == 2 or (FeralSkills_Settings["Maul_GrowlLevel"] == 1 and UnitName("targettarget") and not UnitIsUnit("targettarget","player"))) and not UnitIsPlayer("target") and FeralSkills_IsUseable(FeralSkills_Strings.SKILL_GROWL)) then
			CastSpellByName(FeralSkills_Strings.SKILL_GROWL);
			SpellStopCasting();
		end
		
		if (Maul.FeralCharge.Enabled and shouldAttack and FeralSkills_IsUseable(FeralSkills_Strings.SKILL_FERALCHARGE)) then
		--if (FeralSkills_Settings["Maul_FeralChargeLevel"] == 1 and FeralSkills_IsUseable(FeralSkills_Strings.SKILL_FERALCHARGE)) then
			CastSpellByName(FeralSkills_Strings.SKILL_FERALCHARGE);
		elseif (Maul.Enrage.Enabled and (not Maul.Enrage.MaxRageEnabled or Maul.Enrage.MaxRage > rage) and FeralSkills_IsUseable(FeralSkills_Strings.SKILL_ENRAGE)) then
		--elseif (FeralSkills_Settings["Maul_EnrageMaxRage"] > rage and FeralSkills_IsUseable(FeralSkills_Strings.SKILL_ENRAGE)) then
			CastSpellByName(FeralSkills_Strings.SKILL_ENRAGE);
		elseif (Maul.DemoralizingRoar.Enabled and shouldAttack and (not Maul.DemoralizingRoar.MinRageEnabled or Maul.DemoralizingRoar.MinRage < rage) and (not Maul.DemoralizingRoar.NotDebuffed or (not FeralSkills_UnitHasDebuff("target","DemoralizingRoar") and not FeralSkills_UnitHasDebuff("target","WarCry"))) and FeralSkills_IsUseable(FeralSkills_Strings.SKILL_DEMORALIZINGROAR)) then
		--elseif (FeralSkills_Settings["Maul_DemoralizingRoarMinRage"] < rage and (FeralSkills_Settings["Maul_DemoralizingRoarLevel"] == 2 or (FeralSkills_Settings["Maul_DemoralizingRoarLevel"] == 1 and not FeralSkills_UnitHasDebuff("target","DemoralizingRoar"))) and FeralSkills_IsUseable(FeralSkills_Strings.SKILL_DEMORALIZINGROAR)) then
			CastSpellByName(FeralSkills_Strings.SKILL_DEMORALIZINGROAR);
		elseif (Maul.Swipe.Enabled and shouldAttack and (not Maul.Swipe.MinRageEnabled or Maul.Swipe.MinRage < rage) and (not Maul.Swipe.GroupOnly or GetNumPartyMembers() > 0) and FeralSkills_IsUseable(FeralSkills_Strings.SKILL_SWIPE)) then
		--elseif (FeralSkills_Settings["Maul_SwipeMinRage"] < rage and (FeralSkills_Settings["Maul_SwipeOnlyInGroup"] == 0 or GetNumPartyMembers() > 0) and FeralSkills_IsUseable(FeralSkills_Strings.SKILL_SWIPE)) then
			CastSpellByName(FeralSkills_Strings.SKILL_SWIPE);
		elseif (Maul.FaerieFire.Enabled and shouldAttack and (not Maul.FaerieFire.NotDebuffed or not FeralSkills_UnitHasDebuff("target","Faerie")) and FeralSkills_IsUseable(FeralSkills_Strings.SKILL_FAERIEFIREFERAL)) then
		--elseif ((FeralSkills_Settings["Maul_FaerieFireLevel"] == 2 or (FeralSkills_Settings["Maul_FaerieFireLevel"] == 1 and not FeralSkills_UnitHasDebuff("target","Faerie"))) and FeralSkills_IsUseable(FeralSkills_Strings.SKILL_FAERIEFIREFERAL)) then
			CastSpellByName(FeralSkills_Strings.SKILL_FAERIEFIREFERAL.."()");
		end
				
		if (FeralSkills_IsUseable(FeralSkills_Strings.SKILL_MAUL) and shouldAttack and not IsCurrentAction(FeralSkills_FindActionIdByName(FeralSkills_Strings.SKILL_MAUL))) then
			SpellStopCasting();
			CastSpellByName(FeralSkills_Strings.SKILL_MAUL);
		end
	end
end

function FeralSkills_Claw()
	
	if(not FeralSkills_Settings.Claw.AutoShift or not FeralSkills_EnsureCat()) then
		local shouldAttack = not FeralSkills_Settings.DontAutoTarget or (UnitExists("target") and UnitHealth("target")>0 and UnitCanAttack("player","target") );
		local allowTigersFury = nil;
		local spellToCast = nil;
		local spellToCastMana = 0;
		local Claw = FeralSkills_Settings.Claw;
		if (Claw.Rip.Enabled and shouldAttack and Claw.Rip.ComboPoints <= GetComboPoints() and not FeralSkills_UnitHasDebuff("target","Frenzy") and (not Claw.Rip.MinHealthEnabled or Claw.Rip.MinHealth <= UnitHealth("target")) and (not Claw.Rip.HighArmor or FeralSkills_TargetHasHighArmor()) and FeralSkills_IsUseable(FeralSkills_Strings.SKILL_RIP)) then
		--if (FeralSkills_Settings["Claw_RipMinComboPoints"] <= GetComboPoints() and not FeralSkills_UnitHasDebuff("target","Frenzy") and FeralSkills_Settings["Claw_RipMinTargetHealth"] <= UnitHealth("target") and (FeralSkills_Settings["Claw_RipHighArmor"] == 0 or targetClass == "PALADIN" or targetClass == "WARRIOR") and FeralSkills_IsUseable(FeralSkills_Strings.SKILL_RIP)) then
			spellToCast = FeralSkills_Strings.SKILL_RIP;
			spellToCastMana = FeralSkills_GetSpellEnergy(FeralSkills_Strings.SKILL_RIP);
		elseif (Claw.FerociousBite.Enabled and shouldAttack and ((Claw.FerociousBite.Killshot and FeralSkills_FBWillKill()) or (Claw.FerociousBite.ComboPoints <= GetComboPoints())) and (not Claw.FerociousBite.MaxHealthEnabled or Claw.FerociousBite.MaxHealth >= UnitHealth("target")) and (not Claw.FerociousBite.MinEnergyEnabled or Claw.FerociousBite.MinEnergy < UnitMana("player")) and FeralSkills_IsUseable(FeralSkills_Strings.SKILL_FEROCIOUSBITE)) then
		--elseif (FeralSkills_Settings["Claw_FerociousBiteMinComboPoints"] <= GetComboPoints() and FeralSkills_Settings["Claw_FerociousBiteMaxTargetHealth"] >= UnitHealth("target") and FeralSkills_Settings["Claw_FerociousBiteMinEnergy"] <= UnitMana("player") and FeralSkills_IsUseable(FeralSkills_Strings.SKILL_FEROCIOUSBITE)) then
			allowTigersFury = 1;
			spellToCast = FeralSkills_Strings.SKILL_FEROCIOUSBITE;
			spellToCastMana = FeralSkills_GetSpellEnergy(FeralSkills_Strings.SKILL_FEROCIOUSBITE);
		elseif (Claw.Rake.Enabled and shouldAttack and (not Claw.Rake.MinHealthEnabled or Claw.Rake.MinHealth < UnitHealth("target")) and not FeralSkills_UnitHasDebuff("target","Disem") and (not Claw.Rake.HighArmor or FeralSkills_TargetHasHighArmor()) and FeralSkills_IsUseable(FeralSkills_Strings.SKILL_RAKE)) then
		--elseif (FeralSkills_Settings["Claw_RakeMinTargetHealth"] <= UnitHealth("target") and not FeralSkills_UnitHasDebuff("target","Disem") and (FeralSkills_Settings["Claw_RakeHighArmor"] == 0 or targetClass == "PALADIN" or targetClass == "WARRIOR") and FeralSkills_IsUseable(FeralSkills_Strings.SKILL_RAKE)) then
			spellToCast = FeralSkills_Strings.SKILL_RAKE;
			spellToCastMana = FeralSkills_GetSpellEnergy(FeralSkills_Strings.SKILL_RAKE);
		elseif (Claw.Cower.Enabled and shouldAttack and UnitMana('player') < 100 and (not Claw.Cower.Aggroed or (UnitIsUnit("targettarget","player") and GetNumPartyMembers() > 0)) and not UnitPlayerControlled("target") and FeralSkills_IsUseable(FeralSkills_Strings.SKILL_COWER)) then
		--elseif ((FeralSkills_Settings["Claw_CowerLevel"] == 2 or (FeralSkills_Settings["Claw_CowerLevel"] == 1 and UnitIsUnit("targettarget","player") and GetNumPartyMembers() > 0)) and not UnitIsPlayer("target") and FeralSkills_IsUseable(FeralSkills_Strings.SKILL_COWER)) then
			spellToCast = FeralSkills_Strings.SKILL_COWER;
			spellToCastMana = FeralSkills_GetSpellEnergy(FeralSkills_Strings.SKILL_COWER);
		elseif (FeralSkills_IsUseable(FeralSkills_Strings.SKILL_CLAW) and shouldAttack) then
			allowTigersFury = 1;
			spellToCast = FeralSkills_Strings.SKILL_CLAW;
			spellToCastMana = FeralSkills_GetSpellEnergy(FeralSkills_Strings.SKILL_CLAW);
		elseif (Claw.FaerieFire.Enabled and shouldAttack and (not Claw.FaerieFire.NotDebuffed or not FeralSkills_UnitHasDebuff("target","Faerie")) and not FeralSkills_UnitHasBuff("player","Ambush") and FeralSkills_IsUseable(FeralSkills_Strings.SKILL_FAERIEFIREFERAL)) then
		--elseif ((FeralSkills_Settings["Claw_FaerieFireLevel"] == 2 or (FeralSkills_Settings["Claw_FaerieFireLevel"] == 1 and not FeralSkills_UnitHasDebuff("target","Faerie"))) and not FeralSkills_UnitHasBuff("player","Ambush") and FeralSkills_IsUseable(FeralSkills_Strings.SKILL_FAERIEFIREFERAL)) then
			spellToCast = FeralSkills_Strings.SKILL_FAERIEFIREFERAL.."()";
			spellToCastMana = 0;
		end
		
		if (Claw.TigersFury.Enabled and (allowTigersFury or not Claw.TigersFury.Extra) and not FeralSkills_UnitHasBuff("player","Tiger") and ((not Claw.TigersFury.Extra and UnitMana("player") > 29) or UnitMana("player") > (29 + spellToCastMana))) then
		--if ((allowTigersFury or FeralSkills_Settings["Claw_TigersFuryLevel"] == 2) and not FeralSkills_UnitHasBuff("player","Tiger") and ((FeralSkills_Settings["Claw_TigersFuryLevel"] == 2 and UnitMana("player") > 29) or (FeralSkills_Settings["Claw_TigersFuryLevel"] == 1 and UnitMana("player") > (29 + spellToCastMana)))) then
			CastSpellByName(FeralSkills_Strings.SKILL_TIGERSFURY);
			SpellStopCasting();
		end
		
		if (spellToCast) then
			CastSpellByName(spellToCast);
		end
		
		if (shouldAttack) then FeralSkills_EnableAutoAttack(); end
	end
end

function FeralSkills_Shred()
	if(not FeralSkills_Settings.Shred.AutoShift or not FeralSkills_EnsureCat()) then
		local shouldAttack = not FeralSkills_Settings.DontAutoTarget or (UnitExists("target") and UnitHealth("target")>0 and UnitCanAttack("player","target") );
		local allowTigersFury = nil;
		local spellToCast = nil;
		local spellToCastMana = 0;
		local _,targetClass = UnitClass("target");
		local Shred = FeralSkills_Settings.Shred;
		if (Shred.Rip.Enabled and shouldAttack and Shred.Rip.ComboPoints <= GetComboPoints() and not FeralSkills_UnitHasDebuff("target","Frenzy") and (not Shred.Rip.MinHealthEnabled or Shred.Rip.MinHealth <= UnitHealth("target")) and (not Shred.Rip.HighArmor or FeralSkills_TargetHasHighArmor()) and FeralSkills_IsUseable(FeralSkills_Strings.SKILL_RIP)) then
		--if (FeralSkills_Settings["Shred_RipMinComboPoints"] <= GetComboPoints() and not FeralSkills_UnitHasDebuff("target","Frenzy") and FeralSkills_Settings["Shred_RipMinTargetHealth"] <= UnitHealth("target") and (FeralSkills_Settings["Shred_RipHighArmor"] == 0 or targetClass == "PALADIN" or targetClass == "WARRIOR") and FeralSkills_IsUseable(FeralSkills_Strings.SKILL_RIP)) then
			spellToCast = FeralSkills_Strings.SKILL_RIP;
			spellToCastMana = FeralSkills_GetSpellEnergy(FeralSkills_Strings.SKILL_RIP);
		elseif (Shred.FerociousBite.Enabled and shouldAttack and ((Shred.FerociousBite.Killshot and FeralSkills_FBWillKill()) or (Shred.FerociousBite.ComboPoints <= GetComboPoints())) and (not Shred.FerociousBite.MaxHealthEnabled or Shred.FerociousBite.MaxHealth >= UnitHealth("target")) and (not Shred.FerociousBite.MinEnergyEnabled or Shred.FerociousBite.MinEnergy < UnitMana("player")) and FeralSkills_IsUseable(FeralSkills_Strings.SKILL_FEROCIOUSBITE)) then
		--elseif (FeralSkills_Settings["Shred_FerociousBiteMinComboPoints"] <= GetComboPoints() and FeralSkills_Settings["Shred_FerociousBiteMaxTargetHealth"] >= UnitHealth("target") and FeralSkills_Settings["Shred_FerociousBiteMinEnergy"] <= UnitMana("player") and FeralSkills_IsUseable(FeralSkills_Strings.SKILL_FEROCIOUSBITE)) then
			allowTigersFury = 1;
			spellToCast = FeralSkills_Strings.SKILL_FEROCIOUSBITE;
			spellToCastMana = FeralSkills_GetSpellEnergy(FeralSkills_Strings.SKILL_FEROCIOUSBITE);
		elseif (Shred.Pounce.Enabled and shouldAttack and (not Shred.Pounce.ModifierEnabled or FeralSkills_IsModifierKeyDown(Shred.Pounce.Modifier)) and (not Shred.Pounce.GroupOnly or GetNumPartyMembers() > 0) and FeralSkills_IsUseable(FeralSkills_Strings.SKILL_POUNCE)) then
		--elseif ((FeralSkills_Settings["Shred_PounceLevel"] == 2 or (FeralSkills_Settings["Shred_PounceLevel"] == 1 and GetNumPartyMembers() > 0)) and (FeralSkills_Settings["Shred_PounceModifier"] == 0 or FeralSkills_IsModifierKeyDown(FeralSkills_Modifiers[FeralSkills_Settings["Shred_PounceModifier"]])) and FeralSkills_IsUseable(FeralSkills_Strings.SKILL_POUNCE)) then
			spellToCast = FeralSkills_Strings.SKILL_POUNCE;
			spellToCastMana = FeralSkills_GetSpellEnergy(FeralSkills_Strings.SKILL_POUNCE);
		elseif (FeralSkills_IsUseable(FeralSkills_Strings.SKILL_RAVAGE) and shouldAttack) then
			allowTigersFury = 1;
			spellToCast = FeralSkills_Strings.SKILL_RAVAGE;
			spellToCastMana = FeralSkills_GetSpellEnergy(FeralSkills_Strings.SKILL_RAVAGE);
		elseif (Shred.Cower.Enabled and shouldAttack and UnitMana('player') < 100 and (not Shred.Cower.Aggroed or (UnitIsUnit("targettarget","player") and GetNumPartyMembers() > 0)) and not UnitPlayerControlled("target") and FeralSkills_IsUseable(FeralSkills_Strings.SKILL_COWER)) then
		--elseif ((FeralSkills_Settings["Shred_CowerLevel"] == 2 or (FeralSkills_Settings["Shred_CowerLevel"] == 1 and UnitIsUnit("targettarget","player") and GetNumPartyMembers() > 0)) and not UnitIsPlayer("target") and FeralSkills_IsUseable(FeralSkills_Strings.SKILL_COWER)) then
			spellToCast = FeralSkills_Strings.SKILL_COWER;
			spellToCastMana = FeralSkills_GetSpellEnergy(FeralSkills_Strings.SKILL_COWER);
		elseif (FeralSkills_IsUseable(FeralSkills_Strings.SKILL_SHRED) and shouldAttack) then
			allowTigersFury = 1;
			spellToCast = FeralSkills_Strings.SKILL_SHRED;
			spellToCastMana = FeralSkills_GetSpellEnergy(FeralSkills_Strings.SKILL_SHRED);
		elseif (Shred.FaerieFire.Enabled and shouldAttack and (not Shred.FaerieFire.NotDebuffed or not FeralSkills_UnitHasDebuff("target","Faerie")) and not FeralSkills_UnitHasBuff("player","Ambush") and FeralSkills_IsUseable(FeralSkills_Strings.SKILL_FAERIEFIREFERAL)) then
		--elseif ((FeralSkills_Settings["Shred_FaerieFireLevel"] == 2 or (FeralSkills_Settings["Shred_FaerieFireLevel"] == 1 and not FeralSkills_UnitHasDebuff("target","Faerie"))) and not FeralSkills_UnitHasBuff("player","Ambush") and FeralSkills_IsUseable(FeralSkills_Strings.SKILL_FAERIEFIREFERAL)) then
			spellToCast = FeralSkills_Strings.SKILL_FAERIEFIREFERAL.."()";
			spellToCastMana = 0;
		end
		
		if (Shred.TigersFury.Enabled and (allowTigersFury or not Shred.TigersFury.Extra) and not FeralSkills_UnitHasBuff("player","Tiger") and ((not Shred.TigersFury.Extra and UnitMana("player") > 29) or UnitMana("player") > (29 + spellToCastMana))) then
		--if ((allowTigersFury or FeralSkills_Settings["Shred_TigersFuryLevel"] == 2) and not FeralSkills_UnitHasBuff("player","Tiger") and ((FeralSkills_Settings["Shred_TigersFuryLevel"] == 2 and UnitMana("player") > 29) or (FeralSkills_Settings["Shred_TigersFuryLevel"] == 1 and UnitMana("player") > (29 + spellToCastMana)))) then
			CastSpellByName(FeralSkills_Strings.SKILL_TIGERSFURY);
			SpellStopCasting();
		end
		
		if (spellToCast) then
			CastSpellByName(spellToCast);
		end
		
		if (not FeralSkills_UnitHasBuff("player","Ambush") and shouldAttack) then
			FeralSkills_EnableAutoAttack();
		end
	end
end

function FeralSkills_TurnOffReallyStupidDruidBarUseActionOverload()
	--workaround for *really* frelling stupid DruidBar code
	if( DruidBarKey and DruidBarKey.EZShift) then
		DruidBarKey.EZShift = nil;
	end
	if(pre_UseAction) then
		UseAction = pre_UseAction; --Wish there was a better way to do this...
	end
end

function FeralSkills_Shift()
	local Shift = FeralSkills_Settings.Shift;
			
	if (Shift.Cat.Enabled and FeralSkills_IsModifierKeyDown(Shift.Cat.Modifier)) then
		FeralSkills_ShiftToCat();
	elseif (Shift.Bear.Enabled and FeralSkills_IsModifierKeyDown(Shift.Bear.Modifier)) then
		FeralSkills_ShiftToBear();
	elseif (Shift.Travel.Enabled and FeralSkills_IsModifierKeyDown(Shift.Travel.Modifier)) then
		FeralSkills_ShiftToTravel();
	elseif (Shift.Mount.Enabled and FeralSkills_IsModifierKeyDown(Shift.Mount.Modifier)) then
		FeralSkills_ShiftToMount();
	end
end

function FeralSkills_GetOldForm()
	local oldForm = 0;
	while oldForm < GetNumShapeshiftForms() do
		oldForm = oldForm + 1;
		_,name,active = GetShapeshiftFormInfo(oldForm);
		if active==1 then
			return name, oldForm;
		end
	end
	return nil, 0;
end

function FeralSkills_ShiftTo(name)
	local findForm = 0;
	while findForm < GetNumShapeshiftForms() do
		findForm = findForm + 1;
		_,nameForm = GetShapeshiftFormInfo(findForm);
		if nameForm==name then
			CastShapeshiftForm(findForm);
			return 1;
		end
	end
end

function FeralSkills_EnsureCat()
	if(FeralSkills_GetOldForm() ~= FeralSkills_Strings.SKILL_CATFORM) then
		FeralSkills_ShiftToCat();
		return 1;
	end
end
function FeralSkills_ShiftToCat()
	local Shift = FeralSkills_Settings.Shift;
	if(FeralSkills_PlayerMounted()) then
		UseAction(FeralSkills_FindActionIdByName(Shift.Mount.Name));
	else	
		local name, oldForm = FeralSkills_GetOldForm();
		if (oldForm == 0) then 
			FeralSkills_ShiftTo(FeralSkills_Strings.SKILL_CATFORM);
		elseif (name == FeralSkills_Strings.SKILL_CATFORM) then
			if (Shift.Cat.Prowl) then 
				UseAction(FeralSkills_FindActionIdByName(FeralSkills_Strings.SKILL_PROWL));
			elseif (Shift.Cat.Caster) then
				CastShapeshiftForm(oldForm);
			end
		else
			CastShapeshiftForm(oldForm);
		end
	end
end

function FeralSkills_EnsureBear()
	local name, oldForm = FeralSkills_GetOldForm();
	if(name ~= FeralSkills_Strings.SKILL_BEARFORM and name ~= FeralSkills_Strings.SKILL_DIREBEARFORM) then
		FeralSkills_ShiftToBear();
		return 1;
	end
end
function FeralSkills_ShiftToBear()
	local Shift = FeralSkills_Settings.Shift;
	if(FeralSkills_PlayerMounted()) then
		UseAction(FeralSkills_FindActionIdByName(Shift.Mount.Name));
	else	
		local name, oldForm = FeralSkills_GetOldForm();
		if(oldForm == 0) then 
			if not FeralSkills_ShiftTo(FeralSkills_Strings.SKILL_DIREBEARFORM) then
				FeralSkills_ShiftTo(FeralSkills_Strings.SKILL_BEARFORM);
			end
		elseif (name == FeralSkills_Strings.SKILL_BEARFORM or name == FeralSkills_Strings.SKILL_DIREBEARFORM) then
			if (Shift.Bear.Enrage) then
				CastSpellByName(FeralSkills_Strings.SKILL_ENRAGE);
			elseif (Shift.Cat.Caster) then
				CastShapeshiftForm(oldForm);
			end
		else
			CastShapeshiftForm(oldForm);
		end
	end
end

function FeralSkills_ShiftToTravel()
	local Shift = FeralSkills_Settings.Shift;
	if(FeralSkills_PlayerMounted()) then
		UseAction(FeralSkills_FindActionIdByName(Shift.Mount.Name));
	else	
		local name, oldForm = FeralSkills_GetOldForm();
		if(oldForm == 0) then
			FeralSkills_ShiftTo(FeralSkills_Strings.SKILL_TRAVELFORM)
			FeralSkills_ShiftTo(FeralSkills_Strings.SKILL_AQUATICFORM)
		elseif (Shift.Travel.Caster) then
			CastShapeshiftForm(oldForm);
		end
	end
end

function FeralSkills_ShiftToMount()
	local Shift = FeralSkills_Settings.Shift;
	if(FeralSkills_PlayerMounted()) then
		if (Shift.Mount.Caster) then
			UseAction(FeralSkills_FindActionIdByName(Shift.Mount.Name));
		end
	else
		local name, oldForm = FeralSkills_GetOldForm();
		if(oldForm == 0) then 
			if (Shift.Mount.SpellEnabled) then CastSpellByName(Shift.Mount.Spell, nil, 1); SpellStopCasting(); end;			
			UseAction(FeralSkills_FindActionIdByName(Shift.Mount.Name));
		else
			CastShapeshiftForm(oldForm);
		end
	end
end

--Experimental function to target next mob that is not aggro'd on you
function FeralSkills_TargetNextNonAggroed()
	local k = 0;
	while(k < 10) do
		if(not UnitName("target") or (UnitName("targettarget") and UnitIsUnit("player", "targettarget"))) then
			TargetNearestEnemy();
			k = k + 1;
		else
			k = 77;
		end
	end

	while(k < 20) do
		if(not UnitName("target") or (UnitName("targettarget") and UnitIsUnit("player", "targettarget") and not UnitHealth("target") == 100)) then
			TargetNearestEnemy();
			k = k + 1;
		else
			k = 77;
		end
	end
end




--Support Functions
function FeralSkills_CreateMacrosGlobal() FeralSkills_CreateMacros(0); end
function FeralSkills_CreateMacrosCharacterSpecific() FeralSkills_CreateMacros(1); end
function FeralSkills_CreateMacros(perCharacter)
	local MacroNames = {"Maùl", "Clàw", "Shrèd", "Shìft"};
	local MacroBodies = {"/script --CastSpellByName(\""..FeralSkills_Strings.SKILL_MAUL.."\");\n/script FeralSkills_Maul();",
						"/script --CastSpellByName(\""..FeralSkills_Strings.SKILL_CLAW.."\");\n/script FeralSkills_Claw();",
						"/script --CastSpellByName(\""..FeralSkills_Strings.SKILL_SHRED.."\");\n/script FeralSkills_Shred();",
						"/script FeralSkills_Shift();"}
	local MacroIconPaths = {"Ability_Druid_Maul", "Ability_Druid_Rake", "Spell_Shadow_VampiricAura", "Ability_Druid_CatForm"};
	while(GetMacroIndexByName("Shèrd") > 0) do --Oops. All the trouble getting foreign characters into the names, and I put it in the wrong spot. Doh.
		DeleteMacro(GetMacroIndexByName("Shèrd"));
	end
	for i = 1, 4 do
		while(GetMacroIndexByName(MacroNames[i]) > 0) do
			DeleteMacro(GetMacroIndexByName(MacroNames[i]));
		end
		CreateMacro(MacroNames[i], FeralSkills_FindIconIndex(MacroIconPaths[i]), MacroBodies[i], 1, perCharacter);
	end
end

function FeralSkills_CreateShiftMacrosGlobal() FeralSkills_CreateShiftMacros(0); end
function FeralSkills_CreateShiftMacrosCharacterSpecific() FeralSkills_CreateShiftMacros(1); end
function FeralSkills_CreateShiftMacros(perCharacter)
	local MacroNames = {"Bear", "Cat", "Travel", "Mount"};
	local MacroBodies = {"/script FeralSkills_ShiftToBear();",
						"/script FeralSkills_ShiftToCat();",
						"/script FeralSkills_ShiftToTravel();",
						"/script FeralSkills_ShiftToMount();"}
	local MacroIconPaths = {"Ability_Racial_BearForm", "Ability_Druid_CatForm", "Ability_Druid_TravelForm", "Ability_Mount_WhiteTiger"};
	for i = 1, 4 do
		while(GetMacroIndexByName(MacroNames[i]) > 0) do
			DeleteMacro(GetMacroIndexByName(MacroNames[i]));
		end
		CreateMacro(MacroNames[i], FeralSkills_FindIconIndex(MacroIconPaths[i]), MacroBodies[i], 1, perCharacter);
	end
end

function FeralSkills_FindIconIndex(path)
	for i = 1, GetNumMacroIcons() do
		if (string.find(GetMacroIconInfo(i), path)) then
			return i;
		end
	end
end

function FeralSkills_FBWillKill()
	if MobHealthFrame and GetComboPoints() > 0 then
		local _,_,_,_,feralAggressionRank = GetTalentInfo(2,2);
		local avgDamage = (70 + (145 * GetComboPoints())) * ( 1 + (.03 * feralAggressionRank));
		local currHP = FeralSkills_GetTargetCurHP();
		if avgDamage and currHP and avgDamage >= currHP then
			--fsprint("Expected FB Dmg: "..avgDamage);
			return 1;
		end
	end
end

function FeralSkills_GetTargetCurHP()
  if  MobHealth_GetTargetCurHP  then
    return MobHealth_GetTargetCurHP();
  else
    local name  = UnitName("target");
    local level = UnitLevel("target");
    local healthPercent = UnitHealth("target");
    if  name  and  level  and  healthPercent  then
      local index = name..":"..level;
      local ppp = MobHealth_PPP( index );
      return math.floor( healthPercent * ppp + 0.5);
    end
  end
  return 0;
end  -- of My_MobHealth_GetTargetCurHP()

function FeralSkills_TargetHasHighArmor()
	local _,targetClass = UnitClass("target");
	if (targetClass == "PALADIN" or targetClass == "WARRIOR" or (targetClass == "DRUID" and FeralSkills_UnitHasBuff("target","Bear"))) then
		return (UnitLevel("target") - UnitLevel("player") >= -7);
	else
		return (UnitLevel("target") - UnitLevel("player") >= 3);
	end
end

function FeralSkills_UnitIsSquishyOrLowHealth(unitname)
	local _,targetClass = UnitClass(unitname);
	if (targetClass == "PALADIN" or targetClass == "WARRIOR" or (targetClass == "DRUID" and FeralSkills_UnitHasBuff("target","Bear"))) then
		return (UnitHealth(unitname)/UnitHealthMax(unitname) < .4);
	else
		return true;
	end
end

function FeralSkills_EnableAutoAttack()
	local k=1;
	while k<121 do
		if IsAttackAction(k) then
			if not IsCurrentAction(k) then
				AttackTarget();
			end
			k=121;
		end
		k=k+1
	end
end

function FeralSkills_IsModifierKeyDown(key)
	if((key==1 and not IsShiftKeyDown() and not IsControlKeyDown() and not IsAltKeyDown()) or (key==2 and IsShiftKeyDown()) or (key==3 and IsControlKeyDown()) or (key==4 and IsAltKeyDown())) then
		return 1;
	else
		return nil;
	end
end

function FeralSkills_UnitHasDebuff(unit, debuffName) 
  local i = 1;
  while (UnitDebuff(unit, i)) do
    if (string.find(UnitDebuff(unit, i), debuffName)) then
		return i;
    end
    i = i + 1;
  end
end

function FeralSkills_UnitHasBuff(unit, buffName) 
  local i = 1;
  while (UnitBuff(unit, i)) do
    if (string.find(UnitBuff(unit, i), buffName)) then
      return i;
    end
    i = i + 1;
  end
end

function FeralSkills_IsUseable(name)
	----Check:
	--player has spell
	--enough mana for spell
	--spell is in range
	--spell is cooled down
	--target isn't immune
	local id = FeralSkills_FindActionIdByName(name);
	if (id and IsUsableAction(id) and GetActionCooldown(id) == 0 and
		(IsActionInRange(id) == 1 or name==FeralSkills_Strings.SKILL_ENRAGE or
		(name==FeralSkills_Strings.SKILL_DEMORALIZINGROAR and CheckInteractDistance("target", 2)))
		and (not FeralSkills_Settings.TrackImmunities or
		(not (FeralSkills_Immunities[name] and FeralSkills_Immunities[name][UnitName("target")])
		and not (name==FeralSkills_Strings.SKILL_RAKE and FeralSkills_Immunities[FeralSkills_Strings.SKILL_RIP] and FeralSkills_Immunities[FeralSkills_Strings.SKILL_RIP][UnitName("target")]))) ) then
		
		
		--fsprint(name.." is usable");
		return 1;
	else
		--fsprint(name.." is not usable");
		return nil;
	end
	
end

--local id = FeralSkills_FindActionIdByName(name);FeralSkills_Tooltip:ClearLines();FeralSkills_Tooltip:SetAction(id);local _,_,mana = string.find(FeralSkills_TooltipTextLeft2:GetText(), "(%d-) "..FeralSkills_Strings.ENERGYCOSTDETECTIONTEXT);

function FeralSkills_GetSpellEnergy(name)
	local id = FeralSkills_FindActionIdByName(name);
	FeralSkills_Tooltip:ClearLines();
	FeralSkills_Tooltip:SetAction(id);
	local energy = 0;
	if(not FeralSkills_TooltipTextLeft2:GetText()) then
		fsprint("FeralSkills requires Enhanced Tooltips to be on in order to detect important information about your feral skills. Please turn Enhanced Tooltips on, in the default UI's Interface Options.");
	else
		_,_,str = string.find(FeralSkills_TooltipTextLeft2:GetText(), "(%d-) "..FeralSkills_Strings.ENERGYCOSTDETECTIONTEXT);
		energy = tonumber(str) or 0;
	end
	return energy;
end

FeralSkills_ErroredSkills = {};
FeralSkills_NameActionIdCache = {};
function FeralSkills_FindActionIdByName(name)
	--Check to see if the name is in the cache, and if it is, make sure that it"s still in that action id, then return it if so.
	if(FeralSkills_NameActionIdCache[name]) then
		if (HasAction(FeralSkills_NameActionIdCache[name]) and not GetActionText(FeralSkills_NameActionIdCache[name])) then
			FeralSkills_Tooltip:ClearLines();
			FeralSkills_Tooltip:SetAction(FeralSkills_NameActionIdCache[name]);
			if (FeralSkills_TooltipTextLeft1:GetText() == name) then
				return FeralSkills_NameActionIdCache[name];
			end
		end
	end

	--Loop through the action ids and find the spell by name
	local k = 1;
	while k<121 do
		if (HasAction(k) and not GetActionText(k)) then
			FeralSkills_Tooltip:ClearLines();
			FeralSkills_Tooltip:SetAction(k);
			if (FeralSkills_TooltipTextLeft1:GetText() == name) then
				FeralSkills_NameActionIdCache[name] = k;
				return k;
			end
		end
		k = k + 1;
	end
	
	if(not FeralSkills_ErroredSkills[name] and (name ~= FeralSkills_Strings.SKILL_RAVAGE or UnitLevel("Player") > 31)) then
		FeralSkills_ErroredSkills[name] = true;
		fsprint(name.." not found. FeralSkills requires skills to be on an action bar in order to be used. They may be on a hidden page/bar. Please add "..name.." to an action bar.");
	end
	return nil;
end

function fsprint(message)
	DEFAULT_CHAT_FRAME:AddMessage(message,0,0,1);
end

FeralSkills_ProblemMounts = {
	["Interface\\Icons\\Ability_Mount_PinkTiger"] = 1,
	["Interface\\Icons\\Ability_Mount_WhiteTiger"] = 1,
	["Interface\\Icons\\Spell_Nature_Swiftness"] = 1,
	["Interface\\Icons\\INV_Misc_Foot_Kodo"] = 1,
	["Interface\\Icons\\Ability_Mount_JungleTiger"] =1
}
--Thanks to Gello"s ItemRack for this function.
function FeralSkills_PlayerMounted()

	local i,buff,mounted

	for i=1,24 do
		buff = UnitBuff("player",i)
		if buff then
			if FeralSkills_ProblemMounts[buff] then
				-- hunter could be in group, could be warlock epic mount etc, check if this is truly a mount
				-- or if v1 is set to true, always check every buff. sigh this is slow but really no way around it without more data from users
				FeralSkills_Tooltip:SetUnitBuff("player",i)
				if string.find(FeralSkills_TooltipTextLeft2:GetText(), "^"..FeralSkills_Strings.MOUNTDETECTIONTEXT) then
					mounted = true
					i = 25
				end
			elseif string.find(buff,"Mount_") then
				mounted = true
				i = 25
			end
		else
			i = 25
		end
	end

	return mounted
end




function DropDownFrameShiftBear_OnLoad() 
	UIDropDownMenu_Initialize(this, DropDownFrameShiftBear_Initialize); 
	UIDropDownMenu_SetSelectedID(DropDownFrameShiftBear, 1); 
end 
function DropDownFrameShiftBear_Initialize() 
	local info = {}; 
	local value = 1;
	while value < 5 do
		info = {}; 
		info.text = FeralSkills_Modifiers[value];
		info.func = DropDownFrameShiftBear_OnClick; 
		info.value = value; 
		UIDropDownMenu_AddButton(info); 
		value = value + 1;
	end
end 
function DropDownFrameShiftBear_OnClick() 
	UIDropDownMenu_SetSelectedID(DropDownFrameShiftBear, this:GetID()); 
end

function DropDownFrameShiftCat_OnLoad() 
	UIDropDownMenu_Initialize(this, DropDownFrameShiftCat_Initialize); 
	UIDropDownMenu_SetSelectedID(DropDownFrameShiftCat, 1); 
end 
function DropDownFrameShiftCat_Initialize() 
	local info = {}; 
	local value = 1;
	while value < 5 do
		info = {}; 
		info.text = FeralSkills_Modifiers[value];
		info.func = DropDownFrameShiftCat_OnClick; 
		info.value = value; 
		UIDropDownMenu_AddButton(info); 
		value = value + 1;
	end
end 
function DropDownFrameShiftCat_OnClick() 
	UIDropDownMenu_SetSelectedID(DropDownFrameShiftCat, this:GetID()); 
end

function DropDownFrameShiftTravel_OnLoad() 
	UIDropDownMenu_Initialize(this, DropDownFrameShiftTravel_Initialize); 
	UIDropDownMenu_SetSelectedID(DropDownFrameShiftTravel, 1); 
end 
function DropDownFrameShiftTravel_Initialize() 
	local info = {}; 
	local value = 1;
	while value < 5 do
		info = {}; 
		info.text = FeralSkills_Modifiers[value];
		info.func = DropDownFrameShiftTravel_OnClick; 
		info.value = value; 
		UIDropDownMenu_AddButton(info); 
		value = value + 1;
	end
end 
function DropDownFrameShiftTravel_OnClick() 
	UIDropDownMenu_SetSelectedID(DropDownFrameShiftTravel, this:GetID()); 
end

function DropDownFrameShiftMount_OnLoad() 
	UIDropDownMenu_Initialize(this, DropDownFrameShiftMount_Initialize); 
	UIDropDownMenu_SetSelectedID(DropDownFrameShiftMount, 1); 
end 
function DropDownFrameShiftMount_Initialize() 
	local info = {}; 
	local value = 1;
	while value < 5 do
		info = {}; 
		info.text = FeralSkills_Modifiers[value];
		info.func = DropDownFrameShiftMount_OnClick; 
		info.value = value; 
		UIDropDownMenu_AddButton(info); 
		value = value + 1;
	end
end 
function DropDownFrameShiftMount_OnClick() 
	UIDropDownMenu_SetSelectedID(DropDownFrameShiftMount, this:GetID()); 
end

function DropDownFrameShredPounce_OnLoad() 
	UIDropDownMenu_Initialize(this, DropDownFrameShredPounce_Initialize); 
	UIDropDownMenu_SetSelectedID(DropDownFrameShredPounce, 1); 
end 
function DropDownFrameShredPounce_Initialize() 
	local info = {}; 
	local value = 1;
	while value < 5 do
		info = {}; 
		info.text = FeralSkills_Modifiers[value];
		info.func = DropDownFrameShredPounce_OnClick; 
		info.value = value; 
		UIDropDownMenu_AddButton(info); 
		value = value + 1;
	end
end 
function DropDownFrameShredPounce_OnClick() 
	UIDropDownMenu_SetSelectedID(DropDownFrameShredPounce, this:GetID()); 
end