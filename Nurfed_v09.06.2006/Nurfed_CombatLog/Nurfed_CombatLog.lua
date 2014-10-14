
NURFED_COMBATLOG_DEFAULT = {
	You = { (0/255), (192/255), (255/255) },
	Pet = { (0/255), (153/255), (102/255) },
	Party = { (255/255), (153/255), (0/255) },
	Raid = { (251/255), (210/255), (132/255) },
	Enemy = { (255/255), (116/255), (109/255) },
	Target = { (255/255), (116/255), (109/255) },
	Friendly = { (251/255), (210/255), (132/255) },
	[HEALTH] = { (255/255), (0/255), (0/255) },
	[MANA] = { (0/255), (255/255), (255/255) },
	[RAGE] = { 1, 0, 0 },
	[ENERGY] = { 1, 1, 0 },
	[HAPPINESS] = { 1, 0.5, 0.25 },
	[SPELL_SCHOOL0_CAP] = { (255/255), (255/255), (150/255) },
	[SPELL_SCHOOL1_CAP] = { (255/255), (255/255), (0/255) },
	[SPELL_SCHOOL2_CAP] = { (255/255), (0/255), (0/255) },
	[SPELL_SCHOOL3_CAP] = { (0/255), (102/255), (0/255) },
	[SPELL_SCHOOL4_CAP] = { (0/255), (102/255), (255/255) },
	[SPELL_SCHOOL5_CAP] = { (202/255), (76/255), (217/255) },
	[SPELL_SCHOOL6_CAP] = { (153/255), (204/255), (255/255) },
	Heal = { (96/255), (255/255), (99/255) },
	[MISS] = { (0/255), (255/255),  (255/255) },
	damage = { (255/255), (47/255), (47/255) },
	overlay = { (255/255), (255/255), (0/255) },
	buff = { (255/255), (255/255), (0/255) },
	debuff = { (255/255), (255/255), (0/255) },
	cast = { (255/255), (255/255), (0/255) },
	source = "[$n]",
	target = "[$n]",
	death = "--** $n",
	crit = "*$d*",
	spellalert = "Begins to cast $s",
	deathout = 2,
	destroyed = 1,
	sourcewatches = {
		[YOU] = { 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
	},
	targetwatches = {
		[YOU] = { 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
	},
};

local utility = Nurfed_Utility:New();
local lib = Nurfed_CombatLog:New();
local framelib = Nurfed_Frames:New();

local eventframe = {
	type = "Frame",
	events = {
	},
	OnEvent = function() lib:ParseEvent(event, arg1) end,
};


function Nurfed_CombatLog_Init()
	if (eventframe) then
		for event in ChatTypeGroup do
			for e, l in lib.events do
				if (string.find(event, e, 1, true)) then
					table.insert(eventframe.events, "CHAT_MSG_"..event);
				end
			end
		end

		-- CombatMessageAmbigousfix by No-Nonsense
		if (GetLocale() == "deDE" and not IsAddOnLoaded("CombatMessagesAmbigousFix")) then
			local COMBAT_MESSAGES = {
				"SPELLLOGCRITOTHEROTHER",
				"SPELLLOGOTHEROTHER",
				"SPELLLOGCRITSCHOOLOTHERSELF",
				"SPELLLOGCRITSCHOOLOTHEROTHER",
				"SPELLLOGSCHOOLOTHERSELF",
				"SPELLLOGSCHOOLOTHEROTHER",
				"SPELLSPLITDAMAGEOTHEROTHER",
				"SPELLSPLITDAMAGEOTHERSELF",
				"SPELLRESISTOTHEROTHER",
				"PERIODICAURAHEALOTHEROTHER",
				"HEALEDCRITOTHEROTHER",
				"HEALEDCRITOTHERSELF",
				"HEALEDOTHEROTHER"
			};
			for _, cmsg in COMBAT_MESSAGES do
				local fixcode = cmsg .. '= string.gsub(string.gsub(' .. cmsg .. ', "(%%%d%$s)s", "%1\'s"), "%%ss", "%%s\'s")';
				RunScript(fixcode);
			end
			local COMBAT_MESSAGES = nil;
		end

		framelib:ObjectInit("Nurfed_CombatLogFrame", eventframe, UIParent);
		eventframe = nil;
		lib:Init();
	end
end

function nctest(num)
	if (not num or type(num) ~= "number") then
		utility:Print("Usage: nctest(number)");
		return;
	end
	local now = GetTime();
	for i=1, num do
		lib:ParseEvent("CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE", "Bob's Fireball crits You for 2000."..GLANCING_TRAILER)
	end
	utility:Print(num.." CombatLog Events Completed in "..format("%.3f", GetTime() - now));
end