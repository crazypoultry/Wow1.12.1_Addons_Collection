-- variables used
BijouCount = 0;
CoinCount = 0;

-- output text into default chat window
function out(text)
	DEFAULT_CHAT_FRAME:AddMessage(text)
end

-- on load stuff
function ZGCount_OnLoad()
	-- events used
	this:RegisterEvent("ADDON_LOADED");
	this:RegisterEvent("BAG_UPDATE");
	this:RegisterEvent("CHAT_MSG_COMBAT_SELF_HITS");
	
	-- slash commands
	out("ZGCount loaded.  Type '/zgc' for options.");
  	SLASH_ZGCOUNT1 = "/zgc";
 	SlashCmdList["ZGCOUNT"] = function(msg)
		ZGCount_SlashCommandHandler(msg);
	end
end
 
function ZGCount_SlashCommandHandler(msg)
	if (ZGCount_Frame:IsVisible()) then
		if (msg == "hide") then
			this.isLocked = false;
     			ZGCount_Frame:Hide();
			UIErrorsFrame:AddMessage("ZGCount hidden", 0, 1, 0, 1, 1)
		end
	else
		if (msg == "show") then
			ZGCount_Frame:Show();
			UIErrorsFrame:AddMessage("ZGCount shown", 0, 1, 0, 1, 1)
		end
	end
	if (msg == "") then
		out("--ZGCount Help--");
		out("Type '/zgc show' to show the mod.");
		out("Type '/zgc hide' to hide the mod.");
	end		
end

function ZGCount_OnEvent(event)
	-- output that addon has loaded
	if ( event == "ADDON_LOADED" ) then
		UIErrorsFrame:AddMessage("ZGCount loaded.", 0, 1, 0, 1, 1)
	end

	-- on bag update check for new coins / bijous
	if (event == "BAG_UPDATE") then
		ZGCount_SearchBags();
	end
end

function ZGCount_SearchBags()
	CoinCount = 0;
	BijouCount = 0;
	for bag=0,4 do
		for slot=1,GetContainerNumSlots(bag) do
			if (GetContainerItemLink(bag,slot)) then
				if (string.find(GetContainerItemLink(bag,slot), "Coin")) then
					-- count coins
					local texture, itemCount, locked, quality, readable = GetContainerItemInfo(bag,slot);
					CoinCount = CoinCount + itemCount;
					CoinCount_Font:SetText("Coins: " .. CoinCount);
        			end
				if (string.find(GetContainerItemLink(bag,slot), "Bijou")) then
					-- count bijous
					local texture, itemCount, locked, quality, readable = GetContainerItemInfo(bag,slot);
					BijouCount = BijouCount + itemCount;
					BijouCount_Font:SetText("Bijous: " .. BijouCount);
        			end
     			end
		end
	end
end