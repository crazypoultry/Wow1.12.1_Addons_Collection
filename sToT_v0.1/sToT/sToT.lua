Hex = { ["0"] = 0, ["1"] = 1, ["2"] = 2, ["3"] = 3, ["4"] = 4, ["5"] = 5, ["6"] = 6, ["7"] = 7, ["8"] = 8, ["9"] = 9, ["a"] = 10, ["b"] = 11, ["c"] = 12,  ["d"] = 13, ["e"] = 14, ["f"] = 15 }

function sToT_OnLoad()
	SLASH_STOT1 = "/stot";
	SLASH_STOT2 = "/simpletot";
	SlashCmdList["STOT"] = sToT_Handler;
end

function sToT_Handler(arg)
	if arg=="hide" or arg=="show" then
		if sToT:IsVisible() then
			sToT:Hide();
			sToTBuff:Hide();
		else
			sToT:Show();
			sToTBuff:Show();
		end
	end
	if arg=="" then
		DEFAULT_CHAT_FRAME:AddMessage("/stot hide - Shows/hides the frame");
		DEFAULT_CHAT_FRAME:AddMessage("Click the frame to change targets");
		DEFAULT_CHAT_FRAME:AddMessage("Hold alt to drag the frame");
	end
end

function sToT_Update()
	if UnitExists("targettarget") then
		local ToTlevel = UnitLevel("targettarget");
		local ToTname = UnitName("targettarget");
		local ToTclass, rclass = UnitClass("targettarget");
		local colorwhite = "|cffffffff";
		local colorlevel = GetDifficultyColor(ToTlevel);
		colorlevel = "|cff"..sToT_DecHex(colorlevel.r,colorlevel.g,colorlevel.b);
		local colorclass = RAID_CLASS_COLORS[rclass or ""];
		colorclass = "|cff"..sToT_DecHex(colorclass.r,colorclass.g,colorclass.b);
		ToTlevel = colorlevel..ToTlevel.." ";
		ToTname = colorwhite..ToTname.." ";
		ToTclass = "["..colorclass..ToTclass..colorwhite.."]";
		sToTText:SetText(ToTlevel..ToTname..ToTclass);
	else
		sToTText:SetText("");
	end
end

function sToT_UpdateBuff()
	for i = 1,16 do
		getglobal("sToTBuff"..i):SetTexture("");
		local buff = UnitBuff("targettarget", i);
		if buff then
			getglobal("sToTBuff"..i):SetTexture(buff);
		else
			getglobal("sToTBuff"..i):SetTexture("");
		end
		if not UnitName("targettarget") then
			getglobal("sToTBuff"..i):SetTexture("");
		end
	end
end

function sToT_UpdateBuffTooltip()
	GameTooltip:SetOwner(this, "ANCHOR_BOTTOMRIGHT");
	local getltext;
	for i = 1,16 do
		local buff = UnitBuff("targettarget", i);
		if buff then
			GameTooltip:SetUnitBuff("targettarget", i);
			local ltext = getglobal("GameTooltipTextLeft1");
			if getltext then
				getltext = getltext .. "|n" .. ltext:GetText();
			else
				getltext = ltext:GetText();
			end
			GameTooltip:SetText(getltext);
		end
	end
end

function sToT_DecHex(r,g,u)
	local a,b,c,d,e,f;
	a = sToT_GetHex(floor(floor(r*255)/16));
	b = sToT_GetHex(math.mod(floor(r*255),16));
	c = sToT_GetHex(floor(floor(g*255)/16));
	d = sToT_GetHex(math.mod(floor(g*255),16));
	e = sToT_GetHex(floor(floor(u*255)/16));
	f = sToT_GetHex(math.mod(floor(u*255),16));
	return a..b..c..d..e..f;
end

function sToT_GetHex(dec)
	for x, y in Hex do
		if dec==y then
			return x;
		end
	end
	return ""..dec;
end
