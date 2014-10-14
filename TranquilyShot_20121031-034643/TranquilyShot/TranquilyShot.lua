hunters = {};
raid = {};

SLASH_TRS1 = "/trs";  
SlashCmdList["TRS"] = function(msg)
	if TranquilityShotFrame:IsShown() then
		TranquilityShotFrame:Hide();
	else
		TranquilityShotFrame:Show();
	end
end

function TranquilyShot_OnLoad()
	for index, event in TranquilyShot_watchedEventsTable do
		this:RegisterEvent(event);
	end
	UpdateTranqRoster();
	UpdateTranqFrame();
end

function test()
	for i = 1, getn(hunters) do
		-- DEFAULT_CHAT_FRAME:AddMessage(tostring(hunters[hunters[i]]["cd"]));
	end
end

function UpdateTranqRoster()

	if GetNumRaidMembers() > 0 then
		raid = {};
		hunters = {};

		for i = 1, GetNumRaidMembers() do
			local name = GetRaidRosterInfo(i);
			tinsert(raid, name);
			raid[name] = {};
		end

		for i = 1, GetNumRaidMembers() do
			local name,_,_,_,class = GetRaidRosterInfo(i);
			if class == "Hunter" then
				if not hunters[name] then
					tinsert(hunters, name);

					hunters[name] = {};
					hunters[name]["cd"] = false;
				end
			end
		end

		for i = 1, getn(hunters) do
			if raid[hunters[i]] == nil then tremove(hunters,i) end
		end 

		table.sort(hunters);
	else
		hunters = {};
		raid = {};
	end
end

function UpdateTranqFrame()
	for i = 1, 12 do
		getglobal("TranquilityShotFrameLine"..i):SetText("");
	end
	
	if GetNumRaidMembers() > 0 then
		local shots = 0;
		for i = 1, getn(hunters) do
			if hunters[hunters[i]]["cd"] == false then
				shots = shots + 1;
			end
		end

		getglobal("TranquilityShotFrameCountLine"):SetText("Shots: "..shots);

		if getn(hunters) > 0 then
			local maxH = 12;
			if getn(hunters) <= maxH then maxH = getn(hunters); end
			for i = 1, maxH do
				if hunters[hunters[i]]["cd"] == true then
					getglobal("TranquilityShotFrameLine"..i):SetText("|cffc41f3b"..hunters[i].."|r");
				else
					getglobal("TranquilityShotFrameLine"..i):SetText("|cffabd473"..hunters[i].."|r");
				end
				getglobal("TranquilityShotFrameLine"..i):SetText(i..". "..getglobal("TranquilityShotFrameLine"..i):GetText());
			end
		end
	end
end

function TranquilyShot_OnEvent()
	if event == "RAID_ROSTER_UPDATE" or event == "PARTY_MEMBERS_CHANGED" then
		UpdateTranqRoster();
		UpdateTranqFrame();
	end

	if event == "CHAT_MSG_ADDON" then
		if (arg1 == "TRNQSHOT" and (arg3 == "PARTY" or arg3 == "RAID") and (arg2 == "true" or arg2 == "false")) and (GetNumRaidMembers() > 0) then
					-- Print(arg1.." "..arg2.." "..arg3.." "..arg4);
			if not hunters[arg4] then UpdateTranqRoster(); end
			if tostring(hunters[arg4]["cd"]) ~= arg2 then
				if arg2 == "true" then hunters[arg4]["cd"] = true;
				else hunters[arg4]["cd"] = false;
				end
				UpdateTranqFrame();
			end
		end
	end
end

local cooldown = false;
local counter = 0;

function TranquilyShot_OnUpdate()
	local function CheckCD()
		i=1;
		while true do 
			local s, _ = GetSpellName(i,BOOKTYPE_SPELL); 
			if not s then do break end; 
			elseif strfind(s,"Tranquilizing Shot") then 
				local _, r, _ = GetSpellCooldown(i,BOOKTYPE_SPELL); 
				local _, r2, _ = GetSpellCooldown(i-1,BOOKTYPE_SPELL); 
				if r~=0 and r~=r2 then 
					return "true";
				else 
					return "false";
				end 
			end 
			i=i+1; 
		end
	end

	local class = UnitClass("player");
	if class == "Hunter" then
	
	local FPS = GetFramerate();
	if counter >= FPS then
		SendAddonMessage("TRNQSHOT", CheckCD(), "RAID");
		counter = 0;
	else
		counter = counter + 1;
	end
	end
end

TranquilyShot_watchedEventsTable = {
	"PARTY_MEMBERS_CHANGED",
	"RAID_ROSTER_UPDATE",
	"CHAT_MSG_ADDON",
};
