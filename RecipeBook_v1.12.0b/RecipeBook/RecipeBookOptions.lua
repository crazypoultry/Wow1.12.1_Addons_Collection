--== RecipeBookOptions.lua ==--
-- Contains functions necessary for the RecipeBook Options Frame

RECIPEBOOKOPTIONS_SUBFRAMES = { "RecipeBookOptions_GeneralFrame", "RecipeBookOptions_CollectionFrame", "RecipeBookOptions_SharingFrame", "RecipeBookOptions_AuctionFrame"};

function RecipeBook_OptionsFrame_OnLoad()
	UIPanelWindows["RecipeBook_OptionsFrame"] = {area = "center", pushable = 0};
	tinsert(UISpecialFrames, "RecipeBook_OptionsFrame");
	PanelTemplates_SetNumTabs(this, 4);
	RecipeBook_OptionsFrame.selectedTab = 1;
	PanelTemplates_UpdateTabs(this);
end

local CurrentOptions = {};

function RecipeBookOptions_ShowOptionsFrame()
		if(RecipeBook_OptionsFrame:IsVisible()) then
			RecipeBook_OptionsFrame:Hide();
		else
			RecipeBook_OptionsFrame:Show();
		end
end

function RecipeBookOptionsFrame_ShowSubFrame(frameName)
	for index, value in RECIPEBOOKOPTIONS_SUBFRAMES do
		if ( value == frameName ) then
			getglobal(value):Show()
		else
			getglobal(value):Hide();
		end	
	end 
end

function RecipeBook_OptionsFrame_OnShow()
	CurrentOptions = RecipeBookOptions_GetOption("all");
	RecipeBook_OptionsFrame_OnUpdate();
	PlaySound("igMainMenuOpen");
end


function RecipeBook_OptionsFrame_OnUpdate()
	if ( RecipeBook_OptionsFrame.selectedTab == 1 ) then -- General Tab
		RecipeBook_OptionsFrame_TitleText:SetText(RECIPEBOOK_CONFIG_HEADER_GENERAL);
		RecipeBookOptionsFrame_ShowSubFrame("RecipeBookOptions_GeneralFrame");
	elseif ( RecipeBook_OptionsFrame.selectedTab == 2 ) then -- Banking Tab
		RecipeBook_OptionsFrame_TitleText:SetText(RECIPEBOOK_CONFIG_HEADER_COLLECTION);
		RecipeBookOptionsFrame_ShowSubFrame("RecipeBookOptions_CollectionFrame");
	elseif ( RecipeBook_OptionsFrame.selectedTab == 3 ) then -- Sharing Tab
		RecipeBook_OptionsFrame_TitleText:SetText(RECIPEBOOK_CONFIG_HEADER_SHARE);
		RecipeBookOptionsFrame_ShowSubFrame("RecipeBookOptions_SharingFrame");
	elseif ( RecipeBook_OptionsFrame.selectedTab == 4 ) then -- Auction Tab
		RecipeBook_OptionsFrame_TitleText:SetText(RECIPEBOOK_CONFIG_HEADER_AUCTION);
		RecipeBookOptionsFrame_ShowSubFrame("RecipeBookOptions_AuctionFrame");
	end
end

function RecipeBook_OptionsFrame_OnHide()
	PlaySound("igMainMenuClose");
	RecipeBook_BagsOnOff(RecipeBookOptions_GetOption("AutoBags") and "On" or "Off");
	for index, value in RECIPEBOOKOPTIONS_SUBFRAMES do
		getglobal(value):Hide();
	end
end

----------------------------=== [ RecipeBook Config ] ==-----------------------------------

function RecipeBookOptions_RevertOptions()
	CurrentOptions = RECIPEBOOK_DEFAULT_OPTIONS;
end

function RecipeBookOptions_NewDefaultOptions()
	RecipeBookData["Default Options"] = CurrentOptions;
	RecipeBookOptions = {};
end

function RecipeBookOptions_CommitOptions()
	RecipeBookOptions_UpdateOptions(CurrentOptions);
	RecipeBook_BagsOnOff(RecipeBookOptions_GetOption("AutoBags") and "On" or "Off");
	RecipeBook_TrackingOnOff(RecipeBookOptions_GetOption("TrackSelf") and "On" or "Off");
end

function RecipeBookOptions_CheckboxClick(button, checked)
	CurrentOptions[button] = checked;
