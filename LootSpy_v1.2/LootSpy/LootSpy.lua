-- LootSpy 1.2
-- Tehl of Defias Brotherhood(EU)
-- Props to Yrys (Author of ChatLink) for wading through the nightmare that is Regex, mine is lifted directly from his addon.

LootSpy_ChatFrameEvent = ChatFrame_OnEvent;

LootSpySession = {}

function LootSpy_Init()
	DEFAULT_CHAT_FRAME:AddMessage("LootSpy 1.2 loaded :: /ls for usage");
		
	for i = 1,5 do
		getglobal("LootSpy_LootButton"..i):Hide();
		getglobal("LootSpy_CompactLootButton"..i):Hide();
	end
	
	if not (LootSpy_Saved) then
		LootSpy_Saved = {
			["on"] = true,
			["locked"] = true,
			["hideSpam"] = false,
			["coordX"] = LootSpy_LootButton1:GetLeft(),
			["coordY"] = LootSpy_LootButton1:GetTop(),
		};
	end
	
	if not (LootSpy_Saved["fade"]) then
		LootSpy_Saved["fade"] = 5;
	end
	
	if not (LootSpy_Saved["compact"]) then
		LootSpy_Saved["compact"] = 0;
	end
	
	LootSpySession = {};
	
	LootSpy_LootButton1:ClearAllPoints();
	LootSpy_LootButton1:SetPoint("TOPLEFT","UIParent","BOTTOMLEFT",LootSpy_Saved["coordX"],LootSpy_Saved["coordY"]);
	LootSpy_CompactLootButton1:ClearAllPoints();
	LootSpy_CompactLootButton1:SetPoint("TOPLEFT","UIParent","BOTTOMLEFT",LootSpy_Saved["coordX"],LootSpy_Saved["coordY"]);
	
	SLASH_LOOTSPY1 = "/lootspy";
	SLASH_LOOTSPY2 = "/ls";
	SlashCmdList["LOOTSPY"] = LootSpy_Slash;
end

function LootSpy_Slash(arg)
	if (arg == "toggle") then
		if (LootSpy_Saved["on"] == true) then
			LootSpy_Saved["on"] = false;
			for i = 1,5 do
				getglobal("LootSpy_LootButton"..i):Hide();
			end
			DEFAULT_CHAT_FRAME:AddMessage(LS_DISABLED);
		else
			LootSpy_Saved["on"] = true;
			LootSpy_UpdateTable();
			DEFAULT_CHAT_FRAME:AddMessage(LS_ENABLED);
		end
	elseif (arg == "locked") then
		if (LootSpy_Saved["locked"] == true) then
			LootSpy_Saved["locked"] = false;
			for i = 1,5 do
				local buttonName = "nil";
				if (LootSpy_Saved["compact"] == true) then
					buttonName = "LootSpy_CompactLootButton";
				else
					buttonName = "LootSpy_LootButton";
				end
				getglobal(buttonName..i):Show();
			end
			DEFAULT_CHAT_FRAME:AddMessage(LS_UNLOCKED);
		else
			LootSpy_Saved["locked"] = true;
			LootSpy_UpdateTable();
			DEFAULT_CHAT_FRAME:AddMessage(LS_LOCKED);
		end
	elseif (arg == "spam") then
		if (LootSpy_Saved["hideSpam"] == true) then
			LootSpy_Saved["hideSpam"] = false;
			DEFAULT_CHAT_FRAME:AddMessage(LS_SPAMOFF);
		else
			LootSpy_Saved["hideSpam"] = true;
			DEFAULT_CHAT_FRAME:AddMessage(LS_SPAMON);
		end
	elseif (arg == "compact") then
		if (LootSpy_Saved["compact"] == true) then
			LootSpy_Saved["compact"] = false;
			DEFAULT_CHAT_FRAME:AddMessage(LS_COMPACTOFF);
			LootSpy_UpdateTable();
		else
			LootSpy_Saved["compact"] = true;
			DEFAULT_CHAT_FRAME:AddMessage(LS_COMPACTON);
			LootSpy_UpdateTable();
		end
	elseif (string.sub(arg,1,4) == "fade") then
		local fadeTime = tonumber(string.sub(arg,5));
		if (fadeTime >= 0) then
			LootSpy_Saved["fade"] = fadeTime;
			DEFAULT_CHAT_FRAME:AddMessage(LS_NEWFADE..fadeTime);
		else
			DEFAULT_CHAT_FRAME:AddMessage(LS_FADEWRONG);
		end
	else
		DEFAULT_CHAT_FRAME:AddMessage("LootSpy 1.0");
		DEFAULT_CHAT_FRAME:AddMessage("--By Tehl of Defias Brotherhood(EU)");
		DEFAULT_CHAT_FRAME:AddMessage("--Usage:");
		DEFAULT_CHAT_FRAME:AddMessage(" /ls toggle");
		DEFAULT_CHAT_FRAME:AddMessage(" /ls locked");
		DEFAULT_CHAT_FRAME:AddMessage(" /ls spam");
		DEFAULT_CHAT_FRAME:AddMessage(" /ls fade [0|time]");
		DEFAULT_CHAT_FRAME:AddMessage(" /ls compact");
	end
