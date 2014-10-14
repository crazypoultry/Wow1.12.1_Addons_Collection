--[[

	SimpleBagStats v1.5: shows simple stats about your bags

	- includes coloring, individual bags
	
	by phreak

	credits go to: Nevir (for his hsb_to_rgb function)

]]

SimpleBagStats_enabled = 1;
SimpleBagStats_individual = 1;
SimpleBagStats_colored = 1;

SimpleBagStats_color_low_hue    = 0;
SimpleBagStats_color_high_hue   = 120;
SimpleBagStats_color_saturation = 100;
SimpleBagStats_color_brightness = 75;

hsb_to_rgb_table = {};
hsb_to_rgb_table[0] = {"max", "+",   "min"};
hsb_to_rgb_table[1] = {"-",   "max", "min"};
hsb_to_rgb_table[2] = {"min", "max", "+"};
hsb_to_rgb_table[3] = {"min", "-",   "max"};
hsb_to_rgb_table[4] = {"+",   "min", "max"};
hsb_to_rgb_table[5] = {"max", "min", "-"};

color_storage = {};

function SimpleBagStats_OnLoad()
	this:RegisterEvent("VARIABLES_LOADED");
  this:RegisterEvent("BAG_UPDATE");
	this:RegisterEvent("UNIT_MODEL_CHANGED");
	this:RegisterEvent("UNIT_INVENTORY_CHANGED");
    SLASH_SBS1 = "/sbs";
    SLASH_SBS2 = "/simplebagstats";
    SlashCmdList["SBS"] = function(msg)
        SBS_CommandHandler(msg);
    end	
  SBS_ChatPrint("SimpleBagStats loaded");
end

function SBS_ChatPrint(str)
	if ( DEFAULT_CHAT_FRAME ) then 
		DEFAULT_CHAT_FRAME:AddMessage(str, 1.0, 0.5, 0.25);
	end
end

function SBS_CommandHandler(command)
  local i,j, cmd, param = string.find(command, "^([^ ]+) (.+)$");
	if (not cmd) then cmd = command; end
	if (not cmd) then cmd = ""; end
	if (not param) then param = ""; end

	if (cmd == "enable" ) then
		SimpleBagStats_enable();
	elseif (cmd == "color" ) then
		SimpleBagStats_color();
	elseif (cmd == "individual" ) then
		SimpleBagStats_individualize();
	else
		SBS_ChatPrint(SIMPLEBAGSTATS_TEXT_USAGE);
		SBS_ChatPrint("  |cffffffff/sbs enable - "..SIMPLEBAGSTATS_TEXT_ENABLE_INFO);
		SBS_ChatPrint("  |cffffffff/sbs color - "..SIMPLEBAGSTATS_TEXT_COLOR_INFO);
		SBS_ChatPrint("  |cffffffff/sbs individual - "..SIMPLEBAGSTATS_TEXT_INDIVIDUAL_INFO);
	end
end

function SBS_settext(bag,bagtext)
	if (SBS_IsAmmoPouch(SBS_slot[bag][2]) or SBS_IsShardBag(SBS_slot[bag][2]) or SBS_IsProfBag(SBS_slot[bag][2])) then
		if (bag == 0) then
			SimpleBagStatsBag0TextAlt:SetText(bagtext);
		elseif (bag == 1) then
			SimpleBagStatsBag1TextAlt:SetText(bagtext);
		elseif (bag == 2) then
			SimpleBagStatsBag2TextAlt:SetText(bagtext);
		elseif (bag == 3) then
			SimpleBagStatsBag3TextAlt:SetText(bagtext);
		elseif (bag == 4) then
			SimpleBagStatsBag4TextAlt:SetText(bagtext);
		end		
	else
		if (bag == 0) then
			SimpleBagStatsBag0Text:SetText(bagtext);
		elseif (bag == 1) then
			SimpleBagStatsBag1Text:SetText(bagtext);
		elseif (bag == 2) then
			SimpleBagStatsBag2Text:SetText(bagtext);
		elseif (bag == 3) then
			SimpleBagStatsBag3Text:SetText(bagtext);
		elseif (bag == 4) then
			SimpleBagStatsBag4Text:SetText(bagtext);
		end
	end
end

