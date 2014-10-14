RicoDev_Properties = {
  {label = "Strata", func = "GetFrameStrata"},
  {label = "Level", func = "GetFrameLevel"},
  {label = "Visible", func = "IsVisible"},
  {label = "Shown", func = "IsShown"},
}

function RicoDev_OnLoad()
  RicoDev_MainFrame:Hide();
	SLASH_RicoDev1 = "/RicoDev";
	SLASH_RicoDev2 = "/rdev";
	SlashCmdList["RicoDev"] = RicoDev_Slash;
end

function RicoDev_MainFrame_OnUpdate()
	local obj = GetMouseFocus();
	local frame_obj = RicoDev_MainFrame;
	local text_obj = RicoDev_MainFrame_Text;
	local text = "";
	if (obj) then
		local i = 0;
		repeat
			text = text..RicoDev_GetFrameProperties(obj).."\n";
			obj = obj:GetParent();
			i = i + 1;
			if (i > 10) then
				break;
			end
		until obj == nil;
		frame_obj:SetWidth(text_obj:GetWidth() + 32);
		frame_obj:SetHeight(text_obj:GetHeight() + 32);
	end
	text_obj:SetText(text);
end

function RicoDev_GetFrameProperties(obj)
	local text = "";
	local x1, y1, x2, y2;
	if (obj and obj:GetName()) then
		text = text.."|cff00ccff"..obj:GetName().."|r\n";
		for _, prop in ipairs(RicoDev_Properties) do
			local label, func = prop.label, prop.func;
			if obj[func] then
				local value = obj[func](obj);
				if (value) then
					text = text.."|cffffcc00"..label.."|r |cffffffff"..value.."|r\n";
				end
			end
		end
		if ( obj:GetLeft() ) then
			x1, y1, x2, y2 = obj:GetLeft(), obj:GetTop(), obj:GetRight(), obj:GetBottom();
			x1 = math.max(math.floor(x1), math.floor(x1 + 0.5));
			y1 = math.max(math.floor(y1), math.floor(y1 + 0.5));
			x2 = math.max(math.floor(x2), math.floor(x2 + 0.5));
			y2 = math.max(math.floor(y2), math.floor(y2 + 0.5));
			text = text.."|cffffcc00Coords|r |cffffffff ("..x1..", "..y1..")-("..x2..", "..y2..")|r\n";
		end
	end
	return text;
end

function RicoDev_Slash(arg1)
	if(arg1 == "show") then
		RicoDev_MainFrame:Show();
	elseif(arg1 == "hide") then
		RicoDev_MainFrame:Hide();
	else
		DEFAULT_CHAT_FRAME:AddMessage("RicoDev commands:\n  RicoDev show\n  RicoDev hide");
	end

end