end

function LootSpy_OnEvent()
	if (event == "VARIABLES_LOADED") then
		LootSpy_Init();
	end
end

function LootSpy_OnUpdate()
	local i = 1;
	for item in LootSpySession do
		if (LootSpySession[item]["timeWon"] > 0) and (LootSpy_Saved["fade"] > 0) then
			local alpha = 1 - (GetTime() - LootSpySession[item]["timeWon"] - LootSpy_Saved["fade"] + 1);
			if (alpha > 0) then
				local buttonName = "nil";
				if (LootSpy_Saved["compact"] == true) then
					buttonName = "LootSpy_CompactLootButton";
				else
					buttonName = "LootSpy_LootButton";
				end
				getglobal(buttonName..i):SetAlpha(alpha);
			else
				LootSpy_Remove(i);
			end
		end
		i = i + 1;
		if (i > 5) then
			return;
		end
	end
end
function LootSpy_UpdateTable()
	for i = 1,5 do
		getglobal("LootSpy_LootButton"..i):SetAlpha(1);
		getglobal("LootSpy_LootButton"..i):Hide();
		getglobal("LootSpy_CompactLootButton"..i):SetAlpha(1);
		getglobal("LootSpy_CompactLootButton"..i):Hide();
	end
	local i = 1;
	for item in LootSpySession do
		local buttonName = "nil";
		if (LootSpy_Saved["compact"] == true) then
			buttonName = "LootSpy_CompactLootButton";
		else
			buttonName = "LootSpy_LootButton";
		end
		getglobal(buttonName..i):Show();
		if (LootSpy_Saved["compact"] == true) then
			getglobal(buttonName..i.."Text"):SetText("N:"..LootSpySession[item]["need"].." G:"..LootSpySession[item]["greed"].." P:"..LootSpySession[item]["passed"]);
		else
			getglobal(buttonName..i.."NeedText"):SetText(LS_NEED..": "..LootSpySession[item]["need"]);
			getglobal(buttonName..i.."GreedText"):SetText(LS_GREED..": "..LootSpySession[item]["greed"]);
			getglobal(buttonName..i.."PassedText"):SetText(LS_PASSED..": "..LootSpySession[item]["passed"]);
		end
		-- 1.12
		local itemLink = string.gsub(item, "|c(%x+)|Hitem:(%d-):(%d-):(%d-):(%d-)|h%[([^%]]-)%]|h|r", "%2");
		-- 2.0.1
		--local itemLink = string.gsub(item, "|c(%x+)|Hitem:(%d-):(%d-):(%d-):(%d-):(%d-):(%d-):(%d-):(%d-)|h%[([^%]]-)%]|h|r", "%2");
		local _, _, _, _, _, _, _, _, itemTexture = GetItemInfo(itemLink);
		if (itemTexture) then
			getglobal(buttonName..i.."ItemIcon"):SetTexture(itemTexture);
		end
		i = i + 1;
		if (i > 5) then
			return;
		end
	end
end

function LootSpy_Tooltip(id)
	GameTooltip:SetOwner(this,"ANCHOR_CURSOR");
	local name = "nil";
	for item in LootSpySession do
		id = id - 1;
		if (id == 0) then
			name = item;
		end
	end
	GameTooltip:SetText(name);
	GameTooltip:AddLine(LS_NEEDERS);
	for player in LootSpySession[name]["needNames"] do
		GameTooltip:AddLine(LootSpySession[name]["needNames"][player]);
	end
	GameTooltip:Show();
end

function LootSpy_ItemTooltip(id)
	GameTooltip:SetOwner(this,"ANCHOR_CURSOR");
	local itemLink = "nil";
	for item in LootSpySession do
		id = id - 1;
		if (id == 0) then
			-- 1.12
			itemLink = string.gsub(item, "|c(%x+)|Hitem:(%d-):(%d-):(%d-):(%d-)|h%[([^%]]-)%]|h|r", "%2");
			-- 2.0.1
			--itemLink = string.gsub(item, "|c(%x+)|Hitem:(%d-):(%d-):(%d-):(%d-):(%d-):(%d-):(%d-):(%d-)|h%[([^%]]-)%]|h|r", "%2");
		end
	end
	GameTooltip:ClearLines();
	GameTooltip:SetHyperlink("item:"..itemLink..":0:0:0");
	GameTooltip:Show();
