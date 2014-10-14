
NURFED_HUD_DEFAULT = {
	barfade = 0.15,
	nocombat = 1,
	nocombatalpha = 0.3,
	combatalpha = 1,
};

local utility = Nurfed_Utility:New();
local framelib = Nurfed_Frames:New();
local units = Nurfed_Units:New();

function Nurfed_Hud_Init()
	for k, v in pairs(Nurfed_HudLayout.templates) do
		framelib:CreateTemplate(k, v);
	end

	for k, v in pairs(Nurfed_HudLayout.Layout) do
		local frame = framelib:ObjectInit("Nurfed_Hud"..k, v);
		if (k == "casting") then
			CastingBarFrame:UnregisterAllEvents();
			frame:RegisterEvent("SPELLCAST_START");
			frame:RegisterEvent("SPELLCAST_STOP");
			frame:RegisterEvent("SPELLCAST_FAILED");
			frame:RegisterEvent("SPELLCAST_INTERRUPTED");
			frame:RegisterEvent("SPELLCAST_DELAYED");
			frame:RegisterEvent("SPELLCAST_CHANNEL_START");
			frame:RegisterEvent("SPELLCAST_CHANNEL_UPDATE");
			frame:RegisterEvent("SPELLCAST_CHANNEL_STOP");
			frame:SetScript("OnEvent", Nurfed_Hud_OnEvent);
			frame:SetScript("OnUpdate", Nurfed_Hud_CastingOnUpdate);
		else
			frame.unit = k;
			units:Imbue(frame);
			if (k == "player") then
				frame:RegisterEvent("PLAYER_ENTER_COMBAT");
				frame:RegisterEvent("PLAYER_LEAVE_COMBAT");
				frame:RegisterEvent("PLAYER_REGEN_DISABLED");
				frame:RegisterEvent("PLAYER_REGEN_ENABLED");
            elseif (k == "targettarget") then
                --Nurfed_Hud_InitToT(frame);
                frame:RegisterEvent("PLAYER_TARGET_CHANGED");
                frame:SetScript("OnUpdate", function() Nurfed_Hud_UpdateToT(arg1) end);
                frame:SetScript("OnEvent", Nurfed_Hud_OnEvent);
            end
		end
	end
end

function Nurfed_Hud_UpdateAlpha(combat)
	local alpha;
	if (combat) then
		alpha = utility:GetOption("hud", "combatalpha");
	else
		alpha = utility:GetOption("hud", "nocombatalpha");
	end
	for k in pairs(Nurfed_HudLayout.Layout) do
		if (k ~= "casting") then
			local frame = getglobal("Nurfed_Hud"..k);
			if (frame) then
				frame:SetAlpha(alpha);
			end
		end
	end
end

function Nurfed_Hud_UpdateDisplay()
	local nocombat = utility:GetOption("hud", "nocombat");
	for k in pairs(Nurfed_HudLayout.Layout) do
		if (k ~= "casting") then
			local frame = getglobal("Nurfed_Hud"..k);
			if (frame and not Nurfed_Hudplayer.incombat and nocombat == 1) then
				frame:Hide();
			end
		end
	end
end

function Nurfed_Hud_ShowChild(f, c, s)
    local t = getglobal(f:GetName() .. c);
    if (t and not s) then
        t:Hide();
    elseif (t and s) then
        t:Show();
    end
end

function Nurfed_Hut_InitToT(frame)
    Nurfed_Hud_ShowChild(frame, "name", false);
    Nurfed_Hud_ShowChild(frame, "hp", false);
    Nurfed_Hud_ShowChild(frame, "mp", false);            
    frame.tot = false;
end

function Nurfed_Hud_UpdateToT(elapsed)
    this.update = this.update + elapsed;
    if (this.update > 0.25) then
        if (UnitExists(this.unit)) then
            if (not this.tot) then
                Nurfed_Hud_ShowChild(this, "name", true);
                Nurfed_Hud_ShowChild(this, "hp", true);
                Nurfed_Hud_ShowChild(this, "mp", true);                            
                this.tot = true;
            end
            
            units:UpdateText(getglobal(this:GetName() .. "name"));
            units:UpdateInfo("hp", this);
            units:UpdateManaColor(this);
            units:UpdateInfo("mp", this);
            this.update = 0;
        else
            if (this.tot) then
                Nurfed_Hud_ShowChild(this, "name", false);
                Nurfed_Hud_ShowChild(this, "hp", false);
                Nurfed_Hud_ShowChild(this, "mp", false);            
                this.tot = false;
            end
        end
    end
end

