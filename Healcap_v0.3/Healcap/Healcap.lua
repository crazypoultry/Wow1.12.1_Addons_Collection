HealcapHeals = {};
local dirtyWho = {};
HealcapData = {
	HealcapTotals = {},
	HealedTotal = 1,
	inPartyHeals = 0,
	outPartyHeals = 0
};
HealcapScale = 1.0;

HealcapActiveDetails = nil;
HealcapActiveHeal = nil;

local playerHealth = 0;
local barHeight = 20;
local barWidth = 180;

--[[ Toggle the display frame on and off. ]]--
function HealcapToggle()
	if HealcapFrame:IsVisible() then
		HealcapFrame:Hide();
	else
		HealcapFrame:Show();
	end
end

function HCfadeRedGreen(steps, totalSteps)
	local rc = {r = 1, g = 0, b = 0};
	local yc = {r = 1, g = 1, b = 0};
	local gc = {r = 0, g = 1, b = 0};
	
	local color = {r = 0, g = 0, b = 0};
	local progress = 1;
	if totalSteps > 0 then
		progress = steps/totalSteps;
	end
		
	if progress < 0.5 then
		color.r = 1;
		color.g = progress * 2;
	elseif progress == 0.5 then
		color.r = 1;
		color.g = 1;
	else
		color.r = 1-((progress-0.5) * 2);
		color.g = 1;
	end
	return color;
end