end

function LootSpy_Remove(id)
	local name = "nil";
	for item in LootSpySession do
		id = id - 1;
		if (id == 0) then
			name = item;
		end
	end
	for data in LootSpySession[name]["needNames"] do
		LootSpySession[name]["needNames"][data] = nil;
	end
	for data in LootSpySession[name] do
		LootSpySession[name][data] = nil;
	end
	LootSpySession[name] = nil;
	LootSpy_UpdateTable();
end

function LootSpy_UpdatePosition()
	local buttonName = "nil";
	if (LootSpy_Saved["compact"] == true) then
		buttonName = "LootSpy_CompactLootButton";
	else
		buttonName = "LootSpy_LootButton";
	end
	LootSpy_Saved["coordX"] = getglobal(buttonName.."1"):GetLeft();
	LootSpy_Saved["coordY"] = getglobal(buttonName.."1"):GetTop();
		LootSpy_LootButton1:ClearAllPoints();
	LootSpy_LootButton1:SetPoint("TOPLEFT","UIParent","BOTTOMLEFT",LootSpy_Saved["coordX"],LootSpy_Saved["coordY"]);
	LootSpy_CompactLootButton1:ClearAllPoints();
	LootSpy_CompactLootButton1:SetPoint("TOPLEFT","UIParent","BOTTOMLEFT",LootSpy_Saved["coordX"],LootSpy_Saved["coordY"]);
end

function LootSpy_IsALootMessage(arg)
	if (arg) then
		if (strfind(arg,LS_NEEDSTRING) or strfind(arg,LS_GREEDSTRING) or strfind(arg,LS_PASSEDSTRING)) or strfind(arg,LS_ITEMWON1) or strfind(arg,LS_ITEMWON2) then
			return true;
		end
	end
	return false;
end

function LootSpy_GetLootData(arg)
		arg = string.gsub(arg," has selected ",":");
		arg = string.gsub(arg," have selected ",":");
		arg = string.gsub(arg," has won: ",":|");
		arg = string.gsub(arg," won: ",":|");
		arg = string.gsub(arg," for: ","|");
		arg = string.gsub(arg," has ",":");
		arg = string.gsub(arg," have ",":");
		arg = string.gsub(arg," on: ","|");
		arg = string.gsub(arg,"You",UnitName("player"));
		local playerName = string.sub(arg,1,strfind(arg,":")-1);
		local itemName = string.sub(arg,strfind(arg,"|")+1,string.len(arg));
		local rollType = string.sub(arg,strfind(arg,":")+1,strfind(arg,"|")-1);
		return itemName,playerName,rollType;
end

function ChatFrame_OnEvent(event)
	if (LootSpy_Saved["on"] == true) and (LootSpy_IsALootMessage(arg1)) then
		local itemName,playerName,rollType = LootSpy_GetLootData(arg1);
		if (strfind(arg1,LS_ALLPASSED)) then
			LootSpySession[itemName]["timeWon"] = GetTime();
			LootSpy_ChatFrameEvent(event);
			return;
		end
		if (strfind(arg1,LS_ITEMWON1) or strfind(arg1,LS_ITEMWON2)) then
			LootSpySession[itemName]["timeWon"] = GetTime();
			LootSpy_ChatFrameEvent(event);
			return;
		end
		if not (LootSpySession[itemName]) then
			LootSpySession[itemName] = {
				["need"] = 0,
				["needNames"] = {},
				["greed"] = 0,
				["passed"] = 0,
				["timeWon"] = 0
			};
		end
		if (rollType == LS_NEED) then
			local i = 1;
			while (LootSpySession[itemName]["needNames"][i]) do
				i = i + 1;
			end
			LootSpySession[itemName]["needNames"][i] = playerName;
			LootSpySession[itemName]["need"] = LootSpySession[itemName]["need"] + 1;
		elseif (rollType == LS_GREED) then
			LootSpySession[itemName]["greed"] = LootSpySession[itemName]["greed"] + 1;
		else
			LootSpySession[itemName]["passed"] = LootSpySession[itemName]["passed"] + 1;
		end
		LootSpy_UpdateTable();
		if (LootSpy_Saved["hideSpam"] == true) then
			return;
		end
	end
	LootSpy_ChatFrameEvent(event);
end