function Nurfed_Hud_OnEvent()
	if (event == "SPELLCAST_START") then
		local bar = getglobal(this:GetName().."bar");
		local spell = getglobal(this:GetName().."spell");
		if (bar) then
			bar:SetVertexColor(1.0, 1.0, 0.0);
		end
		if (spell) then
			spell:SetText(arg1);
		end
		this.startTime = GetTime();
		this.maxValue = this.startTime + (arg2 / 1000);
		this:SetAlpha(1.0);
		this.holdTime = 0;
		this.casting = 1;
		this.fadeOut = nil;
		this:Show();
		this.mode = "casting";
	elseif (event == "SPELLCAST_STOP" or event == "SPELLCAST_CHANNEL_STOP") then
		if (not this:IsVisible()) then
			this:Hide();
		end
		if (this:IsShown()) then
			local bar = getglobal(this:GetName().."bar");
			bar:SetVertexColor(0.0, 1.0, 0.0);
			if (event == "SPELLCAST_STOP") then
				this.casting = nil;
			else
				this.channeling = nil;
			end
			this.flash = 1;
			this.fadeOut = 1;
			this.mode = "flash";
		end
	elseif (event == "SPELLCAST_FAILED" or event == "SPELLCAST_INTERRUPTED") then
		if (this:IsShown()) then
			local bar = getglobal(this:GetName().."bar");
			local spell = getglobal(this:GetName().."spell");
			if (bar) then
				bar:SetVertexColor(1.0, 0.0, 0.0);
			end
			if (event == "SPELLCAST_FAILED") then
				if (spell) then
					spell:SetText(FAILED);
				end
			else
				if (spell) then
					spell:SetText(INTERRUPTED);
				end
			end
			this.casting = nil;
			this.fadeOut = 1;
			this.holdTime = GetTime() + CASTING_BAR_HOLD_TIME;
		end
	elseif (event == "SPELLCAST_DELAYED") then
		if(this:IsShown()) then
			this.startTime = this.startTime + (arg1 / 1000);
			this.maxValue = this.maxValue + (arg1 / 1000);
		end
	elseif (event == "SPELLCAST_CHANNEL_START") then
		local bar = getglobal(this:GetName().."bar");
		local spell = getglobal(this:GetName().."spell");
		if (bar) then
			bar:SetVertexColor(1.0, 0.7, 0.0);
		end
		this.maxValue = 1;
		this.startTime = GetTime();
		this.endTime = this.startTime + (arg1 / 1000);
		this.duration = arg1 / 1000;
		this:SetAlpha(1.0);
		this.holdTime = 0;
		this.casting = nil;
		this.channeling = 1;
		this.fadeOut = nil;
		if (spell) then
			spell:SetText(arg2);
		end
		this:Show();
	elseif (event == "SPELLCAST_CHANNEL_UPDATE") then
		if (this:IsShown()) then
			local origDuration = this.endTime - this.startTime
			this.endTime = GetTime() + (arg1 / 1000)
			this.startTime = this.endTime - origDuration
		end
    elseif ((this.unit == "targettarget") and (event == "PLAYER_TARGET_CHANGED")) then
        if (UnitExists("target")) then
            this:Show();
        else
            this:Hide();
        end
    end
end

function Nurfed_Hud_CastingOnUpdate()
	if ( this.casting ) then
		local status = GetTime();
		if ( status > this.maxValue ) then
			status = this.maxValue
		end
		Nurfed_Hud_UpdateCasting((status - this.startTime), (this.maxValue - this.startTime));
		local cast = getglobal(this:GetName().."time");
		if (cast) then
			cast:SetText(string.format(" (%.1fs)", this.maxValue - status));
		end
	elseif ( this.channeling ) then
		local time = GetTime();
		if ( time > this.endTime ) then
			time = this.endTime
		end
		if ( time == this.endTime ) then
			this.channeling = nil;
			this.fadeOut = 1;
			return;
		end
		local barValue = this.startTime + (this.endTime - time);
		Nurfed_Hud_UpdateCasting((barValue - this.startTime), (this.endTime - this.startTime));
		local cast = getglobal(this:GetName().."time");
		if (cast) then
			cast:SetText(string.format(" (%.1fs)", this.endTime - time));
		end
	elseif (GetTime() < this.holdTime) then
		return;
	elseif (this.fadeOut) then
		local alpha = this:GetAlpha() - CASTING_BAR_ALPHA_STEP;
		if ( alpha > 0 ) then
			this:SetAlpha(alpha);
		else
			this.fadeOut = nil;
			this:Hide();
		end
	end
end

function Nurfed_Hud_UpdateCasting(curr, max)
	local texture = getglobal(this:GetName().."bar");

	local p = curr / max;
	local size = texture.bar * p;
	local p_h1;
	if (texture.fill == "top" or texture.fill == "bottom" or texture.fill == "vertical") then
		p_h1 = texture.bar / texture.height;
	else
		p_h1 = texture.bar / texture.width;
	end
	local p_h2 = 1 - p_h1;
	units:TextureCoord(texture, size, texture.fill, (1-p) * p_h1 + p_h2);
end
