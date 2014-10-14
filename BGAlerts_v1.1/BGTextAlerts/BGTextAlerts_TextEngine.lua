local MULTI_KILLS_SHOW = 0;

local KillSpree_Strings = { };

KillSpree_Strings[2] = "Double Kill";
KillSpree_Strings[3] = "Multi Kill";
KillSpree_Strings[4] = "Mega Kill";
KillSpree_Strings[5] = "Ultra Kill!";
KillSpree_Strings[6] = "Unstopable!!";
KillSpree_Strings[7] = "GODLIKE!!!!";

BGTextAlerts_NextKillUpdate = 10;
BGTextAlerts_TextShowRate = 0.02;
local showingText = "";
BGTextAlerts_TextToShow = "";

local KillSpree_Kills = 0;
local MAX_NUMBER_OF_KILLS = table.getn(KillSpree_Strings) + 1;
local IsHiding = false;

function BGTextAlerts_ShowText(text,color,icon)
	-- Prepare the frame to slide in the text
	UIFrameFadeRemoveFrame(BGTextAlerts_TextFrame);
	UIFrameFlashRemoveFrame(BGTextAlerts_TextFrame);
	BGTextAlerts_TextFrame:Hide();
	BGTextAlerts_TextFrame:SetAlpha(1);
	BGTextAlerts_TextToShow = text;
	BGTextAlerts_TextFrame.TimeSinceLastUpdate = 0;
	BGTextAlerts_TextSpot:SetTextColor(color.r,color.g,color.b,1);
	if (icon) then
		BGTextAlerts_IconSpot:SetTexture(icon);
		BGTextAlerts_IconSpot:Show();
	else
		BGTextAlerts_IconSpot:Hide();
	end
	if (BGTextAlerts_AnimatedText == 1) then
		-- Animated
		BGTextAlerts_TextSpot:SetText(string.sub(text,1,1));
		showingText = string.sub(text,1,1);
		UIFrameFlash(BGTextAlerts_TextFrame,0,1.2,string.len(text) * BGTextAlerts_TextShowRate + 4.2,false,0.0,3.0 + string.len(text) * BGTextAlerts_TextShowRate);
	else
		-- Not animated
		BGTextAlerts_TextSpot:SetText(text);
		showingText = text;
		BGTextAlerts_TextSpot:SetWidth(BGTextAlerts_TextSpot:GetStringWidth());
		UIFrameFlash(BGTextAlerts_TextFrame,0,1.2,4.2,false,0.0,3.0);
	end
end

function BGTextAlerts_UpdateText(elapsed)
	
	this.TimeSinceLastUpdate = this.TimeSinceLastUpdate + elapsed;
	
	while (this.TimeSinceLastUpdate >= BGTextAlerts_TextShowRate) do
		if (string.len(showingText) == string.len(BGTextAlerts_TextToShow)) then
			-- Text is ready
			-- Do something
			BGTextAlerts_TextSpot:SetText(BGTextAlerts_TextToShow);
		else
			-- Show another letter
			showingText = string.sub(BGTextAlerts_TextToShow,1,string.len(showingText)+1);
			BGTextAlerts_TextSpot:SetText(string.sub(showingText,1,string.len(showingText)-1) .. "|cFFFF5000" .. string.sub(showingText,string.len(showingText)) .. "|r");
			BGTextAlerts_TextSpot:SetWidth(BGTextAlerts_TextSpot:GetStringWidth());
		end
		
		this.TimeSinceLastUpdate = this.TimeSinceLastUpdate - BGTextAlerts_TextShowRate;
	end
	
	
end

function BGTextAlerts_ApplyKillBonus(killmsg)

	if (MultiKillsText ~= 1) then
		return;
	end

	if (GetRealZoneText() == "Alterac Valley") or (GetRealZoneText() == "Warsong Gulch")
	   or (GetRealZoneText() == "Arathi Basin") or (GetRealZoneText() == "Eye of the Storm")
	   or (GetRealZoneText() == "Nagrand Arena") or (GetRealZoneText() == "Blade's Edge Arena") then
		if (string.find(killmsg,"You have slain") ~= nil) then
			--BGTextAlerts_ShowKillTimer();
			-- Player slain something in BGs
			-- Reset KillBonus timer and play a kill bonus sound
			this.TimeSinceLastUpdate = 0;
			KillSpree_Kills = KillSpree_Kills + 1;
			if (KillSpree_Kills > MAX_NUMBER_OF_KILLS) then
				KillSpree_Kills = MAX_NUMBER_OF_KILLS;
			end
			if (KillSpree_Kills > 1) then
				BGTextAlerts_ShowText(KillSpree_Strings[KillSpree_Kills],NEUTRAL_COLORS);
			end				
		end
	end
end

function BGTextAlerts_UpdateKillBonus(elapsed)
	this.TimeSinceLastUpdate = this.TimeSinceLastUpdate + elapsed; 	
	while (this.TimeSinceLastUpdate > BGTextAlerts_NextKillUpdate) do
	      	this.TimeSinceLastUpdate = this.TimeSinceLastUpdate - BGTextAlerts_NextKillUpdate;
		-- Reset Kills
		KillSpree_Kills = 0;
	end
end

function BGTextAlerts_ShowKillTimer()
	local statusbar = getglobal("BGTextAlerts_MultiKillTimerStatusBar");
	statusbar:SetStatusBarColor(1,0.3,0);
	statusbar:SetMinMaxValues(0,BGTextAlerts_NextKillUpdate);
	statusbar:SetValue(BGTextAlerts_NextKillUpdate);
	getglobal("BGTextAlerts_MultiKillTimerText"):SetText("Multi Kill");
	local i = 0;
	IsHiding = false;
	for i = 1, table.getn(FADEFRAMES), 1 do
		if (FADEFRAMES[i]:GetName() == "BGTextAlerts_MultiKillTimer") then
			table.remove(FADEFRAMES,i);
		end
	end
	BGTextAlerts_MultiKillTimer:SetAlpha(1);
	statusbar:GetParent():Show();
end

function BGTextAlerts_UpdateKillTimer(elapsed)
	local statusbar = getglobal("BGTextAlerts_MultiKillTimerStatusBar");
	statusbar:SetValue((statusbar:GetValue() - 1 * elapsed));
	if (statusbar:GetValue() <= 0) and 
		(not UIFrameIsFading(statusbar:GetParent()) and (not IsHiding)) then
			UIFrameFadeOut(statusbar:GetParent(),1,1,0);
			IsHiding = true;
	end
end