end

-- function RecipeBookOptions_DD_OnShow(name)
-- 	DEFAULT_CHAT_FRAME:AddMessage("OnLoad: "..name);
-- 	UIDropDownMenu_Initialize(this:GetParent(), RecipeBookOptions_DD_Initialize);
-- 	UIDropDownMenu_SetButtonWidth(60);
-- 	UIDropDownMenu_SetWidth(80);
-- 	if string.find(name, "Friend") then 
-- 		UIDropDownMenu_SetSelectedID(this, RecipeBook_OptionsFrame_GetReceiveOption("friend"));
-- 	elseif string.find(name, "Guild") then
-- 		UIDropDownMenu_SetSelectedID(RecipeBookOptions_DD_GuildShare, RecipeBook_OptionsFrame_GetReceiveOption("guild"));
-- 		if not IsInGuild() then OptionsFrame_DisableDropDown(RecipeBookOptions_DD_GuildShare) end;
-- 	elseif string.find(name, "Other") then
-- 		UIDropDownMenu_SetSelectedID(RecipeBookOptions_DD_OtherShare, RecipeBook_OptionsFrame_GetReceiveOption("other"));
-- 	end
-- end

-- function RecipeBookOptions_DD_OnClick()
-- 	UIDropDownMenu_SetSelectedID(this:GetParent(), this:GetID());
-- 	--Alter basedon GetName if it works.
-- 	CurrentOptions["Receive"] = string.gsub(RecipeBookOptions_GetOption("Receive"), "(f%u)", ("f"..RECIPEBOOK_CONFIG_DD_SHARE[this:GetID()].name));

-- end

-- function RecipeBookOptions_DD_Initialize()
-- 	--name = (this:GetParent()):GetName();
-- 	name = "RecipeBookOptions_DD_FriendShare";
-- 	DEFAULT_CHAT_FRAME:AddMessage("Initialize: "..name);
-- 	local info;
-- 	for i=1, table.getn(RECIPEBOOK_CONFIG_DD_SHARE), 1 do
-- 		info = {};
-- 		info.text = RECIPEBOOK_CONFIG_DD_SHARE[i].text;
-- 		info.func = name.."OnClick";
-- 		UIDropDownMenu_AddButton(info);
-- 	end
-- end

function RecipeBookOptions_DD_FriendShare_OnLoad()
	UIDropDownMenu_Initialize(this, RecipeBookOptions_DD_FriendShare_Initialize);
	UIDropDownMenu_SetButtonWidth(60);
	UIDropDownMenu_SetWidth(80);
	UIDropDownMenu_SetSelectedID(RecipeBookOptions_DD_FriendShare, RecipeBook_OptionsFrame_GetReceiveOption("friend"));
end
function RecipeBookOptions_DD_FriendShare_Initialize()
	local info;
	for i=1, table.getn(RECIPEBOOK_CONFIG_DD_SHARE), 1 do
		info = {};
		info.text = RECIPEBOOK_CONFIG_DD_SHARE[i].text;
		info.func = RecipeBookOptions_DD_FriendShare_OnClick;
		UIDropDownMenu_AddButton(info);
	end
end
function RecipeBookOptions_DD_FriendShare_OnClick()
	UIDropDownMenu_SetSelectedID(RecipeBookOptions_DD_FriendShare, this:GetID());
	CurrentOptions["Receive"] = string.gsub(RecipeBookOptions_GetOption("Receive"), "(f%u)", ("f"..RECIPEBOOK_CONFIG_DD_SHARE[this:GetID()].name));
end

function RecipeBookOptions_DD_GuildShare_OnLoad(frame)
	UIDropDownMenu_Initialize(this, RecipeBookOptions_DD_GuildShare_Initialize);
	UIDropDownMenu_SetButtonWidth(60);
	UIDropDownMenu_SetWidth(80);
	UIDropDownMenu_SetSelectedID(RecipeBookOptions_DD_GuildShare, RecipeBook_OptionsFrame_GetReceiveOption("guild"));
	if not IsInGuild() then OptionsFrame_DisableDropDown(RecipeBookOptions_DD_GuildShare) end;
