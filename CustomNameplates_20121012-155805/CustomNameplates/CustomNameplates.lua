local showPets = false;
local Enabled = true; 

local Players = {};
local Targets = {};
local Icons = {
	["Druid"] = "Interface\\AddOns\\CustomNameplates\\Class\\ClassIcon_Druid",
	["Hunter"] = "Interface\\AddOns\\CustomNameplates\\Class\\ClassIcon_Hunter",
	["Mage"] = "Interface\\AddOns\\CustomNameplates\\Class\\ClassIcon_Mage",
	["Paladin"] = "Interface\\AddOns\\CustomNameplates\\Class\\ClassIcon_Paladin",
	["Priest"] = "Interface\\AddOns\\CustomNameplates\\Class\\ClassIcon_Priest",
	["Rogue"] = "Interface\\AddOns\\CustomNameplates\\Class\\ClassIcon_Rogue",
	["Shaman"] = "Interface\\AddOns\\CustomNameplates\\Class\\ClassIcon_Shaman",
	["Warlock"] = "Interface\\AddOns\\CustomNameplates\\Class\\ClassIcon_Warlock",
	["Warrior"] = "Interface\\AddOns\\CustomNameplates\\Class\\ClassIcon_Warrior",
}

if Healers == nil then
	Healers = {};
end

local function IsNamePlateFrame(frame)
 local overlayRegion = frame:GetRegions()
  if not overlayRegion or overlayRegion:GetObjectType() ~= "Texture" or overlayRegion:GetTexture() ~= "Interface\\Tooltips\\Nameplate-Border" then
    return false
  end
  return true
end

function table.contains(table, element)
	if table ~= nil then
		for _, value in pairs(table) do
			if value == element then
				return true
			end
		end
	end
	return false
end

local function isPet(name)
	PetsRU = {"Рыжая полосатая кошка", "Серебристая полосатая кошка", "Бомбейская кошка", "Корниш-рекс",
	"Ястребиная сова", "Большая рогатая сова", "Макао", "Сенегальский попугай", "Черная королевская змейка",
	"Бурая змейка", "Багровая змейка", "Луговая собачка", "Тараканище", "Анконская курица", "Щенок ворга",
	"Паучок Дымной Паутины", "Механическая курица", "Птенец летучего хамелеона", "Зеленокрылый ара", "Гиацинтовый ара",
	"Маленький темный дракончик", "Маленький изумрудный дракончик", "Маленький багровый дракончик", "Сиамская кошка",
	"Пещерная крыса без сознания", "Механическая белка", "Крошечная ходячая бомба", "Крошка Дымок", "Механическая жаба",
	"Заяц-беляк"};
	for _, petName in pairs(PetsRU) do
		if name == petName then
			return true; 
		end
	end
	PetsENG = {"Orange Tabby", "Silver Tabby", "Bombay", "Cornish Rex", "Hawk Owl", "Great Horned Owl",
	"Cockatiel", "Senegal", "Black Kingsnake", "Brown Snake", "Crimson Snake", "Prairie Dog", "Cockroach",
	"Ancona Chicken", "Worg Pup", "Smolderweb Hatchling", "Mechanical Chicken", "Sprite Darter", "Green Wing Macaw",
	"Hyacinth Macaw", "Tiny Black Whelpling", "Tiny Emerald Whelpling", "Tiny Crimson Whelpling", "Siamese",
	"Unconscious Dig Rat", "Mechanical Squirrel", "Pet Bombling", "Lil' Smokey", "Lifelike Mechanical Toad"}
	for _, petName in pairs(PetsENG) do
		if name == petName then
			return true; 
		end
	end
	return false;
end

local function fillPlayerDB(name)
	if Targets[name] == nil then
		TargetByName(name, true);
		table.insert(Targets, name);
		Targets[name] = "ok"
		if UnitIsPlayer("target") then
			local class = UnitClass("target");
			table.insert(Players, name)
			Players[name] = {["class"] = class};
		end		
	end
