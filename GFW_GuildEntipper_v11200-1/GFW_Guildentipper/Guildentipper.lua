------------------------------------------------------
-- Guildentipper.lua
-- Based on Micah's GuildOnTooltip mod, with some help from Ross' GoodTip
------------------------------------------------------
FGT_VERSION = "11200.1";
------------------------------------------------------

function FGT_OnEvent(event)
    if (event == "UPDATE_MOUSEOVER_UNIT") then
		FGT_ModifyTooltipForUnit("mouseover");
	end
end

function FGT_SetUnit(this, aUnit)
	FGT_Original_SetUnit(this, aUnit);
	FGT_ModifyTooltipForUnit(aUnit);
end

function FGT_OnHide()
	local line2orig = GameTooltipTextLeft2:GetText();
	if(line2orig ~= nil) then
		if(string.find(line2orig, "<")) then
			-- We added a line, we need to remove it or it'll show up in all future tooltips
			GameTooltipTextLeft4:SetText(nil);
			GameTooltipTextLeft4:Hide();
			GameTooltipTextLeft3:SetText(nil);
			GameTooltipTextLeft3:Hide();
		end
	end
	FGT_Original_OnHide();
end

function FGT_OnLoad()
	-- Hook the function that displays tooltips
	FGT_Original_SetUnit = GameTooltip.SetUnit; -- broken in 1.7, no replacement yet in sight...
	GameTooltip.SetUnit = FGT_SetUnit;
	FGT_Original_OnHide = GameTooltip_OnHide;
	GameTooltip_OnHide = FGT_OnHide;
	
	GFW_Guildentipper_Frame:RegisterEvent("UPDATE_MOUSEOVER_UNIT");

	GFWUtils.Print("Fizzwidget Guildentipper "..FGT_VERSION.." initialized!");
end

function FGT_ModifyTooltipForUnit(aUnit)
	if(UnitExists(aUnit) and UnitPlayerControlled(aUnit)) then
		local guildName = GetGuildInfo(aUnit);
		if(guildName) then

			local line2orig = GameTooltipTextLeft2:GetText();
			
			-- Sometimes we get called too early for the tooltip to be set up right.
			if(line2orig == nil) then return; end
			
			-- Sometimes, due to interaction with other UI mods, we get called multiple times for the same tooltip.
			-- Make sure we only modify it once.
			if(string.find(line2orig, "<")) then return; end

			if(GameTooltip:NumLines() == 3) then
				local line3orig = GameTooltipTextLeft3:GetText();
				GameTooltipTextLeft2:SetText("<"..guildName..">");
				GameTooltipTextLeft3:SetText(line2orig);
				GameTooltip:AddLine(line3orig, 1.0, 1.0, 1.0);
			else
				GameTooltipTextLeft2:SetText("<"..guildName..">");
				GameTooltip:AddLine(line2orig, 1.0, 1.0, 1.0);
			end
			
			GameTooltip:Show();
			
			if(GameTooltipTextLeft2:GetWidth() + 26 > GameTooltip:GetWidth()) then 
				GameTooltip:SetWidth(GameTooltipTextLeft2:GetWidth() + 26); 
			end
		end
	end
end

------------------------------------------------------
-- Runtime loading
------------------------------------------------------

FGT_OnLoad();