function SBS_settextcolor(bag,enabled,total,ratio)
	if (enabled == 1) then
		saturation = SimpleBagStats_color_saturation;
		brightness = SimpleBagStats_color_brightness;
		
		if (total == 1) then
			SimpleBagStats_bagratio = ratio;
		else
			SimpleBagStats_bagratio = (SBS_slot[bag][0] / SBS_slot[bag][1]);	
		end
		hue=(SimpleBagStats_color_high_hue - math.floor(SimpleBagStats_bagratio*SimpleBagStats_color_high_hue));
		
		
		if (SBS_IsAmmoPouch(SBS_slot[bag][2]) or SBS_IsShardBag(SBS_slot[bag][2]) or SBS_IsProfBag(SBS_slot[bag][2])) then
			if (bag == 0) then
				SimpleBagStatsBag0TextAlt:SetTextColor(hsb_to_rgb(hue, saturation, brightness));
			elseif (bag == 1) then
				SimpleBagStatsBag1TextAlt:SetTextColor(hsb_to_rgb(hue, saturation, brightness));
			elseif (bag == 2) then
				SimpleBagStatsBag2TextAlt:SetTextColor(hsb_to_rgb(hue, saturation, brightness));
			elseif (bag == 3) then
				SimpleBagStatsBag3TextAlt:SetTextColor(hsb_to_rgb(hue, saturation, brightness));
			elseif (bag == 4) then
				SimpleBagStatsBag4TextAlt:SetTextColor(hsb_to_rgb(hue, saturation, brightness));
			end		
		else
			if (bag == 0) then
				SimpleBagStatsBag0Text:SetTextColor(hsb_to_rgb(hue, saturation, brightness));
			elseif (bag == 1) then
				SimpleBagStatsBag1Text:SetTextColor(hsb_to_rgb(hue, saturation, brightness));
			elseif (bag == 2) then
				SimpleBagStatsBag2Text:SetTextColor(hsb_to_rgb(hue, saturation, brightness));
			elseif (bag == 3) then
				SimpleBagStatsBag3Text:SetTextColor(hsb_to_rgb(hue, saturation, brightness));
			elseif (bag == 4) then
				SimpleBagStatsBag4Text:SetTextColor(hsb_to_rgb(hue, saturation, brightness));
			end
		end
	else
		if (SBS_IsAmmoPouch(SBS_slot[bag][2]) or SBS_IsShardBag(SBS_slot[bag][2]) or SBS_IsProfBag(SBS_slot[bag][2])) then
			if (bag == 0) then
				SimpleBagStatsBag0TextAlt:SetTextColor(1,1,1);
			elseif (bag == 1) then
				SimpleBagStatsBag1TextAlt:SetTextColor(1,1,1);
			elseif (bag == 2) then
				SimpleBagStatsBag2TextAlt:SetTextColor(1,1,1);
			elseif (bag == 3) then
				SimpleBagStatsBag3TextAlt:SetTextColor(1,1,1);
			elseif (bag == 4) then
				SimpleBagStatsBag4TextAlt:SetTextColor(1,1,1);
			end		
		else
			if (bag == 0) then
				SimpleBagStatsBag0Text:SetTextColor(1,1,1);
			elseif (bag == 1) then
				SimpleBagStatsBag1Text:SetTextColor(1,1,1);
			elseif (bag == 2) then
				SimpleBagStatsBag2Text:SetTextColor(1,1,1);
			elseif (bag == 3) then
				SimpleBagStatsBag3Text:SetTextColor(1,1,1);
			elseif (bag == 4) then
				SimpleBagStatsBag4Text:SetTextColor(1,1,1);
			end
		end
	end
end

function SBS_unset()
	SimpleBagStatsBag0Text:SetText("");
	SimpleBagStatsBag1Text:SetText("");
	SimpleBagStatsBag2Text:SetText("");
	SimpleBagStatsBag3Text:SetText("");
	SimpleBagStatsBag4Text:SetText("");
	SimpleBagStatsBag0TextAlt:SetText("");
	SimpleBagStatsBag1TextAlt:SetText("");
	SimpleBagStatsBag2TextAlt:SetText("");
	SimpleBagStatsBag3TextAlt:SetText("");
	SimpleBagStatsBag4TextAlt:SetText("");
	
	SBS_slot = {};
	SBS_slot[0] = {};
	SBS_slot[0][0] = 0;
	SBS_slot[0][1] = 0;
	SBS_slot[0][2] = "";
	SBS_slot[1] = {};
	SBS_slot[1][0] = 0;
	SBS_slot[1][1] = 0;
	SBS_slot[1][2] = "";
	SBS_slot[2] = {};
	SBS_slot[2][0] = 0;
	SBS_slot[2][1] = 0;
	SBS_slot[2][2] = "";
	SBS_slot[3] = {};
	SBS_slot[3][0] = 0;
	SBS_slot[3][1] = 0;
	SBS_slot[3][2] = "";
	SBS_slot[4] = {};
	SBS_slot[4][0] = 0;
	SBS_slot[4][1] = 0;
	SBS_slot[4][2] = "";
end