end

function CustomNameplates_OnUpdate()

	local frames = { WorldFrame:GetChildren() };
	for _, namePlate in ipairs(frames) do
		if IsNamePlateFrame(namePlate) then

			local HealthBar = namePlate:GetChildren();

			if namePlate:GetAlpha() < 0.5 then
				namePlate:SetAlpha(0.3);
				HealthBar:SetAlpha(0.3);
			else
				HealthBar:SetAlpha(0.85);
			end


			local Border, Glow, Name, Level,Skull = namePlate:GetRegions();
			Skull:SetPoint("LEFT", HealthBar, "RIGHT", 13, -1);

			HealthBar:SetStatusBarTexture("Interface\\AddOns\\CustomNameplates\\barSmall");
			HealthBar:ClearAllPoints();
			HealthBar:SetPoint("CENTER", namePlate, "CENTER", 0, -10);
			HealthBar:SetWidth(80);
			HealthBar:SetHeight(4);
			-- 

			if HealthBar.bg == nil then
				HealthBar.bg = HealthBar:CreateTexture(nil, "BORDER")
				HealthBar.bg:SetTexture(0,0,0,0.85)
				HealthBar.bg:ClearAllPoints();
				HealthBar.bg:SetPoint("CENTER", namePlate, "CENTER", 0, -10);
				HealthBar.bg:SetWidth(HealthBar:GetWidth() + 1.5);
				HealthBar.bg:SetHeight(HealthBar:GetHeight() + 1.5);
			end

			if namePlate.classIcon == nil then
				namePlate.classIcon = namePlate:CreateTexture(nil, "BORDER")
				namePlate.classIcon:SetTexture(0,0,0,0)
				namePlate.classIcon:ClearAllPoints();
				namePlate.classIcon:SetPoint("RIGHT", HealthBar, "LEFT", -3, -4);
				namePlate.classIcon:SetWidth(12);
				namePlate.classIcon:SetHeight(12);
			end		

			if namePlate.classIconBorder == nil then
				namePlate.classIconBorder = namePlate:CreateTexture(nil, "BACKGROUND")
				namePlate.classIconBorder:SetTexture(0,0,0,0.9)
				namePlate.classIconBorder:SetPoint("CENTER", namePlate.classIcon, "CENTER", 0, 0);
				namePlate.classIconBorder:SetWidth(13.5);
				namePlate.classIconBorder:SetHeight(13.5);
			end

			if namePlate.medicIcon == nil then
				namePlate.medicIcon = namePlate:CreateTexture(nil, "BACKGROUND")
				namePlate.medicIcon:SetTexture("Interface\\AddOns\\CustomNameplates\\medic");
				namePlate.medicIcon:SetTexCoord(.078, .92, .079, .937);
				namePlate.medicIcon:SetPoint("CENTER", Name, "CENTER", 0, 20);
				namePlate.medicIcon:SetWidth(24);
				namePlate.medicIcon:SetHeight(24);
				namePlate.medicIcon:Hide();
			end			

			namePlate.classIconBorder:Hide();
			-- namePlate.classIconBorder:SetTexture(0,0,0,0)
			namePlate.classIcon:SetTexture(0,0,0,0);
			Border:Hide();
			Glow:Hide();

			local r, g, b, a = Name:GetTextColor();
			Name:SetFontObject(GameFontNormal);
			Name:SetTextColor(r, g, b, a);
			Name:SetFont("Interface\\AddOns\\CustomNameplates\\Fonts\\Ubuntu-C.ttf",13);
			Name:SetPoint("BOTTOM", namePlate, "CENTER", 0, -5);
			
			-- TextStatusBarText:SetShadowOffset(1, 1)
			local r, g, b, a = Level:GetTextColor();
			Level:SetFontObject(GameFontNormal);
			Level:SetTextColor(r, g, b, a);
			Level:SetFont("Interface\\AddOns\\CustomNameplates\\Fonts\\Helvetica_Neue_LT_Com_77_Bold_Condensed.ttf",11); --
			Level:SetPoint("LEFT", HealthBar, "RIGHT", 2, 0);

			HealthBar:Show();
			Name:Show();
			Level:Show();

			if showPets ~= true then
				if isPet(Name:GetText()) then
					HealthBar:Hide();
					Name:Hide();
					Level:Hide();
				end
			end

			local red, green, blue, _ = Name:GetTextColor()
			-- Print(red.." "..green.." "..blue)
			if red > 0.99 and green == 0 and blue == 0 then
				Name:SetTextColor(1,0.4,0.2,0.85);
			elseif red > 0.99 and green > 0.81 and green < 0.82 and blue == 0 then
				Name:SetTextColor(1,1,1,0.85);
			end

			local red, green, blue, _ = HealthBar:GetStatusBarColor()
			if blue > 0.99 and red == 0 and green == 0 then
				HealthBar:SetStatusBarColor(0.2,0.6,1,0.85);
			elseif red == 0 and green > 0.99 and blue == 0 then
				HealthBar:SetStatusBarColor(0.6,1,0,0.85);
			end

			local red, green, blue, _ = Level:GetTextColor()
			
			if red > 0.99 and green == 0 and blue == 0 then
				Level:SetTextColor(1,0.4,0.2,0.85);
			elseif red > 0.99 and green > 0.81 and green < 0.82 and blue == 0 then
				Level:SetTextColor(1,1,1,0.85);
			end

			local name = Name:GetText();
			if  Players[name] == nil and UnitName("target") == nil and string.find(name, "%s") == nil and string.len(name) <= 12 and Targets[name] == nil then
				fillPlayerDB(name);
				ClearTarget();
			end

			if  Players[name] ~= nil and namePlate.classIcon:GetTexture() == "Solid Texture" and string.find(namePlate.classIcon:GetTexture(), "Interface") == nil then
				namePlate.classIcon:SetTexture(Icons[Players[name]["class"]]);
				namePlate.classIcon:SetTexCoord(.078, .92, .079, .937)
				namePlate.classIcon:SetAlpha(0.9);
				namePlate.classIconBorder:Show();
			end
			
			if Healers[name] == true then
				namePlate.medicIcon:Show();
			else
				namePlate.medicIcon:Hide();
			end 
		end
	end  