end
function RecipeBookOptions_DD_GuildShare_Initialize()
	local info;
	for i=1, table.getn(RECIPEBOOK_CONFIG_DD_SHARE), 1 do
		info = {};
		info.text = RECIPEBOOK_CONFIG_DD_SHARE[i].text;
		info.func = RecipeBookOptions_DD_GuildShare_OnClick;
		UIDropDownMenu_AddButton(info);
	end
end
function RecipeBookOptions_DD_GuildShare_OnClick()
	UIDropDownMenu_SetSelectedID(RecipeBookOptions_DD_GuildShare, this:GetID());
	CurrentOptions["Receive"] = string.gsub(RecipeBookOptions_GetOption("Receive"), "(g%u)", ("g"..RECIPEBOOK_CONFIG_DD_SHARE[this:GetID()].name));
end

function RecipeBookOptions_DD_OtherShare_OnLoad(frame)
	UIDropDownMenu_Initialize(this, RecipeBookOptions_DD_OtherShare_Initialize);
	UIDropDownMenu_SetButtonWidth(60);
	UIDropDownMenu_SetWidth(80);
	UIDropDownMenu_SetSelectedID(RecipeBookOptions_DD_OtherShare, RecipeBook_OptionsFrame_GetReceiveOption("other"));
end
function RecipeBookOptions_DD_OtherShare_Initialize()
	local info;
	for i=1, table.getn(RECIPEBOOK_CONFIG_DD_SHARE), 1 do
		info = {};
		info.text = RECIPEBOOK_CONFIG_DD_SHARE[i].text;
		info.func = RecipeBookOptions_DD_OtherShare_OnClick;
		UIDropDownMenu_AddButton(info);
	end
end
local function RecipeBookOptions_DD_OtherShare_OnClick()
	UIDropDownMenu_SetSelectedID(RecipeBookOptions_DD_OtherShare, this:GetID());
	CurrentOptions["Receive"] = string.gsub(RecipeBookOptions_GetOption("Receive"), "(o%u)", ("o"..RECIPEBOOK_CONFIG_DD_SHARE[this:GetID()].name));
end

function RecipeBook_OptionsFrame_GetReceiveOption(id)
	if id == "friend" then id = 2;
	elseif id == "guild" then id = 4;
	else id = 6;
	end
	local curroption = string.sub(RecipeBookOptions_GetOption("Receive"), id, id);
	if curroption == "A" then return 1; --curroption = RECIPEBOOK_CONFIG_TEXT_SHARE[1];
	elseif curroption == "D" then return 2; --curroption = RECIPEBOOK_CONFIG_TEXT_SHARE[2];
	else return 3; --curroption = RECIPEBOOK_CONFIG_TEXT_SHARE[3];
	end
end

--== [ OPTIONS MODIFICATION FUNCTIONS ]==--
--[ UpdateOptions(options to set) : Updates the whole set of options at once. NOT idiot-proof.]--
function RecipeBookOptions_UpdateOptions(newoptions)
	if(newoptions ~= nil) then 
		table.foreach(newoptions, RecipeBookOptions_SetOption);
	end
end
--[ GetOption(option) : Returns the value of a given option; default if no value ]--
function RecipeBookOptions_GetOption(option, suboption)
	if(option == "all") then 
		local options = {};
		table.foreach(RECIPEBOOK_DEFAULT_OPTIONS, function(a,b) options[a] = RecipeBookOptions_GetOption(a) end);
		return options;
	elseif RECIPEBOOK_DEFAULT_OPTIONS[option] ~= nil then 
		if suboption ~= nil then
			if RECIPEBOOK_DEFAULT_OPTIONS[option][suboption] ~= nil then
				if RecipeBookOptions[option] ~= nil and RecipeBookOptions[option][suboption] ~= nil then
					option = RecipeBookOptions[option][suboption];
				else
					option = RecipeBookOptions_GetDefaultOption(option, suboption);
				end
				if option == "On" then 
					return true;
				elseif option == "Off" then 
					return false;
				else 
					return option;
				end
			else
				return nil;
			end
		else
			if RecipeBookOptions[option] ~= nil then
				option = RecipeBookOptions[option];
			else
				option = RecipeBookOptions_GetDefaultOption(option);
			end
			if option == "On" then 
				return true;
			elseif option == "Off" then 
				return false;
			else 
				return option;
			end
		end
	else
		return nil;
	end
end

