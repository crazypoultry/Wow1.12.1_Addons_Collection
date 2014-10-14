--------------------------------------------------------------------------
-- ChatIgnore.lua 
--------------------------------------------------------------------------
--[[
ChatIgnore

author: AnduinLothar    <karlkfi@cosmosui.org>

-Adds an Ignore Player option to the unit dropdown menus.

Change List
v1.0
-Initial Release
v1.1
- Fixed ignoring menu option
- Updated TOC to 11200


]]--

-- <= == == == == == == == == == == == == =>
-- => Function Definition
-- <= == == == == == == == == == == == == =>

function ChatIgnore_UnitPopup_OnClick()
	local frame = getglobal(UIDROPDOWNMENU_INIT_MENU)
	local name = frame.name;
	if (frame.server and frame.server ~= GetRealmName()) then
		name = name.."-"..frame.server;
	end
	if (this.value == "IGNORE" ) then
		ExtraMenuOptions.Ignore(name);
	elseif (this.value == "REMOVE_IGNORE" ) then
		DelIgnore(name); 
	end
end

function ChatIgnore_UnitPopup_HideButtons()
	local dropdownMenu = getglobal(UIDROPDOWNMENU_INIT_MENU);
	local dropdownFrame = getglobal(UIDROPDOWNMENU_OPEN_MENU);
	for index, value in UnitPopupMenus[dropdownFrame.which] do
		if ( UnitPopupShown[index] == 1 ) then
			if ( value == "IGNORE" ) then
				if (ChatIgnore_IsIgnored(dropdownMenu.name)) then
					UnitPopupShown[index] = 0;
				end
			elseif ( value == "REMOVE_IGNORE" ) then
				if (not ChatIgnore_IsIgnored(dropdownMenu.name)) then
					UnitPopupShown[index] = 0;
				end
			end
		end
	end
end

function ChatIgnore_IsIgnored(name)
	local numIgnores = GetNumIgnores();
	for i=1, numIgnores do
		if (name == GetIgnoreName(i)) then
			return true;
		end
	end
end

function ChatIgnore_Ignore(name)
	ChatIgnore_IgnoreName = name;
	StaticPopup_Show("ADD_IGNORE");
end

function ChatIgnore_StaticPopup_Ignore_OnShow()
	if (ChatIgnore_IgnoreName) then
		getglobal(this:GetName().."EditBox"):SetText(ChatIgnore_IgnoreName);
	end
end

-- <= == == == == == == == == == == == == =>
-- => Execution
-- <= == == == == == == == == == == == == =>

if (Sea) then
	Sea.util.hook("UnitPopup_OnClick", "ChatIgnore_UnitPopup_OnClick", "after");
	Sea.util.hook("UnitPopup_HideButtons", "ChatIgnore_UnitPopup_HideButtons", "after");
	Sea.util.hook("StaticPopupDialogs.ADD_IGNORE.OnShow", "ChatIgnore_StaticPopup_Ignore_OnShow", "after");
else
	ChatIgnore_UnitPopup_OnClick_orig = UnitPopup_OnClick;
	UnitPopup_OnClick = function() ChatIgnore_UnitPopup_OnClick_orig(); ChatIgnore_UnitPopup_OnClick(); end;
	
	ChatIgnore_UnitPopup_HideButtons_orig = UnitPopup_HideButtons;
	UnitPopup_HideButtons = function() ChatIgnore_UnitPopup_HideButtons_orig(); ChatIgnore_UnitPopup_HideButtons(); end;
	
	ChatIgnore_StaticPopupDialogs_ADD_IGNORE_OnShow_orig = StaticPopupDialogs.ADD_IGNORE.OnShow;
	StaticPopupDialogs.ADD_IGNORE.OnShow = function(data) ChatIgnore_StaticPopupDialogs_ADD_IGNORE_OnShow_orig(data); ChatIgnore_StaticPopup_Ignore_OnShow(data); end;
end
UnitPopupButtons["IGNORE"] = { text = CHATIGNORE_UNIT_MENU_TEXT, dist = 0 };
UnitPopupButtons["REMOVE_IGNORE"] = { text = CHATIGNORE_REMOVE_UNIT_MENU_TEXT, dist = 0 };
table.insert(UnitPopupShown,1);
table.insert(UnitPopupMenus["FRIEND"], table.getn(UnitPopupMenus["FRIEND"]),"IGNORE");
table.insert(UnitPopupMenus["PARTY"], table.getn(UnitPopupMenus["PARTY"]),"IGNORE");
table.insert(UnitPopupMenus["PLAYER"], table.getn(UnitPopupMenus["PLAYER"]),"IGNORE");
table.insert(UnitPopupMenus["RAID"], table.getn(UnitPopupMenus["RAID"]),"IGNORE");
table.insert(UnitPopupShown,1);
table.insert(UnitPopupMenus["FRIEND"], table.getn(UnitPopupMenus["FRIEND"]),"REMOVE_IGNORE");
table.insert(UnitPopupMenus["PARTY"], table.getn(UnitPopupMenus["PARTY"]),"REMOVE_IGNORE");
table.insert(UnitPopupMenus["PLAYER"], table.getn(UnitPopupMenus["PLAYER"]),"REMOVE_IGNORE");
table.insert(UnitPopupMenus["RAID"], table.getn(UnitPopupMenus["RAID"]),"REMOVE_IGNORE");