function SimpleBagStats_Update()
	local SBS_totalSlots = 0;
	local SBS_totalUsedSlots = 0;
	local SBS_numSlots = 0;
	local SimpleBagStats_bagratio = 0;
	
	SBS_unset();
	
	for bag = 0, 4, 1 do
		SBS_numSlots = GetContainerNumSlots(bag);
		if (SBS_numSlots ~= 0) then
			SBS_totalSlots = SBS_totalSlots + SBS_numSlots;
				for slot = 1, SBS_numSlots, 1 do
					if (GetContainerItemInfo(bag, slot)) then
						SBS_slot[bag][0]=SBS_slot[bag][0]+1;
						SBS_totalUsedSlots = SBS_totalUsedSlots + 1;
					end
					SBS_slot[bag][1]=SBS_numSlots;
					SBS_slot[bag][2]=GetBagName(bag);
				end
		end
	end
	
	if (SimpleBagStats_enabled == 1) then
		if (SimpleBagStats_individual == 1) then
			
			for bag = 0, 4, 1 do
				if (SBS_slot[bag][1] ~= 0) then
					SBS_settext(bag,SBS_slot[bag][0].."/"..SBS_slot[bag][1]);
					if (SimpleBagStats_colored == 1) then
						SBS_settextcolor(bag,1,0,0);
					else
						SBS_settextcolor(bag,0,0,0);
					end
				else
					SBS_settext(bag,"");
				end
			end
		else
			if (SBS_totalSlots ~= 0)  then
				SBS_settext(0,SBS_totalUsedSlots.."/"..SBS_totalSlots);
				SimpleBagStats_bagratio =  (SBS_totalUsedSlots / SBS_totalSlots);
				if (SimpleBagStats_colored == 1) then
					SBS_settextcolor(0,1,1,SimpleBagStats_bagratio);
				else
					SBS_settextcolor(0,0,1,SimpleBagStats_bagratio);
				end
			end
		end
	else
		SBS_unset();
	end
end

function SimpleBagStats_enable()	
		if (SimpleBagStats_enabled == 0) then
			SimpleBagStats_enabled = 1;
			SBS_ChatPrint("SimpleBagStats enabled.");
		else
			SimpleBagStats_enabled = 0;
			SBS_ChatPrint("SimpleBagStats disabled.");
		end
		SimpleBagStats_Update();
end

function SimpleBagStats_individualize()
		if (SimpleBagStats_individual == 0) then
			SimpleBagStats_individual = 1;
			SBS_ChatPrint("SimpleBagStats individual.");
		else
			SimpleBagStats_individual = 0;
			SBS_ChatPrint("SimpleBagStats total.");
		end
		SimpleBagStats_Update();
end

function SimpleBagStats_color()
		if (SimpleBagStats_colored == 0) then
			SimpleBagStats_colored = 1;
			SBS_ChatPrint("SimpleBagStats colored.");
		else
			SimpleBagStats_colored = 0;
			SBS_ChatPrint("SimpleBagStats uncolored.");
		end
		SimpleBagStats_Update();
end

function SimpleBagStats_OnEvent(event)
	if (not event) then return; end;
	
  if ((event == "BAG_UPDATE") 
	or (event == "UNIT_MODEL_CHANGED")
	or (event == "UNIT_INVENTORY_CHANGED")
	or (event == "VARIABLES_LOADED")
	) then
     SimpleBagStats_Update();
  end
end

function hsb_to_rgb(hue, saturation, brightness)
	local index, min, max, rgb;

	hue = math.mod(hue, 360);
	index = math.floor(hue / 60);

	min = (brightness / 100) * ((100 - saturation) / 100);
	max = (brightness / 100);

	for color = 1, 3, 1 do
		if (hsb_to_rgb_table[index][color] == "min") then
			color_storage[color] = min;
		elseif (hsb_to_rgb_table[index][color] == "max") then
			color_storage[color] = max;
		elseif (hsb_to_rgb_table[index][color] == "+") then
			color_storage[color] = min + (math.mod(hue, 60) / 60) * (max - min);
		else
			color_storage[color] = max - (math.mod(hue, 60) / 60) * (max - min);
		end
	end

	return color_storage[1], color_storage[2], color_storage[3];
end

function SBS_IsAmmoPouch(name)	
	if (name) then
		for index, value in SBS_BAG_AMMO do
			if (string.find(name, value)) then
				return true;
			end
		end
	end
	return false;
end

function SBS_IsShardBag(name)	
	if (name) then
		for index, value in SBS_BAG_SHARDS do
			if (string.find(name, value)) then
				return true;
			end
		end
	end
	return false;
end

function SBS_IsProfBag(name)	
	if (name) then
		for index, value in SBS_BAG_PROFS do
			if (string.find(name, value)) then
				return true;
			end
		end
	end
	return false;
end