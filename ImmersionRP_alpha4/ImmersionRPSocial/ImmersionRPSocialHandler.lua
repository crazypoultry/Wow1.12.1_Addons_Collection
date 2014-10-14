--[[
	ImmersionRP Alpha 4 Social panel handler file.
	Purpose: Manage the IRP Social UI.
	Author: Seagale.
	Last update: March 10th, 2007.
]]

ImmersionRPSocialPlayers = {};
ImmersionRPSocialGuilds = {};

ImmersionRPSocialHandler = {
	ListMode,
	BufferTable,
	SelectedEntry,
	SocialEntryDefaults = { ["STATUS"] = 1 }, -- 1=known, 2=friendly, 3=hostile
	SocialStatusText = { [1] = IRP_STRING_SOCIAL_KNOWN, [2] = IRP_STRING_SOCIAL_FRIENDLY, [3] = IRP_STRING_SOCIAL_HOSTILE },
	FRIENDS_TO_SHOW = 9,
	
	DBFunctions = {
	
		AddEntry = function (self, key)
			if (key ~= nil and key ~= "" and self[key] == nil) then
				self[key] = {};
				setmetatable(self[key], ImmersionRPSocialHandler.SocialEntryMetatable);
				if (ImmersionRPSocialHandler.ListMode == self) then
					ImmersionRPSocialHandler.BufferTable = self:MakeBufferTable();
					ImmersionRPSocialHandler.UpdateScroll();
				end
			end
		end,
		
		RemoveEntry = function (self, key)
			self[key] = nil;
			if (ImmersionRPSocialHandler.ListMode == self) then
				ImmersionRPSocialHandler.BufferTable = self:MakeBufferTable();
				ImmersionRPSocialHandler.UpdateScroll();
			end
		end,
	
		
		-- Turns a dictionary into an array whose values are the original keys.
		-- Accepts optional sort compare function.
		MakeBufferTable = function (self, sortfunc)
			local newTable = {};
			local key, value;
		
			for key,value in pairs(self) do
				table.insert(newTable, key);
			end
			if (type(sortfunc) == "function") then 
				table.sort(newTable, sortfunc);
			end
			return newTable;
		end,
	
	},
	
	
	OnLoad = function ()
		ImmersionRPSocialFrame:RegisterEvent("ADDON_LOADED");
		ImmersionRPMainFrameTab3:Enable();
		ImmersionRPSocialHandler.InitialiseStaticPopups();
		ImmersionRPSocialRemove:Disable();
	end,
	
	InitialiseMetatables = function()
		local key;
		
		ImmersionRPSocialHandler.SocialEntryMetatable = { ["__index"] = ImmersionRPSocialHandler.SocialEntryDefaults };
		
		for key in pairs(ImmersionRPSocialPlayers) do
			setmetatable(rawget(ImmersionRPSocialPlayers, key), ImmersionRPSocialHandler.SocialEntryMetatable);
		end
		
		for key in pairs(ImmersionRPSocialGuilds) do
			setmetatable(rawget(ImmersionRPSocialGuilds, key), ImmersionRPSocialHandler.SocialEntryMetatable);
		end

		ImmersionRPSocialHandler.SocialPlayerProperties = { AssociatedEntryFrame = ImmersionRPSocialPlayerEntry,
															RemoveEntry = function (self, key)
																				ImmersionRPDatabaseHandler.DeleteFlag(key, "FIRSTNAMEALTERNATE");
																				ImmersionRPDatabaseHandler.DeleteFlag(key, "LASTNAMEALTERNATE");
																				ImmersionRPDatabaseHandler.DeleteFlag(key, "TITLEALTERNATE");
																				ImmersionRPSocialHandler.DBFunctions.RemoveEntry(self, key);
																			end
														};
		ImmersionRPSocialHandler.SocialGuildProperties = { AssociatedEntryFrame = ImmersionRPSocialGuildEntry };
		
		ImmersionRPSocialHandler.PlayerMetatable = { ["__index"] = ImmersionRPSocialHandler.SocialPlayerProperties };
		ImmersionRPSocialHandler.GuildMetatable = { ["__index"] = ImmersionRPSocialHandler.SocialGuildProperties };
		ImmersionRPSocialHandler.DBMetatable = { ["__index"] = ImmersionRPSocialHandler.DBFunctions };
		
		setmetatable(ImmersionRPSocialHandler.SocialPlayerProperties, ImmersionRPSocialHandler.DBMetatable);
		setmetatable(ImmersionRPSocialHandler.SocialGuildProperties, ImmersionRPSocialHandler.DBMetatable);
		
		setmetatable(ImmersionRPSocialPlayers, ImmersionRPSocialHandler.PlayerMetatable);
		setmetatable(ImmersionRPSocialGuilds, ImmersionRPSocialHandler.GuildMetatable);
	end,
	
	InitialiseStaticPopups = function ()
	StaticPopupDialogs["IRP_SOCIAL_ADDPLAYER"] = {
		text = IRP_STRING_SOCIAL_ADDPLAYER,
		button1 = OKAY,
		button2 = CANCEL,
		OnAccept = function()
			local nametyped = getglobal(this:GetParent():GetName().."EditBox"):GetText();
			local normalisedname = string.upper(string.sub(nametyped,1,1)) .. string.lower(string.sub(nametyped,2,string.len(nametyped)));
			ImmersionRPSocialPlayers:AddEntry(normalisedname);
			getglobal(this:GetParent():GetName().."EditBox"):SetText("");
		end,
		EditBoxOnEnterPressed = function()
			local nametyped = getglobal(this:GetParent():GetName().."EditBox"):GetText();
			local normalisedname = string.upper(string.sub(nametyped,1,1)) .. string.lower(string.sub(nametyped,2,string.len(nametyped)));
			ImmersionRPSocialPlayers:AddEntry(normalisedname);
			getglobal(this:GetParent():GetName().."EditBox"):SetText("");
		end,		
		timeout = 0,
		whileDead = 1,
		hideOnEscape = 1,
		hasEditBox = 1
	};
	
	StaticPopupDialogs["IRP_SOCIAL_ADDGUILD"] = {
		text = IRP_STRING_SOCIAL_ADDGUILD,
		button1 = OKAY,
		button2 = CANCEL,
		OnAccept = function()
			ImmersionRPSocialGuilds:AddEntry(getglobal(this:GetParent():GetName().."EditBox"):GetText());
			getglobal(this:GetParent():GetName().."EditBox"):SetText("");
		end,
		EditBoxOnEnterPressed = function()
			ImmersionRPSocialGuilds:AddEntry(getglobal(this:GetParent():GetName().."EditBox"):GetText());
			getglobal(this:GetParent():GetName().."EditBox"):SetText("");
		end,		
		timeout = 0,
		whileDead = 1,
		hideOnEscape = 1,
		hasEditBox = 1
	};
	end,
	
	SetActiveTable = function (tbl)
		if (ImmersionRPSocialHandler.ListMode ~= tbl) then
			ImmersionRPSocialHandler.ListMode = tbl;
			ImmersionRPSocialHandler.BufferTable = tbl:MakeBufferTable();
		end
		FauxScrollFrame_SetOffset(ImmersionRPSocialScrollFrame, 0);
		tbl.AssociatedEntryFrame:Hide();
		ImmersionRPSocialHandler.UpdateScroll();
	end,
	
	LoadPlayerInformation = function ()
		ImmersionRPSocialAlternateFirstName:SetText(ImmersionRPDatabaseHandler.GetFlag(ImmersionRPSocialHandler.SelectedEntry, "FIRSTNAMEALTERNATE") or "");
		ImmersionRPSocialAlternateLastName:SetText(ImmersionRPDatabaseHandler.GetFlag(ImmersionRPSocialHandler.SelectedEntry, "LASTNAMEALTERNATE") or "");
		ImmersionRPSocialAlternateTitle:SetText(ImmersionRPDatabaseHandler.GetFlag(ImmersionRPSocialHandler.SelectedEntry, "TITLEALTERNATE") or "");
		HideDropDownMenu(1);
		UIDropDownMenu_Initialize(ImmersionRPSocialPlayerStatus, ImmersionRPSocialHandler.InitialisePlayerStatusDropdown);
		UIDropDownMenu_SetSelectedID(ImmersionRPSocialPlayerStatus, ImmersionRPSocialPlayers[ImmersionRPSocialHandler.SelectedEntry]["STATUS"]);
		UIDropDownMenu_SetWidth(200, ImmersionRPSocialPlayerStatus);
	end,
	
	SavePlayerInformation = function ()
		ImmersionRPDatabaseHandler.SetFlag(ImmersionRPSocialHandler.SelectedEntry, "FIRSTNAMEALTERNATE", ImmersionRPSocialAlternateFirstName:GetText());
		ImmersionRPDatabaseHandler.SetFlag(ImmersionRPSocialHandler.SelectedEntry, "LASTNAMEALTERNATE", ImmersionRPSocialAlternateLastName:GetText());
		ImmersionRPDatabaseHandler.SetFlag(ImmersionRPSocialHandler.SelectedEntry, "TITLEALTERNATE", ImmersionRPSocialAlternateTitle:GetText());
		ImmersionRPSocialPlayers[ImmersionRPSocialHandler.SelectedEntry]["STATUS"] = UIDropDownMenu_GetSelectedID(ImmersionRPSocialPlayerStatus);
	end,
	
	LoadGuildInformation = function ()
		HideDropDownMenu(1);
		UIDropDownMenu_Initialize(ImmersionRPSocialGuildStatus, ImmersionRPSocialHandler.InitialiseGuildStatusDropdown);
		UIDropDownMenu_SetSelectedID(ImmersionRPSocialGuildStatus, ImmersionRPSocialGuilds[ImmersionRPSocialHandler.SelectedEntry]["STATUS"]);
		UIDropDownMenu_SetWidth(200, ImmersionRPSocialGuildStatus);
	end,
	
	SaveGuildInformation = function ()
		ImmersionRPSocialGuilds[ImmersionRPSocialHandler.SelectedEntry]["STATUS"] = UIDropDownMenu_GetSelectedID(ImmersionRPSocialGuildStatus);
	end,
	
	UpdateScroll = function ()
		FauxScrollFrame_Update(ImmersionRPSocialScrollFrame, table.getn(ImmersionRPSocialHandler.BufferTable), ImmersionRPSocialHandler.FRIENDS_TO_SHOW, 31);
		local offset = FauxScrollFrame_GetOffset(ImmersionRPSocialScrollFrame);
		local iter;
		
		for iter=1, ImmersionRPSocialHandler.FRIENDS_TO_SHOW do
			if (ImmersionRPSocialHandler.BufferTable[iter + offset] ~= nil) then
				getglobal("ImmersionRPFriendButton" .. iter .. "ButtonTextName"):SetText(ImmersionRPSocialHandler.BufferTable[iter + offset]);
				getglobal("ImmersionRPFriendButton" .. iter .. "ButtonTextInfo"):SetText(ImmersionRPDatabaseHandler.GetFlag(ImmersionRPSocialHandler.BufferTable[iter + offset], "TITLE"));
				getglobal("ImmersionRPFriendButton" .. iter):Show();
			else
				getglobal("ImmersionRPFriendButton" .. iter):Hide();
			end
			if (ImmersionRPSocialHandler.SelectedEntry == ImmersionRPSocialHandler.BufferTable[iter + offset]) then
				getglobal("ImmersionRPFriendButton" .. iter):LockHighlight();
			else
				getglobal("ImmersionRPFriendButton" .. iter):UnlockHighlight();
			end
		end
	end,
	
	HandlePlayerStatusDropdown = function()
		UIDropDownMenu_SetSelectedID(ImmersionRPSocialPlayerStatus, this:GetID());
	end,
	
	InitialisePlayerStatusDropdown = function ()
		local info = {};
		info.func = ImmersionRPSocialHandler.HandlePlayerStatusDropdown;
		info.owner = this;
		
		info.text = IRP_STRING_SOCIAL_KNOWN;
		info.checked = ImmersionRPSocialPlayers[ImmersionRPSocialHandler.SelectedEntry]["STATUS"] == 1;
		info.textR = IRP_SOCIAL_STATUSCOLORS[1].r;
		info.textG = IRP_SOCIAL_STATUSCOLORS[1].g;
		info.textB = IRP_SOCIAL_STATUSCOLORS[1].b;
		UIDropDownMenu_AddButton(info);
	
		info.text = IRP_STRING_SOCIAL_FRIENDLY;
		info.checked = ImmersionRPSocialPlayers[ImmersionRPSocialHandler.SelectedEntry]["STATUS"] == 2;
		info.textR = IRP_SOCIAL_STATUSCOLORS[2].r;
		info.textG = IRP_SOCIAL_STATUSCOLORS[2].g;
		info.textB = IRP_SOCIAL_STATUSCOLORS[2].b;
		UIDropDownMenu_AddButton(info);
	
		info.text = IRP_STRING_SOCIAL_HOSTILE;
		info.checked = ImmersionRPSocialPlayers[ImmersionRPSocialHandler.SelectedEntry]["STATUS"] == 3;
		info.textR = IRP_SOCIAL_STATUSCOLORS[3].r;
		info.textG = IRP_SOCIAL_STATUSCOLORS[3].g;
		info.textB = IRP_SOCIAL_STATUSCOLORS[3].b;
		UIDropDownMenu_AddButton(info);
	end,
	
	HandleGuildStatusDropdown = function()
		UIDropDownMenu_SetSelectedID(ImmersionRPSocialGuildStatus, this:GetID());
	end,
	
	InitialiseGuildStatusDropdown = function ()
		local info = {};
		info.func = ImmersionRPSocialHandler.HandleGuildStatusDropdown;
		
		info.text = IRP_STRING_SOCIAL_KNOWN;
		info.checked = ImmersionRPSocialGuilds[ImmersionRPSocialHandler.SelectedEntry]["STATUS"] == 1;
		info.textR = IRP_SOCIAL_STATUSCOLORS[1].r;
		info.textG = IRP_SOCIAL_STATUSCOLORS[1].g;
		info.textB = IRP_SOCIAL_STATUSCOLORS[1].b;
		UIDropDownMenu_AddButton(info);
	
		info.text = IRP_STRING_SOCIAL_FRIENDLY;
		info.checked = ImmersionRPSocialGuilds[ImmersionRPSocialHandler.SelectedEntry]["STATUS"] == 2;
		info.textR = IRP_SOCIAL_STATUSCOLORS[2].r;
		info.textG = IRP_SOCIAL_STATUSCOLORS[2].g;
		info.textB = IRP_SOCIAL_STATUSCOLORS[2].b;
		UIDropDownMenu_AddButton(info);
	
		info.text = IRP_STRING_SOCIAL_HOSTILE;
		info.checked = ImmersionRPSocialGuilds[ImmersionRPSocialHandler.SelectedEntry]["STATUS"] == 3;
		info.textR = IRP_SOCIAL_STATUSCOLORS[3].r;
		info.textG = IRP_SOCIAL_STATUSCOLORS[3].g;
		info.textB = IRP_SOCIAL_STATUSCOLORS[3].b;
		UIDropDownMenu_AddButton(info);
	end
};