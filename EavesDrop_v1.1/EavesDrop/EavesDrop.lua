--[[
  ****************************************************************
	EavesDrop 1.01

	Author: Grayhoof. Original idea by Bant. Coding help/samples
					from Andalia`s SideCombatLog and CombatChat.
					
	Notes: Code comments coming at a later time.
	****************************************************************]]
	
EavesDrop = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceDB-2.0", "AceConsole-2.0", "Metrognome-2.0")

local parser = ParserLib:GetInstance("1.1")
local BS = AceLibrary("AceLocale-2.1"):GetInstance("Babble-Spell-2.1")
local dewdrop = AceLibrary("Dewdrop-2.0")
local compost = AceLibrary("Compost-2.0")
local L = AceLibrary("AceLocale-2.1"):GetInstance("EavesDrop", true)

local OUTGOING = 1
local INCOMING = -1
local MISC = 3

local critchar = "*"
local deathchar = "†";
local crushchar = "^";
local glancechar = "~";

local arrEventData = {};
local frameSize = 21;
local arrSize = 10;
local arrMaxSize = 128;
local scroll = 0;
local allShown = false;

local eventlist = {
	"CHAT_MSG_COMBAT_CREATURE_VS_SELF_HITS",
	"CHAT_MSG_COMBAT_CREATURE_VS_SELF_MISSES",
	"CHAT_MSG_COMBAT_HOSTILEPLAYER_HITS",
	"CHAT_MSG_COMBAT_HOSTILEPLAYER_MISSES",
	"CHAT_MSG_COMBAT_SELF_HITS",
	"CHAT_MSG_COMBAT_SELF_MISSES",
	"CHAT_MSG_SPELL_CREATURE_VS_SELF_BUFF",
	"CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE",
	"CHAT_MSG_SPELL_DAMAGESHIELDS_ON_OTHERS",
	"CHAT_MSG_SPELL_DAMAGESHIELDS_ON_SELF",
	"CHAT_MSG_SPELL_HOSTILEPLAYER_BUFF",
	"CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE",
	"CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE",
	"CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_BUFFS",
	"CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE",
	"CHAT_MSG_SPELL_PERIODIC_PARTY_BUFFS",
	"CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS",
	"CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE",
	"CHAT_MSG_SPELL_SELF_BUFF",
	"CHAT_MSG_SPELL_SELF_DAMAGE",
	"CHAT_MSG_COMBAT_HOSTILE_DEATH",
}

local peteventlist = {
	"CHAT_MSG_COMBAT_PET_HITS",
	"CHAT_MSG_SPELL_PET_DAMAGE",
	"CHAT_MSG_COMBAT_PET_MISSES",
}

local arrSpellColors = {
	[SPELL_SCHOOL0_CAP] = {r=1,g=0,b=0},
	[SPELL_SCHOOL1_CAP] = {r=1,g=1,b=0},
	[SPELL_SCHOOL2_CAP] = {r=1,g=.3,b=0},
	[SPELL_SCHOOL3_CAP] = {r=.5,g=1,b=.2},
	[SPELL_SCHOOL4_CAP] = {r=.4,g=.6,b=.9},
	[SPELL_SCHOOL5_CAP] = {r=.4,g=.4,b=.5},
	[SPELL_SCHOOL6_CAP] = {r=.8,g=.8,b=1},
}

function EavesDrop:OnInitialize()
	--default settings
	local default_config = self:GetDefaultConfig();
		
	--slash command setup
	self:SetupOptions();

	self:RegisterDB("EavesDropDB")
	self:RegisterDefaults('profile', default_config )
	self:RegisterChatCommand({"/EavesDrop"}, self.options)
	
	self:PerformDisplayOptions();
end

function EavesDrop:OnEnable()
	self:RegisterEvent("PLAYER_DEAD")
	self:UpdateExpEvents();
	self:UpdateRepEvents();
	self:UpdateHonorEvents();
	self:UpdateCombatEvents();
	self:UpdatePetEvents();
	self:UpdateFadeEvents();
	self:UpdateSkillEvents()

	for _, event in pairs(eventlist) do
		parser:RegisterEvent(
			"EavesDrop",
			event,
			EavesDrop.CombatEvent
		)
	end
	
	--setup metro
	self:RegisterMetro("EavesDrop", self.OnUpdate, .1, self) 
	
	--show frame
	EavesDropFrame:Show();
	if (self.db.profile["FADEFRAME"] == true) then
		self:HideFrame();
	end

end

function EavesDrop:OnDisable()
	parser:UnregisterAllEvents("EavesDrop")
	self:UnregisterAllEvents()
	self:UnregisterMetro("EavesDrop")
	EavesDropFrame:Hide();
end

function EavesDrop:UpdateCombatEvents()
	if (self.db.profile["COMBAT"] == true) then
		self:RegisterEvent("PLAYER_REGEN_DISABLED");
		self:RegisterEvent("PLAYER_REGEN_ENABLED");
	else
		if (self:IsEventRegistered("PLAYER_REGEN_DISABLED")) then
			self:UnregisterEvent("PLAYER_REGEN_DISABLED");
		end
		if (self:IsEventRegistered("PLAYER_REGEN_ENABLED")) then
			self:UnregisterEvent("PLAYER_REGEN_ENABLED");
		end
	end
end

function EavesDrop:UpdatePetEvents()
	if (self.db.profile["PET"] == true) then
		for _, event in pairs(peteventlist) do
			parser:RegisterEvent(
				"EavesDrop",
				event,
				EavesDrop.CombatPetOutEvent
			)
		end
	else
		for _, event in pairs(peteventlist) do
			parser:UnregisterEvent(
				"EavesDrop",
				event
			)
		end
	end
end

function EavesDrop:UpdateExpEvents()
	if (self.db.profile["EXP"] == true) then
		parser:RegisterEvent("EavesDrop","CHAT_MSG_COMBAT_XP_GAIN",EavesDrop.CombatEvent)
	else
		parser:UnregisterEvent("EavesDrop","CHAT_MSG_COMBAT_XP_GAIN")
	end
end

function EavesDrop:UpdateRepEvents()
	if (self.db.profile["REP"] == true) then
		parser:RegisterEvent("EavesDrop","CHAT_MSG_COMBAT_FACTION_CHANGE",EavesDrop.CombatEvent)
	else
		parser:UnregisterEvent("EavesDrop","CHAT_MSG_COMBAT_FACTION_CHANGE")
	end
end

function EavesDrop:UpdateHonorEvents()
	if (self.db.profile["HONOR"] == true) then
		parser:RegisterEvent("EavesDrop","CHAT_MSG_COMBAT_HONOR_GAIN",EavesDrop.CombatEvent)
	else
		parser:UnregisterEvent("EavesDrop","CHAT_MSG_COMBAT_HONOR_GAIN")
	end
end

function EavesDrop:UpdateFadeEvents()
	if (self.db.profile["FADE"] == true) then
		parser:RegisterEvent("EavesDrop","CHAT_MSG_SPELL_AURA_GONE_SELF",EavesDrop.CombatEvent)
	else
		parser:UnregisterEvent("EavesDrop","CHAT_MSG_SPELL_AURA_GONE_SELF")
	end
end

function EavesDrop:UpdateSkillEvents()
	if (self.db.profile["SKILL"] == true) then
		self:RegisterEvent("CHAT_MSG_SKILL");
	else
		if (self:IsEventRegistered("CHAT_MSG_SKILL")) then
			self:UnregisterEvent("CHAT_MSG_SKILL");
		end
	end
end

function EavesDrop:PLAYER_REGEN_DISABLED()
	self:DisplayEvent(MISC, L["StartCombat"], nil, self.db.profile["MISC"])
end

function EavesDrop:PLAYER_REGEN_ENABLED()
	self:DisplayEvent(MISC, L["EndCombat"], nil, self.db.profile["MISC"])
end

function EavesDrop:PLAYER_DEAD()
	self:DisplayEvent(MISC, deathchar..UnitName("player")..deathchar, nil, self.db.profile["DEATH"])
end

function EavesDrop:CHAT_MSG_SKILL(larg1)
	local target, rank = parser:Deformat(larg1, SKILL_RANK_UP);
	if target then
		self:DisplayEvent(MISC, target..": "..rank, nil, self.db.profile["SKILLC"])
	end
end

----------------------
--Reset everything to default
function EavesDrop:Reset()
	self:ResetDB("profile");
	self:UpdateExpEvents();
	self:UpdateRepEvents();
	self:UpdateHonorEvents();
	self:UpdateCombatEvents();
	self:UpdatePetEvents();
	self:UpdateFadeEvents();
	self:UpdateSkillEvents()
	self:PerformDisplayOptions();
	self:UpdateEvents();
end

function EavesDrop:PerformDisplayOptions()
	--set size
	arrSize = self.db.profile["NUMLINES"];
	frameSize = self.db.profile["LINEHEIGHT"] + 1;
	local totalh = (frameSize * arrSize) + 50;
	local totalw = (self.db.profile["LINEHEIGHT"] * 2) + self.db.profile["LINEWIDTH"]
	EavesDropFrame:SetHeight(totalh);
	EavesDropFrame:SetWidth(totalw);
	--update look of frame
	local r,g,b,a = self.db.profile["FRAME"].r, self.db.profile["FRAME"].g, self.db.profile["FRAME"].b, self.db.profile["FRAME"].a
	EavesDropFrame:SetBackdropColor(r, g, b, a);
	EavesDropTopBar:SetGradientAlpha("VERTICAL", r*.1, g*.1, b*.1, 0, r*.2, g*.2, b*.2, a)
	EavesDropBottomBar:SetGradientAlpha("VERTICAL", r*.2, g*.2, b*.2, a, r*.1, g*.1, b*.1, 0)
	EavesDropTopBar:SetWidth(totalw-10)
	EavesDropBottomBar:SetWidth(totalw-10)
	r,g,b,a = self.db.profile["BORDER"].r, self.db.profile["BORDER"].g, self.db.profile["BORDER"].b, self.db.profile["BORDER"].a
	EavesDropFrame:SetBackdropBorderColor(r, g, b, a);
	EavesDropFrame:EnableMouse(not self.db.profile["LOCKED"]);
	--tooltips
	EavesDropTab.tooltipText = L["TabTip"];
	if (self.db.profile["SCROLLBUTTON"] == true) then
  	EavesDropFrameDownButton:Hide();
		EavesDropFrameUpButton:Hide();
	else
		EavesDropFrameDownButton.tooltipText = L["DownTip"];
		EavesDropFrameUpButton.tooltipText = L["UpTip"];
		self:UpdateScrollButtons();
	end
	--labels
	r,g,b,a = self.db.profile["LABELC"].r, self.db.profile["LABELC"].g, self.db.profile["LABELC"].b, self.db.profile["LABELC"].a
 	if (self.db.profile["FLIP"] == true) then
 		EavesDropFramePlayerText:SetText(L["TargetLabel"]);
 		EavesDropFrameTargetText:SetText(L["PlayerLabel"]);
 	else
 		EavesDropFramePlayerText:SetText(L["PlayerLabel"]);
 		EavesDropFrameTargetText:SetText(L["TargetLabel"]);
 	end
 	EavesDropFramePlayerText:SetTextColor(r,g,b,a);
 	EavesDropFrameTargetText:SetTextColor(r,g,b,a);
 	
	self:ResetEvents()
end

function EavesDrop:HideFrame()
	EavesDropFrame:SetAlpha(0);
end

function EavesDrop:ShowFrame()
	EavesDropFrame:SetAlpha(1);
	EavesDropTab:SetAlpha(0);
end

function EavesDrop:CombatEvent(info)
	local text = info.amount
	local self = EavesDrop;
	local texture
	if (info.skill and type(info.skill) ~= "number") then
		texture = BS:GetSpellIcon(info.skill);
		if (texture == nil and self.db.profile["PLACEHOLDER"] == true) then 
			texture = "Interface\\Icons\\INV_Misc_QuestionMark"
		end
	end
	if info.type == "hit" then
		if (info.isCrit) then text = critchar..text..critchar end;
		if (info.isCrushing) then text = crushchar..text..crushchar end;
		if (info.isGlancing) then text = glancechar..text..glancechar end;
		if (info.amountResist) then text = text.." ("..info.amountResist..")" end;
		if (info.amountBlock) then text = text.." ("..info.amountBlock..")" end;
		if (info.amountAbsorb) then text = text.." ("..info.amountAbsorb..")" end;
		if (info.source == ParserLib_SELF or info.victim == ParserLib_SELF) then
			if info.skill == ParserLib_MELEE then
				if info.source == ParserLib_SELF then
					self:DisplayEvent(OUTGOING, text, texture, self.db.profile["TMELEE"])
				elseif info.victim == ParserLib_SELF then
					self:DisplayEvent(INCOMING, "-"..text, texture, self.db.profile["PHIT"])
				end
			else
				if info.source == ParserLib_SELF and info.victim ~= ParserLib_SELF then
					self:DisplayEvent(OUTGOING, text, texture, self:SpellColor(self.db.profile["TSPELL"], info.element))
				elseif info.victim == ParserLib_SELF then
					self:DisplayEvent(INCOMING, "-"..text, texture, self:SpellColor(self.db.profile["PSPELL"], info.element))
				end
			end
		else
			if (self:GetTargetUnit(info.victim) == "pet" and self.db.profile["PET"] == true) then
				self:DisplayEvent(INCOMING, "-"..text, texture, self.db.profile["PETI"])
			end
		end
	elseif info.type == "drain" and info.attribute == "Health" then
		if info.source == ParserLib_SELF then
				self:DisplayEvent(OUTGOING, text, texture, self:SpellColor(self.db.profile["TSPELL"], info.element))
			elseif info.victim == ParserLib_SELF then
				self:DisplayEvent(INCOMING, "-"..text, texture, self:SpellColor(self.db.profile["PSPELL"], info.element))
			end
	elseif info.type == "leech" then
		text = info.amountGained
		if info.attribute == "Health" then
			if info.source == ParserLib_SELF then
				self:DisplayEvent(OUTGOING, text, texture, self:SpellColor(self.db.profile["TSPELL"], info.element))
			elseif info.victim == ParserLib_SELF then
				self:DisplayEvent(INCOMING, "-"..text, texture, self:SpellColor(self.db.profile["PSPELL"], info.element))
			end
		end
		if info.attributeGained == "Health" then
			if info.sourceGained == ParserLib_SELF then
				if (text < self.db.profile["HFILTER"]) then return end; 
				self:DisplayEvent(INCOMING, "+"..text, texture, self.db.profile["PHEAL"])
			end
		end
	elseif info.type == "heal" then
		if info.victim == ParserLib_SELF then
			if (text < self.db.profile["HFILTER"]) then return end; 
			if (info.isCrit) then text = critchar..text..critchar end;
			if (self.db.profile["HEALERID"] == true and info.source ~= ParserLib_SELF) then text = text.." ("..info.source..")" end;
			self:DisplayEvent(INCOMING, "+"..text, texture, self.db.profile["PHEAL"])
		elseif info.source == ParserLib_SELF then
			if (text < self.db.profile["HFILTER"]) then return end;
			if (self.db.profile["OVERHEAL"] == true) then
				text = self:GetOverheal(info.victim, text);
			end;
			if (info.isCrit) then text = critchar..text..critchar end;
			text = "+"..text;
			if (self.db.profile["HEALERID"] == true) then text = info.victim..": "..text end;
			self:DisplayEvent(OUTGOING, text, texture, self.db.profile["THEAL"])
		end
	elseif info.type == "miss" then
		local miss = getglobal(strupper(info.missType));
		if (info.source == ParserLib_SELF or info.victim == ParserLib_SELF) then
			if info.source == ParserLib_SELF then
				local tcolor;
				if info.skill == ParserLib_MELEE then
					tcolor = "TMELEE";
				else
					tcolor = "TSPELL";
				end
				self:DisplayEvent(OUTGOING, miss, texture, self.db.profile[tcolor])
			elseif info.victim == ParserLib_SELF then
				self:DisplayEvent(INCOMING, miss, texture, self.db.profile["PMISS"])
			end
		else
			if (self:GetTargetUnit(info.victim) == "pet" and self.db.profile["PET"] == true) then
				self:DisplayEvent(INCOMING, miss, texture, self.db.profile["PETI"])
			end
		end
	elseif info.type == "environment" then
		if info.victim == ParserLib_SELF then
			self:DisplayEvent(INCOMING, "-"..text, texture, self:SpellColor(self.db.profile["PSPELL"], info.element))
		end
	elseif info.type == "gain" then
		if (info.victim == ParserLib_SELF) then
			if (info.attribute == "health") then
				if (text < self.db.profile["HFILTER"]) then return end; 
				self:DisplayEvent(INCOMING, "+"..text, texture, self.db.profile["PHEAL"])
			else
				if (self.db.profile["GAIN"] == true) then
					if (text < self.db.profile["MFILTER"]) then return end; 
					self:DisplayEvent(INCOMING, text.." "..info.attribute, texture, self.db.profile["PGAIN"])
				end
			end
		elseif self:GetTargetUnit(info.victim) == "pet" and self.db.profile["PET"] == true then
			self:DisplayEvent(INCOMING, text.." "..info.attribute, texture, self.db.profile["PETI"])
		end
	elseif info.type == "buff" then
		if (self.db.profile["BUFF"] ~= true) then return end;
		if info.victim == ParserLib_SELF then
			text = L["Buff"];
			if (info.amountRank) then text = text.." "..info.amountRank end;
			self:DisplayEvent(INCOMING, text, texture, self.db.profile["PBUFF"])
		end
	elseif info.type == "debuff" then
		if (self.db.profile["DEBUFF"] ~= true) then return end;
		if info.victim == ParserLib_SELF then
			text = L["Debuff"];
			if (info.amountRank) then text = text.." "..info.amountRank end;
			self:DisplayEvent(INCOMING, text, texture, self.db.profile["PDEBUFF"])
		end
	elseif info.type == "fade" then
		if (self.db.profile["FADE"] ~= true) then return end;
		if info.victim == ParserLib_SELF then
			text = L["Fades"];
			self:DisplayEvent(INCOMING, text, texture, self.db.profile["PBUFF"])
		end
	elseif info.type == "death" then
		if info.source == ParserLib_SELF then
			text = deathchar..info.victim..deathchar;
			self:DisplayEvent(MISC, text, texture, self.db.profile["DEATH"])
		end
	elseif info.type == "experience" then
		self:DisplayEvent(MISC, "+"..text.." ("..XP..")", texture, self.db.profile["EXPC"])
	elseif info.type == "reputation" then
		local char = "+";
		if (info.isNegative) then char = "-" end;
		self:DisplayEvent(MISC, char..text.." ("..info.faction..")", texture, self.db.profile["REPC"])
	elseif info.type == "honor" then
		self:DisplayEvent(MISC, "+"..text.." ("..HONOR..")", texture, self.db.profile["HONORC"])
	end
end

function EavesDrop:CombatPetOutEvent(info)
	local text = info.amount
	local self = EavesDrop;
	local texture
	if (info.skill and type(info.skill) ~= "number") then
		texture = BS:GetSpellIcon(info.skill);
		if (texture == nil and self.db.profile["PLACEHOLDER"] == true) then 
			texture = "Interface\\Icons\\INV_Misc_QuestionMark"
		end
	end
	if info.type == "hit" then
			if (info.isCrit) then text = critchar..text..critchar end;
			if (info.isCrushing) then text = crushchar..text..crushchar end;
			if (info.isGlancing) then text = glancechar..text..glancechar end;
			if (info.amountResist) then text = text.." ("..info.amountResist..")" end;
			if (info.amountBlock) then text = text.." ("..info.amountBlock..")" end;
			if (info.amountAbsorb) then text = text.." ("..info.amountAbsorb..")" end;
			self:DisplayEvent(OUTGOING, text, texture, self.db.profile["PETO"])
	elseif info.type == "miss" then
		local miss = getglobal(strupper(info.missType));
		self:DisplayEvent(OUTGOING, miss, texture, self.db.profile["PETO"])
	end
end

function EavesDrop:DisplayEvent(type, text, texture, color)
	local pEvent = compost:Acquire();
	if (self.db.profile["FLIP"] == true) then type = type * -1 end;
	pEvent.type = type;
	pEvent.text = text;
	pEvent.texture = texture;
	pEvent.color = color;
	if (self.db.profile["TIMESTAMP"] == true) then
		pEvent.tooltipText = string.format('|cffffffff%s|r\n%s', date('%I:%M:%S'), arg1 or '');
	else
		pEvent.tooltipText = arg1;
	end
	if (table.getn(arrEventData) >= arrMaxSize) then
		compost:Reclaim(arrEventData[1]);
		tremove(arrEventData, 1);
	end
	tinsert(arrEventData, arrMaxSize, pEvent);
	self:UpdateEvents();
end

function EavesDrop:UpdateEvents()
	local i, key, value
	local frame, text, intexture, outexture;
	local start, finish
	local delay = self.db.profile["FADETIME"] + (4 * arrSize);
	start = arrMaxSize-scroll;
	finish = arrMaxSize-arrSize+1-scroll;
	for i=start,finish,-1 do
		value = arrEventData[i];
		key = i - (arrMaxSize-arrSize) + scroll;
		frame = getglobal("EavesDropEvent"..key);
		text = getglobal("EavesDropEvent"..key.."EventText");
		intexture = getglobal("EavesDropEvent"..key.."IncomingTexture");
		outtexture = getglobal("EavesDropEvent"..key.."OutgoingTexture");
		if (not value) then
			text:SetText(nil);
			intexture:SetTexture(nil);
			outtexture:SetTexture(nil);
			frame.delay = 0;
			frame.alpha = 0;
			frame.tooltipText = nil
			frame:Hide();
		else
			if (value.type == INCOMING) then
				text:SetJustifyH("LEFT");
				text:SetWidth(self.db.profile["LINEWIDTH"]-20);
				text:SetPoint("LEFT", intexture, "RIGHT", 5, 0);
				intexture:SetTexCoord(.1,.9,.1,.9);
				intexture:SetTexture(value.texture);
				outtexture:SetTexture(nil);
			elseif (value.type == OUTGOING) then
				text:SetJustifyH("RIGHT");
				text:SetWidth(self.db.profile["LINEWIDTH"]-20);
				text:SetPoint("LEFT", intexture, "RIGHT", 5, 0);
				intexture:SetTexture(nil);
				outtexture:SetTexCoord(.1,.9,.1,.9);
				outtexture:SetTexture(value.texture);
			else
				text:SetJustifyH("CENTER");
				text:SetWidth((self.db.profile["LINEHEIGHT"] * 2) + (self.db.profile["LINEWIDTH"]-10));
				text:SetPoint("LEFT", intexture, "LEFT", 0, 0);
				intexture:SetTexture(nil);
				outtexture:SetTexture(nil);
			end
			local fontName, _, _ = text:GetFont()
			text:SetText(value.text);
			text:SetTextColor(value.color.r, value.color.g, value.color.b);
			text:SetFont(fontName, self.db.profile["TEXTSIZE"]);
			frame.delay = delay;
			frame.alpha = 1;
			if (self.db.profile["TOOLTIPS"] == true) then
				frame.tooltipText = value.tooltipText;
			else
				frame.tooltipText = nil;
			end
			frame:Show();
			frame:SetAlpha(frame.alpha);
		end
		delay = delay - 4;
		--set clickthru
		if (frame.tooltipText) then
			frame:EnableMouse(true);
		else
			frame:EnableMouse(false);
		end
	end
	--Update scrolls
	self:UpdateScrollButtons()
	--Start up onUpdate
	local _, _, run, _, _ = self:MetroStatus("EavesDrop")
	if (not run) then
		self:StartMetro("EavesDrop");
	end
end

function EavesDrop:ResetEvents()
	local i, frame, text, intexture, outexture;
	for i=1,20 do
		frame = getglobal("EavesDropEvent"..i);
		text = getglobal("EavesDropEvent"..i.."EventText");
		intexture = getglobal("EavesDropEvent"..i.."Incoming");
		outtexture = getglobal("EavesDropEvent"..i.."Outgoing");
		frame.delay = 0;
		frame.alpha = 0;
		frame.tooltipText = nil
		frame:SetHeight(self.db.profile["LINEHEIGHT"] + 1);
		frame:SetWidth((self.db.profile["LINEHEIGHT"] * 2) + self.db.profile["LINEWIDTH"]);
		frame:Hide();
		text:SetHeight(self.db.profile["LINEHEIGHT"]);
		intexture:SetHeight(self.db.profile["LINEHEIGHT"]);
		intexture:SetWidth(self.db.profile["LINEHEIGHT"]);
		intexture:SetPoint("LEFT", frame, "RIGHT", 5, 0);
		outtexture:SetHeight(self.db.profile["LINEHEIGHT"]);
		outtexture:SetWidth(self.db.profile["LINEHEIGHT"]);
	end
end

function EavesDrop:OnUpdate(elapsed)
	local frame
	local count = 0;
	for i=1,arrSize do
		frame = getglobal("EavesDropEvent"..i);
		if (frame:IsShown()) then
			count = count + 1;
			frame.delay = frame.delay - elapsed;
			if frame.delay <= 0 then
				frame.alpha = frame.alpha - .1
				frame:SetAlpha(frame.alpha);
			end
			if (frame.alpha <= 0) then
				frame:Hide();
				EavesDropFrameUpButton:Hide();
				count = count - 1;
			end
		end
	end
	if (count == arrSize) then
		allShown = true
	else
		allShown = false;
	end
	local _, _, run, _, _ = self:MetroStatus("EavesDrop")
	--if none are active, stop onUpdate;
	if ((count == 0) and (run)) then
		self:StopMetro("EavesDrop");
	end
	--hide frame when none active
	if (self.db.profile["FADEFRAME"] == true) then
		if ((count == 0) and (scroll==0) and (EavesDropFrame:GetAlpha() == 1)) then
			self:HideFrame();
		elseif (EavesDropFrame:GetAlpha() == 0) then
			self:ShowFrame();
		end
	end
end

function EavesDrop:Scroll()
  if arg1 > 0 then
    if IsShiftKeyDown() then
        self:ScrollToTop()
    else
        self:ScrollUp()
    end
  elseif arg1 < 0 then
    if IsShiftKeyDown() then
        self:ScrollToBottom()
    else
        self:ScrollDown()
    end
  end
end

function EavesDrop:ScrollToTop()
	scroll = arrMaxSize-arrSize;
	self:UpdateScrollButtons();
	self:UpdateEvents();
end

function EavesDrop:ScrollToBottom()
	scroll = 0;
	self:UpdateScrollButtons();
	self:UpdateEvents();
end

function EavesDrop:ScrollUp()
	scroll = scroll + 1;
	if (scroll > (arrMaxSize-arrSize)) then
		scroll = arrMaxSize-arrSize
	end;
	self:UpdateScrollButtons();
	self:UpdateEvents();
end

function EavesDrop:ScrollDown()
	scroll = scroll - 1;
	if (scroll < 0) then
		scroll = 0
	end;
	self:UpdateScrollButtons();
	self:UpdateEvents();
end

function EavesDrop:UpdateScrollButtons()
	if (self.db.profile["SCROLLBUTTON"] == false) then
		if (scroll > 0) then
			EavesDropFrameDownButton:Show();
			if (scroll == arrMaxSize-arrSize) then
				EavesDropFrameUpButton:Hide();
			else
			 	EavesDropFrameUpButton:Show();
			end
		else
			EavesDropFrameDownButton:Hide();
			if (not allShown) then
				EavesDropFrameUpButton:Hide();
			else
				EavesDropFrameUpButton:Show();
			end
		end
	end
end

function EavesDrop:SpellColor(option, type)
	if (self.db.profile["SPELLCOLOR"] == true) then
		return arrSpellColors[type] or option;
	else
		return option;
	end
end

local function DewDropMenu()
  dewdrop:AddLine('text', 'EavesDrop Options','isTitle', true);
	dewdrop:InjectAceOptionsTable(EavesDrop, EavesDrop.options)
	dewdrop:FeedAceOptionsTable(EavesDrop.options);
end

function EavesDrop:DropMenu()    
  dewdrop:Open(EavesDropFrame, 'children', DewDropMenu, 'cursorX', true, 'cursorY', true)
end

-------------------------
--Return the unit if for a given  target
function EavesDrop:GetTargetUnit(target)
	local unit;
	if (target == "player") then
		return "player";
	end
	if (target == UnitName('pet'))then
	  return "pet";
	end
	for i = 1, GetNumRaidMembers(), 1 do
		if ( UnitName("raid" .. i) and UnitName("raid" .. i) == target ) then
			return "raid"..i;
		end
	end
	for i = 1, GetNumPartyMembers(), 1 do
		if ( UnitName("party" .. i) and UnitName("party" .. i) == target ) then
			return "party"..i;
		end
	end
end

-------------------------
--Return the amount the target is overhealed
function EavesDrop:GetOverheal(target, damage)
	local unit = self:GetTargetUnit(target);
	if unit then
		local lost = UnitHealthMax(unit)-UnitHealth(unit);
  	local overheal = damage - lost;
  	if (overheal > 0) then
  		damage = lost.." {"..overheal.."}";
  	end
  end
  return damage;
end