--[ GetDefaultOption(option) : Returns the default value of a given option, taking into account any custom defaults. ]--
function RecipeBookOptions_GetDefaultOption(option, suboption)
	if (RecipeBookData["Default Options"] ~= nil) and (RecipeBookData["Default Options"][option] ~= nil) then 
		if suboption ~= nil then 
			if RecipeBookData["Default Options"][option][suboption] ~= nil then 
				return RecipeBookData["Default Options"][option][suboption];
			else
				return RECIPEBOOK_DEFAULT_OPTIONS[option][suboption];
			end
		else
			return RecipeBookData["Default Options"][option];
		end
	else
		if suboption ~= nil then
			return RECIPEBOOK_DEFAULT_OPTIONS[option][suboption];
		else
			return RECIPEBOOK_DEFAULT_OPTIONS[option];
		end
	end
end


--[ SetOption(option) : Sets the value of a given option.  Nil to reset to default. ]--
function RecipeBookOptions_SetOption(option, value)
	if ((type(option) == "string") and (RECIPEBOOK_DEFAULT_OPTIONS[option] ~= nil)) then
		if (value ~= nil) then 
			RecipeBookOptions[option] = value;
		else
			RecipeBookOptions[option] = nil;
		end
	elseif (type(option) == "table") then
		option, suboption = unpack(option);
		if value ~= nil then 
			if RecipeBookOptions[option] == nil then RecipeBookOptions[option] = {} end;
			RecipeBookOptions[option][suboption] = value;
		else
			if RecipeBookOptions[option] ~= nil then 
				RecipeBookOptions[option][suboption] = nil;
			end
		end
	end
end
--[ SetDefaultOptions() : Resets options, 'cause you may need it. ]--
function RecipeBookOptions_SetDefaultOptions()
	RecipeBookOptions = {};
end


function RecipeBookOptions_ColorOptionText()
	RecipeBookOptions_FS_ColorAltsCanLearn:SetVertexColor(unpack(RecipeBookOptions_GetOption("AuctionColors", "AltsCanLearn")));
	RecipeBookOptions_FS_ColorAltsWillLearn:SetVertexColor(unpack(RecipeBookOptions_GetOption("AuctionColors", "AltsWillLearn")));
	RecipeBookOptions_FS_ColorYouWillLearn:SetVertexColor(unpack(RecipeBookOptions_GetOption("AuctionColors", "YouWillLearn")));
	RecipeBookOptions_FS_ColorNoAltsCanLearn:SetVertexColor(unpack(RecipeBookOptions_GetOption("AuctionColors", "NoAltsCanLearn")));
	RecipeBookOptions_FS_ColorAllAltsKnow:SetVertexColor(unpack(RecipeBookOptions_GetOption("AuctionColors", "AllAltsKnow")));
end


-- -- For future use --
-- function RecipeBookOptions_OpenColorPicker(button)
-- 	ColorPickerFrame:SetColorRGB(unpack(RECIPEBOOK_DEFAULT_OPTIONS["KnownColor"]));
-- end


-- function RecipeBookOptions_SetRGB(option)
-- 	local r,g,b = ColorPickerFrame:GetColorRGB();
-- 	RecipeBookOptions_SetOption(option, r,g,b)
-- end

-- function RecipeBookOptions_SetHex(option)
-- 	local r,g,b = ColorPickerFrame:GetColorRGB();
-- 	RecipeBookOptions_SetOption(option, RecipeBookOptions_RGBHex(r,g,b))
-- end

-- --===================== Utility Functions =====================-----------
-- --RGBHex(r,g,b,a): Credit to MonkeyLibrary for the code basis.
-- function RecipeBookOptions_RGBHex(r,g,b,a)
-- 	if not a then a = 1 end;
-- 	a = floor(a * 255);
-- 	r = floor(r * 255);
-- 	g = floor(g * 255);
-- 	b = floor(b * 255);
-- 	
-- 	return format("|c%2x%2x%2x%2x", a, r, g, b);

-- end

-- --HexRGB(hex color)
-- function RecipeBookOptions_HexRGB(color)
-- 	local a,r,b,g;
-- 	a = tonumber(string.sub(color, 3,4), 16) /255;
-- 	r = tonumber(string.sub(color, 5,6), 16) /255;
-- 	g = tonumber(string.sub(color, 7,8), 16) /255;
-- 	b = tonumber(string.sub(color, 9,10), 16) /255;
-- 	return r,g,b,a;
-- end