end

local f = CreateFrame("frame");
-- f:RegisterEvent("PLAYER_ENTERING_WORLD");
f:SetScript("OnEvent", function()
	if (Enabled) then
		ShowNameplates();
		ShowFriendNameplates();
	else
		HideNameplates();
		HideFriendNameplates();
	end
end)
f:SetScript("OnUpdate",CustomNameplates_OnUpdate)

SLASH_NAMEPLATES1 = '/np';
function nameplatesHandler(msg, editbox)
 if msg == 'add' then
 	if Healers[UnitName("target")] == nil then
 		table.insert (Healers, 1, UnitName("target"));
 	end
 		Healers[UnitName("target")] = true;
 elseif msg == 'del' then
 	if Healers[UnitName("target")] ~= nil then
 		Healers[UnitName("target")] = false;
 	end
 elseif msg ~= nil and string.len(msg) > 0 then
 	-- and UnitName("target") ~= nil then
 	-- Print(string.len(msg));
 	-- Print("msg ~= nil")
 	if Healers[msg] == nil then
 		table.insert (Healers, 1, msg);
 	end
 		Healers[msg] = true;
 elseif UnitName("target") ~= nil then
  	if Healers[UnitName("target")] == nil then
 		table.insert (Healers, 1, UnitName("target"));
 		Healers[UnitName("target")] = true;	
 	elseif Healers[UnitName("target")] == true then
 		Healers[UnitName("target")] = false
 	elseif Healers[UnitName("target")] == false then
 		Healers[UnitName("target")] = true;
 	end
 end
end
SlashCmdList["NAMEPLATES"] = nameplatesHandler; -- Also a valid assignment strategy