--[[ Shouldn't ever be needed, but why not? ]]--
local function RecalulateTotals()
	HealcapData["HealcapTotals"] = {};
	for person, x in HealcapHeals do
		HealcapData["HealcapTotals"][person] = tabulateHealsFor(person);
	end
	HealcapData["HealedTotal"] = tabulateHeals();	
end

--[[ Get total healing done by one person. ]]--
local function tabulateHealsFor(name)
	local total = 0;
	for effect, amount in HealcapHeals[name] do
		for i, amt in amount do
			total = total + amt;
		end
	end
	return total;
end

function HealcapReport(type, param)
	local channel = ChatFrameEditBox.chatType;
	local chatnumber = nil
	
	if channel=="WHISPER" then
		chatnumber = ChatFrameEditBox.tellTarget
	elseif channel=="CHANNEL" then
		chatnumber = ChatFrameEditBox.channelTarget
	end

	prln = SendChatMessage;
	if type == "OVERALL" then
		prln("__ Healcap Healing Report __", channel, nil, chatnumber);
		local ipPercent = math.floor(HealcapData["inPartyHeals"]/HealcapData["HealedTotal"] * 1000) / 10;
		local opPercent = math.floor(HealcapData["outPartyHeals"]/HealcapData["HealedTotal"] * 1000) / 10;
		
		prln("Healing from party: " .. ipPercent .. "%", channel, nil, chatnumber);
		prln("Healing not from party: " .. opPercent .. "%", channel, nil, chatnumber);
		prln("_____________________________", channel, nil, chatnumber);
		local i = 0;
		local keyTable = {};
		for n,v in pairs(HealcapData["HealcapTotals"]) do table.insert(keyTable, {n,v}) end
		table.sort(keyTable, function(a,b) return b[2] < a[2]; end);
		
		for index, val in keyTable do
			person = val[1];
			amount = val[2];
			prln(person .. ": " .. amount .. " (" .. (math.floor(amount/HealcapData["HealedTotal"]*1000)/10) .. "%)", channel, nil, chatnumber);
		end	
	elseif type == "SINGLEENTRY" then
		local amount = HealcapData["HealcapTotals"][param];
		prln(param .. " contributed " .. amount .. " (" .. (math.floor(amount/HealcapData["HealedTotal"]*1000)/10) .. "%) of " .. UnitName("player") .. "'s total healing.", channel, nil, chatnumber);
	elseif type == "HEALENTRY" then
		local heal = param;
		local playerName = HealcapActiveDetails;
		local t = HealcapHeals[playerName][heal];
		local total = 0;
		for idx, amt in t do
			total = total + amt;
		end
		
		local amount = HealcapData["HealcapTotals"][HealcapActiveDetails];
		prln(param .. " contributed " .. total .. " (" .. (math.floor(total/amount*1000)/10) .. "%) of " .. HealcapActiveDetails .. "'s total healing to " .. UnitName("player") .. ".", channel, nil, chatnumber);
	elseif type == "DETAILS" then
		local playerName = HealcapActiveDetails;
		local t = {};
		local healTotal = 0;
		for heal, amounts in HealcapHeals[playerName] do
			local healAmt = 0;
			for index, amount in amounts do
				healAmt = healAmt + amount;
			end
			tinsert(t, {heal, healAmt});
			healTotal = healTotal + healAmt;
		end
		table.sort(t, function(a,b) return a[2] > b[2]; end);

		prln("__ Healcap Details for " .. playerName .. " __", channel, nil, chatnumber);
		for idx, data in t do
			prln(data[1] .. ": " .. data[2] .. " (" .. (math.floor(data[2]/healTotal*1000)/10) .. "%)", channel, nil, chatnumber);
		end
	end
end

--[[ Get total healing done. ]]--
local function tabulateHeals()
	local total = 0;
	for person in HealcapHeals do
		total = total + tabulateHealsFor(person);
	end
	return total;
end

--[[ Update the visual representation of our tabulated data. ]]--
function HealcapUpdateBars()
	local percent = math.floor(HealcapData["inPartyHeals"]/HealcapData["HealedTotal"] * 1000) / 10;
	if percent == 0 then
		getglobal("HealcapBarIPBar"):Hide();
	else
		getglobal("HealcapBarIPBar"):Show();
		getglobal("HealcapBarIPBar"):SetVertexColor(0.4, 0.4, 1, 1);
		getglobal("HealcapBarIP").color = {0.4, 0.4, 1};
		getglobal("HealcapBarIPBar"):SetWidth(barWidth * (percent/100));
		if dirtyWho["INPARTY"] then
			dirtyWho["INPARTY"] = false;
			getglobal("HealcapBarIP").fadeTime = getglobal("HealcapBarIP").totalFadeTime;
		end
	end
	getglobal("HealcapBarIPText"):SetText(tostring(percent) .. "%");
	getglobal("HealcapBarIPName"):SetText(HEALCAP_FROMPARTY);

	local percent = math.floor(HealcapData["outPartyHeals"]/HealcapData["HealedTotal"] * 1000) / 10;
	if percent == 0 then
		getglobal("HealcapBarOPBar"):Hide();
	else
		getglobal("HealcapBarOPBar"):Show();
		getglobal("HealcapBarOPBar"):SetVertexColor(1, 0.5, 0.2, 1);
		getglobal("HealcapBarOP").color = {1, 0.5, 0.2};
		getglobal("HealcapBarOPBar"):SetWidth(barWidth * (percent/100));
		if dirtyWho["OUTPARTY"] then
			dirtyWho["OUTPARTY"] = false;
			getglobal("HealcapBarOP").fadeTime = getglobal("HealcapBarOP").totalFadeTime;
		end
	end
	getglobal("HealcapBarOPText"):SetText(tostring(percent) .. "%");
	getglobal("HealcapBarOPName"):SetText(HEALCAP_NOTFROMPARTY);

	local keyTable = {};
	for n,v in pairs(HealcapData["HealcapTotals"]) do table.insert(keyTable, {n,v}) end
	table.sort(keyTable, function(a,b) return b[2] < a[2]; end);
	-- table.sort(HealcapData["HealcapTotals"], function(a,b) spr("A is " .. tostring(a)); end);
	
	local size = getn(keyTable);	

	FauxScrollFrame_Update(HealcapFrameScrollFrame, size, 6, 20);
	local offset = FauxScrollFrame_GetOffset(HealcapFrameScrollFrame);
	HealcapFrameScrollFrame:Show();
	for i = 1,6 do
		if i <= size then
			local index = i + offset;
	    	
			person = keyTable[index][1];
			amount = keyTable[index][2];
			
			getglobal("HealcapBar" .. i):Show();
        	
			local percent = math.floor(amount/HealcapData["HealedTotal"] * 1000) / 10;
			getglobal("HealcapBar" .. i .. "Bar"):SetWidth(barWidth * (percent/100));
			getglobal("HealcapBar" .. i .. "Text"):SetText(amount .. " (" .. tostring(percent) .. "%)");
			getglobal("HealcapBar" .. i .. "Name"):SetText(person);
        	
			local color = HCfadeRedGreen((size-1)-(index-1), size-1);
			getglobal("HealcapBar" .. i .. "Bar"):SetVertexColor(color.r, color.g, color.b, 1);
			getglobal("HealcapBar" .. i).color = {color.r, color.g, color.b};
        	
			if dirtyWho[person] then
				dirtyWho[person] = false;
				getglobal("HealcapBar" .. i).fadeTime = getglobal("HealcapBar" .. i).totalFadeTime;
			end
		else
			getglobal("HealcapBar" .. i):Hide();
		end
	end
end

--[[ Determine if someone is in our party. ]]--
local function IsInParty(name)
	if UnitName("party1") == name or
		UnitName("party2") == name or
		UnitName("party3") == name or
		UnitName("party4") == name then
		return true;
	else
		return false;
	end
end

--[[ END LOCAL FUNCTIONS ]] --

--[[ Basic setup. ]]--
function Healcap_OnLoad()
	HealcapEvtFrame:RegisterEvent("UNIT_HEALTH");
	HealcapEvtFrame:RegisterEvent("VARIABLES_LOADED");
	
	HealcapEvtFrame:RegisterEvent("CHAT_MSG_SPELL_SELF_BUFF");						-- Self Heals
	HealcapEvtFrame:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_BUFFS");	-- Heals from others
	HealcapEvtFrame:RegisterEvent("CHAT_MSG_SPELL_FRIENDLYPLAYER_BUFF");	-- Heals from others
	HealcapEvtFrame:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS");			-- HoT Spells
	HealcapEvtFrame:RegisterEvent("CHAT_MSG_SPELL_HOSTILEPLAYER_BUFF");			-- Heals from others
	
	SlashCmdList["HEALCAP"] = Healcap_SlashHandler;
	SLASH_HEALCAP1 = "/healcap";
end

--[[ Handle /healcap slash commands. ]]--
function Healcap_SlashHandler(msg)
	local words = {};
	for word in string.gfind(msg, "%w+") do
		table.insert(words, word);
	end
	if table.getn(words) == 0 then
		HealcapToggle();
	else
		if words[1] == "reset" then
			HealcapReset();
		elseif words[1] == "scale" and table.getn(words) == 2 then
			HealcapScale = tonumber(words[2]) / 100;
			HealcapFrame:SetScale(HealcapScale);
		end
	end
end

function HealcapReset()
	HealcapHeals = {};
	local dirtyWho = {};
	HealcapActiveDetails = nil;
	HealcapActiveHeal = nil;

	HealcapData = {
		HealcapTotals = {},
		HealedTotal = 1,
		inPartyHeals = 0,
		outPartyHeals = 0
	};

	HealcapUpdateBars();
	HealcapDetailsFrame:Hide();
end

--[[ We have a new heal to us, add it into our data and update totals. ]]--
function HealcapAddHeal(who, event, amount)
	if who == nil then
		who = UnitName("player");
	end
	if HealcapHeals[who] == nil then
		HealcapHeals[who] = {};
	end
	if HealcapHeals[who][event] == nil then
		HealcapHeals[who][event] = {};
	end

	-- This ranks heals according to how critical the player's health was before the heal went off	
	-- This can tell you who is pulling your ass out of the fire, and can also be analyzed to determine where you're
	-- receiving the majority of your heals.
	
	local unitHealthPercent = math.floor(playerHealth / UnitHealthMax("player") * 100);
	local index = unitHealthPercent;
	
	--[[
	if     playerHealth < 25 then 	index = 1;
	elseif playerHealth < 50 then 	index = 2;
	elseif playerHealth < 75 then 	index = 3;
	elseif playerHealth < 95 then 	index = 4;
	else				index = 5;
	end
	]]--

	local healAmt = tonumber(amount);
	if HealcapHeals[who][event][index] == nil then
		HealcapHeals[who][event][index] = healAmt;
	else
		HealcapHeals[who][event][index] = HealcapHeals[who][event][index] + healAmt;
	end
	
	--[[
		Update our totals so we don't have to recalculate them from the individual pieces
		This should help keep performance problems down a good bit.
	]]--
	if HealcapData["HealcapTotals"][who] == nil then HealcapData["HealcapTotals"][who] = 0; end
	HealcapData["HealcapTotals"][who] = HealcapData["HealcapTotals"][who] + healAmt;
	
	if HealcapData["HealedTotal"] == 1 then
		HealcapData["HealedTotal"] = 0;
	end
	HealcapData["HealedTotal"] = HealcapData["HealedTotal"] + healAmt;

--	spr("Total is " .. HealcapData["HealcapTotals"][who] .. ", " .. HealcapData["HealedTotal"]);

	if who == UnitName("player") or IsInParty(who) then
		HealcapData["inPartyHeals"] = HealcapData["inPartyHeals"] + healAmt;
		dirtyWho["INPARTY"] = true;
	else
		HealcapData["outPartyHeals"] = HealcapData["outPartyHeals"] + healAmt;
		dirtyWho["OUTPARTY"] = true;
	end
	
	dirtyWho[who] = true;
	HealcapUpdateBars();
	
	if HealcapActiveDetails then
		HealcapPopulateDetails();
		HCSetDetailChart();
	end
end

-- This is testing stuff for the lua binary.
--[[
strs = {	
	"Your Flash Heal heals you for 1234",
	"Your Flash Heal critically heals you for 2345",
	"You gain 123 health from Heroism.",
	"You gain 234 health from Druid's Renew",
	"Priest's Greater Heal heals you for 3456",
	"Priest's Greater Heal critically heals you for 4567"
};

for i, str in strs do
	Healcap_OnEvent(nil, str);
end

for person in HealcapHeals do
	print(person .. " did " .. tabulateHealsFor(person) .. " healing");
end
print("You received " .. tabulateHeals() .. " healing");

]]--

--[[ Err...the event handler. See Healcap_OnLoad() for events registered. ]]--
function Healcap_OnEvent(evt, arg1)
	-- Generic health updates
	-- TODO: Determine if this fires before or after heal messages. May need to preserve a history of health.
	if evt == "UNIT_HEALTH" and arg1 == "player" then
		playerHealth = UnitHealth("player");
	elseif evt == "VARIABLES_LOADED" then
		playerHealth = UnitHealth("player");
		HealcapUpdateBars();
	else 
		local indexes = {
			{ 1, 2, 3},		-- Name, effect, amount
			{ 1, 2, 3},
			{ 2, 3, 1},
			{-1, 2, 1},	-- -1 = "you"
			{-1, 1, 2},
			{-1, 1, 2}
		};
		
		for i, search in HEALCAP_SEARCHES do
			local match = {};
			_, _, match[1], match[2], match[3] = string.find(arg1, search);
			match[-1] = nil;
			if match[1] ~= nil then
				HealcapAddHeal(match[indexes[i][1]], match[indexes[i][2]], match[indexes[i][3]]);
				break;
			end
		end
	end
end

--[[ Populate the details window ]]--

function HealcapPopulateDetails()
	playerName = HealcapActiveDetails;
	HealcapDetailsFrameTitle:SetText(playerName);	
	
	local t = {};
	local healTotal = 0;
	if HealcapHeals[playerName] == nil then return; end
	for heal, amounts in HealcapHeals[playerName] do
		local healAmt = 0;
		for index, amount in amounts do
			healAmt = healAmt + amount;
		end
		tinsert(t, {heal, healAmt});
		healTotal = healTotal + healAmt;
	end
	table.sort(t, function(a,b) return a[2] > b[2]; end);
	
	local size = getn(t);
	
	FauxScrollFrame_Update(HealcapDetailsFrameScrollFrame, size, 6, 20);
	local offset = FauxScrollFrame_GetOffset(HealcapDetailsFrameScrollFrame);
	
	HealcapDetailsFrameScrollFrame:Show();
	for i = 1,6 do
		local index = i + offset;
		if index <= size then
			local val = t[index];
			person = val[1];
			amount = val[2];
			getglobal("HealcapDetailsBar" .. i):Show();
    		
			local percent = math.floor(amount/healTotal * 1000) / 10;
			getglobal("HealcapDetailsBar" .. i .. "Bar"):SetWidth(barWidth * (percent/100));
			getglobal("HealcapDetailsBar" .. i .. "Text"):SetText(amount .. " (" .. tostring(percent) .. "%)");
			getglobal("HealcapDetailsBar" .. i .. "Name"):SetText(person);
    	
			local color = HCfadeRedGreen((size-1)-(index-1), size-1);
			getglobal("HealcapDetailsBar" .. i .. "Bar"):SetVertexColor(color.r, color.g, color.b, 1);
			getglobal("HealcapDetailsBar" .. i).color = {color.r, color.g, color.b};
		else
			getglobal("HealcapDetailsBar" .. i):Hide();
		end
	end
end

function HealcapShowDetails()
	HealcapDetailsFrame:Show();
end

--[[ Texture handling functions ]]--
function HCFlashTexture(sourceColor, time, totalTime)
	time = totalTime - time;
	local r = sourceColor[1];
	local g = sourceColor[2];
	local b = sourceColor[3];
	local rD = 1-r;
	local gD = 1-g;
	local bD = 1-b;
	local step = time/totalTime;
	local color = {r = 1 - (rD * step), g = 1 - (gD * step), b = 1 - (bD * step)};
	return color;
end

function HCSetDetailChart()
	local heal = HealcapActiveHeal ;
	local playerName = HealcapActiveDetails;
	if HealcapHeals[playerName] == nil then return; end
	if HealcapHeals[playerName][heal] == nil then return; end
	local t = HealcapHeals[playerName][heal];
	local total = 0;
	if t == nil then return; end
	for idx, amt in t do
		total = total + amt;
	end
	local indexes = {};
	local maxPercent = 0;
	for i = 1,20 do
		local idx = 5 * (i-1);
		local tierTotal = 0;
		for j = 1,5 do
			if t[idx+j] ~= nil then
				tierTotal = tierTotal + t[idx+j];
			end
		end
		local percent = tierTotal / total;
		indexes[i] = percent 
		if percent > maxPercent then
			maxPercent = percent;
		end
	end
	
	for i = 1,20 do
		local bar = getglobal("HealcapVertBar" .. i);
		local tex = getglobal("HealcapVertBar" .. i .. "Bar");
		newHeight = bar.maxHeight * (indexes[i] / maxPercent);
		local idx = (5 * (i-1));
		bar.tooltip = (math.floor(indexes[i] * 1000) / 10) .. "% of healing done when your health\nwas in the " .. idx .. "-" .. (idx+5) .. "% range.";
		if newHeight <= 0 then
			newHeight = 1;
		end
		tex:SetHeight(newHeight);
	end
end