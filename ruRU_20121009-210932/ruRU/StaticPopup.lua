
-- STATICPOPUP_NUMDIALOGS = 4;

-- StaticPopupDialogs = { };

StaticPopupDialogs["TAKE_GM_SURVEY"] = {
	text = TEXT(TAKE_GM_SURVEY),
	button1 = TEXT(YES),
	button2 = TEXT(NO),
	OnAccept = function()
		GMSurveyFrame_LoadUI();
		ShowUIPanel(GMSurveyFrame);
		TicketStatusFrame:Hide();
	end,
	OnCancel = function()
		TicketStatusFrame.hasGMSurvey = nil;
		TicketStatusFrame:Hide();
	end,
	timeout = 0,
	hideOnEscape = 1,
};

StaticPopupDialogs["CONFIRM_RESET_INSTANCES"] = {
	text = TEXT(CONFIRM_RESET_INSTANCES),
	button1 = TEXT(YES),
	button2 = TEXT(NO),
	OnAccept = function()
		ResetInstances();
	end,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = 1,
};

StaticPopupDialogs["CONFIRM_GUILD_DISBAND"] = {
	text = TEXT(CONFIRM_GUILD_DISBAND),
	button1 = TEXT(YES),
	button2 = TEXT(NO),
	OnAccept = function()
		GuildDisband();
	end,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = 1,
};

StaticPopupDialogs["CONFIRM_BUY_BANK_SLOT"] = {
	text = TEXT(CONFIRM_BUY_BANK_SLOT),
	button1 = TEXT(YES),
	button2 = TEXT(NO),
	OnAccept = function()
		PurchaseSlot();
	end,
	OnShow = function()
		MoneyFrame_Update(this:GetName().."MoneyFrame", BankFrame.nextSlotCost);
	end,
	hasMoneyFrame = 1,
	timeout = 0,
	hideOnEscape = 1,
};

StaticPopupDialogs["MACRO_ACTION_FORBIDDEN"] = {
	text = TEXT(MACRO_ACTION_FORBIDDEN),
	button1 = TEXT(OKAY),
	timeout = 0,
	exclusive = 1,
	whileDead = 1,
	hideOnEscape = 1
};

StaticPopupDialogs["ADDON_ACTION_FORBIDDEN"] = {
	text = TEXT(ADDON_ACTION_FORBIDDEN),
	button1 = TEXT(DISABLE),
	button2 = TEXT(IGNORE),
	OnAccept = function(data)
		DisableAddOn(data);
		ReloadUI();
	end,
	timeout = 0,
	exclusive = 1,
	whileDead = 1,
	hideOnEscape = 1
};

-- StaticPopupDialogs["CONFIRM_LOOT_DISTRIBUTION"] = {
-- 	text = TEXT(CONFIRM_LOOT_DISTRIBUTION),
-- 	button1 = TEXT(YES),
-- 	button2 = TEXT(NO),
-- 	OnAccept = function(data)
-- 		GiveMasterLoot(LootFrame.selectedSlot, data);
-- 	end,
-- 	timeout = 0,
-- 	hideOnEscape = 1,
-- };

StaticPopupDialogs["CONFIRM_BATTLEFIELD_ENTRY"] = {
	text = TEXT(CONFIRM_BATTLEFIELD_ENTRY),
	button1 = TEXT(ENTER_BATTLE),
	button2 = TEXT(HIDE),
	OnAccept = function(data)
		AcceptBattlefieldPort(data, 1);
	end,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = 1,
	multiple = 1
};

StaticPopupDialogs["CONFIRM_GUILD_LEAVE"] = {
	text = TEXT(CONFIRM_GUILD_LEAVE),
	button1 = TEXT(ACCEPT),
	button2 = TEXT(CANCEL),
	OnAccept = function()
		GuildLeave();
	end,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = 1
};

StaticPopupDialogs["CONFIRM_GUILD_PROMOTE"] = {
	text = TEXT(CONFIRM_GUILD_PROMOTE),
	button1 = TEXT(ACCEPT),
	button2 = TEXT(CANCEL),
	OnAccept = function(name)
		GuildSetLeaderByName(name);
	end,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = 1
};

StaticPopupDialogs["RENAME_GUILD"] = {
	text = TEXT(RENAME_GUILD_LABEL),
	button1 = TEXT(ACCEPT),
	button2 = TEXT(CANCEL),
	hasEditBox = 1,
	maxLetters = 24,
	OnAccept = function()
		local text = getglobal(this:GetParent():GetName().."EditBox"):GetText();
		RenamePetition(text);
	end,
	EditBoxOnEnterPressed = function()
		local text = getglobal(this:GetParent():GetName().."EditBox"):GetText();
		RenamePetition(text);
		this:GetParent():Hide();
	end,
	OnShow = function()
		getglobal(this:GetName().."EditBox"):SetFocus();
	end,
	OnHide = function()
		if ( ChatFrameEditBox:IsVisible() ) then
			ChatFrameEditBox:SetFocus();
		end
		getglobal(this:GetName().."EditBox"):SetText("");
	end,
	timeout = 0,
	exclusive = 1,
	whileDead = 1,
	hideOnEscape = 1
};

StaticPopupDialogs["HELP_TICKET_QUEUE_DISABLED"] = {
	text = TEXT(HELP_TICKET_QUEUE_DISABLED),
	button1 = TEXT(OKAY),
	showAlert = 1,
	timeout = 0,
}

StaticPopupDialogs["CONFIRM_LEAVE_QUEUE"] = {
	text = TEXT(CONFIRM_LEAVE_QUEUE),
	button1 = TEXT(ACCEPT),
	button2 = TEXT(CANCEL),
	OnAccept = function()
		CancelMeetingStoneRequest();
	end,
	timeout = 0,
	hideOnEscape = 1
};

StaticPopupDialogs["CLIENT_RESTART_ALERT"] = {
	text = TEXT(CLIENT_RESTART_ALERT),
	button1 = TEXT(OKAY),
	showAlert = 1,
	timeout = 0,
};

StaticPopupDialogs["MEMORY_EXHAUSTED"] = {
	text = TEXT(MEMORY_EXHAUSTED),
	button1 = TEXT(QUIT_NOW),
	OnAccept = function()
		ForceQuit();
	end,
	timeout = 0,
	whileDead = 1,
};

StaticPopupDialogs["COD_ALERT"] = {
	text = TEXT(COD_INSUFFICIENT_MONEY),
	button1 = TEXT(CLOSE),
	timeout = 0,
	hideOnEscape = 1
};

StaticPopupDialogs["COD_CONFIRMATION"] = {
	text = TEXT(COD_CONFIRMATION),
	button1 = TEXT(ACCEPT),
	button2 = TEXT(CANCEL),
	OnAccept = function()
		TakeInboxItem(InboxFrame.openMailID);
	end,
	OnShow = function()
		MoneyFrame_Update(this:GetName().."MoneyFrame", OpenMailFrame.cod);
	end,
	hasMoneyFrame = 1,
	timeout = 0,
	hideOnEscape = 1
};

StaticPopupDialogs["DELETE_MAIL"] = {
	text = TEXT(DELETE_MAIL_CONFIRMATION),
	button1 = TEXT(ACCEPT),
	button2 = TEXT(CANCEL),
	OnAccept = function()
		DeleteInboxItem(InboxFrame.openMailID);
		InboxFrame.openMailID = nil;
		HideUIPanel(OpenMailFrame);
	end,
	showAlert = 1,
	timeout = 0,
	hideOnEscape = 1
};

StaticPopupDialogs["DELETE_MONEY"] = {
	text = TEXT(DELETE_MONEY_CONFIRMATION),
	button1 = TEXT(ACCEPT),
	button2 = TEXT(CANCEL),
	OnAccept = function()
		DeleteInboxItem(InboxFrame.openMailID);
		InboxFrame.openMailID = nil;
		HideUIPanel(OpenMailFrame);
	end,
	OnShow = function()
		MoneyFrame_Update(this:GetName().."MoneyFrame", OpenMailFrame.money);
	end,
	hasMoneyFrame = 1,
	showAlert = 1,
	timeout = 0,
	hideOnEscape = 1
};

StaticPopupDialogs["SEND_MONEY"] = {
	text = TEXT(SEND_MONEY_CONFIRMATION),
	button1 = TEXT(ACCEPT),
	button2 = TEXT(CANCEL),
	OnAccept = function()
		if ( SetSendMailMoney(MoneyInputFrame_GetCopper(SendMailMoney)) ) then
			SendMailFrame_SendMail();
		end
	end,
	OnCancel = function()
		SendMailMailButton:Enable();
	end,
	OnShow = function()
		MoneyFrame_Update(this:GetName().."MoneyFrame", MoneyInputFrame_GetCopper(SendMailMoney));
	end,
	hasMoneyFrame = 1,
	timeout = 0,
	hideOnEscape = 1
};

StaticPopupDialogs["JOIN_CHANNEL"] = {
	text = TEXT(ADD_CHANNEL),
	button1 = TEXT(ACCEPT),
	button2 = TEXT(CANCEL),
	hasEditBox = 1,
	maxLetters = 31,
	whileDead = 1,
	OnAccept = function()
		local channel = getglobal(this:GetParent():GetName().."EditBox"):GetText();
		JoinChannelByName(channel, nil, FCF_GetCurrentChatFrameID());
		ChatFrame_AddChannel(FCF_GetCurrentChatFrame(), channel);
		getglobal(this:GetParent():GetName().."EditBox"):SetText("");
	end,
	timeout = 0,
	EditBoxOnEnterPressed = function()
		local channel = getglobal(this:GetParent():GetName().."EditBox"):GetText();
		JoinChannelByName(channel, nil, FCF_GetCurrentChatFrameID());
		ChatFrame_AddChannel(FCF_GetCurrentChatFrame(), channel);
		getglobal(this:GetParent():GetName().."EditBox"):SetText("");
		this:GetParent():Hide();
	end,
	hideOnEscape = 1
};

StaticPopupDialogs["NAME_CHAT"] = {
	text = TEXT(NAME_CHAT_WINDOW),
	button1 = TEXT(ACCEPT),
	button2 = TEXT(CANCEL),
	hasEditBox = 1,
	maxLetters = 31,
	whileDead = 1,
	OnAccept = function(renameID)
		local name = getglobal(this:GetParent():GetName().."EditBox"):GetText();
		if ( renameID ) then
			FCF_SetWindowName(getglobal("ChatFrame"..renameID), name);
		else
			FCF_OpenNewWindow(name);
		end
		getglobal(this:GetParent():GetName().."EditBox"):SetText("");
		FCF_DockUpdate();
	end,
	timeout = 0,
	EditBoxOnEnterPressed = function(renameID)
		local name = getglobal(this:GetParent():GetName().."EditBox"):GetText();
		if ( renameID ) then
			FCF_SetWindowName(getglobal("ChatFrame"..renameID), name);
		else
			FCF_OpenNewWindow(name);
		end
		getglobal(this:GetParent():GetName().."EditBox"):SetText("");
		FCF_DockUpdate();
		this:GetParent():Hide();
	end,
	EditBoxOnEscapePressed = function ()
		this:GetParent():Hide();
	end,
	hideOnEscape = 1
};

StaticPopupDialogs["HELP_TICKET_ABANDON_CONFIRM"] = {
	text = TEXT(HELP_TICKET_ABANDON_CONFIRM),
	button1 = TEXT(YES),
	button2 = TEXT(NO),
	OnAccept = function(prevFrame)
		DeleteGMTicket();
	end,
	OnCancel = function(prevFrame)
	end,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = 1
}
StaticPopupDialogs["HELP_TICKET"] = {
	text = TEXT(HELP_TICKET_EDIT_ABANDON),
	button1 = TEXT(HELP_TICKET_EDIT),
	button2 = TEXT(HELP_TICKET_ABANDON),
	OnAccept = function()
		if ( PETITION_QUEUE_ACTIVE ) then
			ShowUIPanel(HelpFrame);
			HelpFrame_ShowFrame("OpenTicket");
		else
			HideUIPanel(HelpFrame);
			StaticPopup_Show("HELP_TICKET_QUEUE_DISABLED");
		end
	end,
	OnCancel = function()
		local currentFrame = this:GetParent();
		local dialogFrame = StaticPopup_Show("HELP_TICKET_ABANDON_CONFIRM");
		dialogFrame.data = currentFrame;
	end,
	timeout = 0,
	whileDead = 1
}
StaticPopupDialogs["PETRENAMECONFIRM"] = {
	text = TEXT(PET_RENAME_CONFIRMATION),
	button1 = TEXT(YES),
	button2 = TEXT(NO),
	OnAccept = function()
		PetRename(this:GetParent().data);
	end,
	timeout = 0,
	hideOnEscape = 1
}
StaticPopupDialogs["DEATH"] = {
	text = TEXT(DEATH_RELEASE_TIMER),
	button1 = TEXT(DEATH_RELEASE),
	button2 = TEXT(USE_SOULSTONE),
	OnShow = function()
		this.timeleft = GetReleaseTimeRemaining();
		local text = HasSoulstone();
		if ( text ) then
			getglobal(this:GetName().."Button2"):SetText(text);
		end
		if ( this.timeleft == -1 ) then
			getglobal(this:GetName().."Text"):SetText(DEATH_RELEASE_NOTIMER);
		end
	end,
	OnAccept = function()
		RepopMe();
	end,
	OnCancel = function(data, reason)
		if ( reason == "override" ) then
			return;
		end
		if ( reason == "timeout" ) then
			return;
		end
		if ( reason == "clicked" ) then
			if ( HasSoulstone() ) then
				UseSoulstone();
			else
				RepopMe();
			end
		end
	end,
	DisplayButton2 = function()
		return HasSoulstone();
	end,
	timeout = 0,
	whileDead = 1,
	interruptCinematic = 1,
	notClosableByLogout = 1,
	cancels = "RECOVER_CORPSE"
};
StaticPopupDialogs["RESURRECT"] = {
	StartDelay = GetCorpseRecoveryDelay,
	delayText = TEXT(RESURRECT_REQUEST_TIMER),
	text = TEXT(RESURRECT_REQUEST),
	button1 = TEXT(ACCEPT),
	button2 = TEXT(DECLINE),
	OnShow = function()
		this.timeleft = GetCorpseRecoveryDelay() + 60;
	end,
	OnAccept = function()
		AcceptResurrect();
	end,
	OnCancel = function()
		DeclineResurrect();
		if ( UnitIsDead("player") ) then
			StaticPopup_Show("DEATH");
		end
	end,
	timeout = 60,
	whileDead = 1,
	cancels = "DEATH",
	interruptCinematic = 1,
	notClosableByLogout = 1,
	hideOnEscape = 1
};
StaticPopupDialogs["RESURRECT_NO_SICKNESS"] = {
	StartDelay = GetCorpseRecoveryDelay,
	delayText = TEXT(RESURRECT_REQUEST_NO_SICKNESS_TIMER),
	text = TEXT(RESURRECT_REQUEST_NO_SICKNESS),
	button1 = TEXT(ACCEPT),
	button2 = TEXT(DECLINE),
	OnShow = function()
		this.timeleft = GetCorpseRecoveryDelay() + 60;
	end,
	OnAccept = function()
		AcceptResurrect();
	end,
	OnCancel = function()
		DeclineResurrect();
		if ( UnitIsDead("player") ) then
			StaticPopup_Show("DEATH");
		end
	end,
	timeout = 60,
	whileDead = 1,
	cancels = "DEATH",
	interruptCinematic = 1,
	notClosableByLogout = 1,
	hideOnEscape = 1
};
StaticPopupDialogs["RESURRECT_NO_TIMER"] = {
	text = TEXT(RESURRECT_REQUEST_NO_SICKNESS),
	button1 = TEXT(ACCEPT),
	button2 = TEXT(DECLINE),
	OnShow = function()
		this.timeleft = GetCorpseRecoveryDelay() + 60;
	end,
	OnAccept = function()
		AcceptResurrect();
	end,
	OnCancel = function()
		DeclineResurrect();
		if ( UnitIsDead("player") ) then
			StaticPopup_Show("DEATH");
		end
	end,
	timeout = 60,
	whileDead = 1,
	cancels = "DEATH",
	interruptCinematic = 1,
	notClosableByLogout = 1,
	hideOnEscape = 1
};
StaticPopupDialogs["SKINNED"] = {
	text = TEXT(DEATH_CORPSE_SKINNED),
	button1 = TEXT(ACCEPT),
	timeout = 0,
	whileDead = 1,
	interruptCinematic = 1,
	notClosableByLogout = 1,	
};
StaticPopupDialogs["SKINNED_REPOP"] = {
	text = TEXT(DEATH_CORPSE_SKINNED),
	button1 = TEXT(DEATH_RELEASE),	
	button2 = TEXT(DECLINE),
	OnAccept = function()
		StaticPopup_Hide("RESURRECT");
		StaticPopup_Hide("RESURRECT_NO_SICKNESS");
		StaticPopup_Hide("RESURRECT_NO_TIMER");
		RepopMe();
	end,
	timeout = 0,
	whileDead = 1,
	interruptCinematic = 1,
	notClosableByLogout = 1,
	hideOnEscape = 1	
};
StaticPopupDialogs["TRADE"] = {
	text = TEXT(TRADE_WITH_QUESTION),
	button1 = TEXT(YES),
	button2 = TEXT(NO),
	OnAccept = function()
		BeginTrade();
	end,
	OnCancel = function()
		CancelTrade();
	end,
	timeout = 60,
	hideOnEscape = 1
};
StaticPopupDialogs["PARTY_INVITE"] = {
	text = TEXT(INVITATION),
	button1 = TEXT(ACCEPT),
	button2 = TEXT(DECLINE),
	sound = "igPlayerInvite",
	OnShow = function()
		StaticPopupDialogs["PARTY_INVITE"].inviteAccepted = nil;
	end,
	OnAccept = function()
		AcceptGroup();
		StaticPopupDialogs["PARTY_INVITE"].inviteAccepted = 1;
	end,
	OnCancel = function()
		DeclineGroup();
	end,
	OnHide = function()
		if ( not StaticPopupDialogs["PARTY_INVITE"].inviteAccepted ) then
			DeclineGroup();
		end
	end,
	timeout = 60,
	whileDead = 1,
	hideOnEscape = 1
};
StaticPopupDialogs["GUILD_INVITE"] = {
	text = TEXT(GUILD_INVITATION),
	button1 = TEXT(ACCEPT),
	button2 = TEXT(DECLINE),
	OnAccept = function()
		AcceptGuild();
	end,
	OnCancel = function()
		DeclineGuild();
	end,
	timeout = 60,
	whileDead = 1,
	hideOnEscape = 1
};
StaticPopupDialogs["CAMP"] = {
	text = TEXT(CAMP_TIMER),
	button1 = TEXT(CANCEL),
	--button2 = TEXT(CAMP_NOW),
	OnAccept = function()
		CancelLogout();
		--ForceLogout();
		-- uncomment the next line once forced logouts are completely implemented (they currently have a failure case)
		-- this.timeleft = 0;
	end,
	OnHide = function()
		if ( this.timeleft > 0 ) then
			CancelLogout();
			this:Hide();
		end
	end,
	timeout = 20,
	whileDead = 1,
	hideOnEscape = 1
};
StaticPopupDialogs["QUIT"] = {
	text = TEXT(QUIT_TIMER),
	button1 = TEXT(QUIT_NOW),
	button2 = TEXT(CANCEL),
	OnAccept = function()
		ForceQuit();
		this.timeleft = 0;
	end,
	OnHide = function()
		if ( this.timeleft > 0 ) then
			CancelLogout();
		end
	end,
	timeout = 20,
	whileDead = 1,
	hideOnEscape = 1
};

-- StaticPopupDialogs["LOOT_BIND"] = {
-- 	text = TEXT(LOOT_NO_DROP),
-- 	button1 = TEXT(OKAY),
-- 	button2 = TEXT(CANCEL),
-- 	OnAccept = function(slot)
-- 		LootSlot(slot);
-- 	end,
-- 	timeout = 0,
-- 	exclusive = 1,
-- 	hideOnEscape = 1
-- };
-- StaticPopupDialogs["EQUIP_BIND"] = {
-- 	text = TEXT(EQUIP_NO_DROP),
-- 	button1 = TEXT(OKAY),
-- 	button2 = TEXT(CANCEL),
-- 	OnAccept = function(slot)
-- 		EquipPendingItem(slot);
-- 	end,
-- 	OnCancel = function(slot)
-- 		CancelPendingEquip(slot);
-- 	end,
-- 	OnHide = function(slot)
-- 		CancelPendingEquip(slot);
-- 	end,
-- 	timeout = 0,
-- 	exclusive = 1,
-- 	whileDead = 1,
-- 	hideOnEscape = 1
-- };
-- StaticPopupDialogs["AUTOEQUIP_BIND"] = {
-- 	text = TEXT(EQUIP_NO_DROP),
-- 	button1 = TEXT(OKAY),
-- 	button2 = TEXT(CANCEL),
-- 	OnAccept = function(slot)
-- 		EquipPendingItem(slot);
-- 	end,
-- 	OnCancel = function(slot)
-- 		CancelPendingEquip(slot);
-- 	end,
-- 	OnHide = function(slot)
-- 		CancelPendingEquip(slot);
-- 	end,
-- 	timeout = 0,
-- 	exclusive = 1,
-- 	whileDead = 1,
-- 	hideOnEscape = 1
-- };
StaticPopupDialogs["USE_BIND"] = {
	text = TEXT(USE_NO_DROP),
	button1 = TEXT(OKAY),
	button2 = TEXT(CANCEL),
	OnAccept = function()
		ConfirmBindOnUse();
	end,
	timeout = 0,
	exclusive = 1,
	hideOnEscape = 1
};
StaticPopupDialogs["DELETE_ITEM"] = {
	text = TEXT(DELETE_ITEM),
	button1 = TEXT(YES),
	button2 = TEXT(NO),
	OnAccept = function()
		DeleteCursorItem();
	end,
	OnCancel = function ()
		ClearCursor();
	end,
	OnUpdate = function ()
		if ( not CursorHasItem() ) then
			StaticPopup_Hide("DELETE_ITEM");
		end
	end,
	timeout = 0,
	whileDead = 1,
	exclusive = 1,
	showAlert = 1,
	hideOnEscape = 1
};
StaticPopupDialogs["DELETE_GOOD_ITEM"] = {
	text = TEXT(DELETE_GOOD_ITEM),
	button1 = TEXT(YES),
	button2 = TEXT(NO),
	OnAccept = function()
		DeleteCursorItem();
	end,
	OnCancel = function ()
		ClearCursor();
	end,
	OnUpdate = function ()
		if ( not CursorHasItem() ) then
			StaticPopup_Hide("DELETE_GOOD_ITEM");
		end
	end,
	timeout = 0,
	whileDead = 1,
	exclusive = 1,
	showAlert = 1,
	hideOnEscape = 1,
	hasEditBox = 1,
	maxLetters = 32,
	OnShow = function()
		getglobal(this:GetName().."Button1"):Disable();
		getglobal(this:GetName().."EditBox"):SetFocus();
	end,
	OnHide = function()
		if ( ChatFrameEditBox:IsVisible() ) then
			ChatFrameEditBox:SetFocus();
		end
		getglobal(this:GetName().."EditBox"):SetText("");
	end,
	EditBoxOnEnterPressed = function()
		if ( getglobal(this:GetParent():GetName().."Button1"):IsEnabled() == 1 ) then
			DeleteCursorItem();
			this:GetParent():Hide();
		end
	end,
	EditBoxOnTextChanged = function ()
		local editBox = getglobal(this:GetParent():GetName().."EditBox");
		if ( strupper(editBox:GetText()) ==  DELETE_ITEM_CONFIRM_STRING ) then
			getglobal(this:GetParent():GetName().."Button1"):Enable();
		else
			getglobal(this:GetParent():GetName().."Button1"):Disable();
		end
	end
};
StaticPopupDialogs["QUEST_ACCEPT"] = {
	text = TEXT(QUEST_ACCEPT),
	button1 = TEXT(YES),
	button2 = TEXT(NO),
	OnAccept = function()
		ConfirmAcceptQuest();
	end,
	timeout = 0,
	exclusive = 1,
	hideOnEscape = 1
};
StaticPopupDialogs["ABANDON_PET"] = {
	text = TEXT(ABANDON_PET),
	button1 = TEXT(OKAY),
	button2 = TEXT(CANCEL),
	OnAccept = function()
		PetAbandon();
	end,
	timeout = 0,
	exclusive = 1,
	hideOnEscape = 1
};
StaticPopupDialogs["ABANDON_QUEST"] = {
	text = TEXT(ABANDON_QUEST_CONFIRM),
	button1 = TEXT(YES),
	button2 = TEXT(NO),
	OnAccept = function()
		AbandonQuest();
		PlaySound("igQuestLogAbandonQuest");
	end,
	timeout = 0,
	whileDead = 1,
	exclusive = 1,
	hideOnEscape = 1
};
StaticPopupDialogs["ADD_FRIEND"] = {
	text = TEXT(ADD_FRIEND_LABEL),
	button1 = TEXT(ACCEPT),
	button2 = TEXT(CANCEL),
	hasEditBox = 1,
	maxLetters = 12,
	OnAccept = function()
		local editBox = getglobal(this:GetParent():GetName().."EditBox");
		AddFriend(editBox:GetText());
	end,
	OnShow = function()
		getglobal(this:GetName().."EditBox"):SetFocus();
	end,
	OnHide = function()
		if ( ChatFrameEditBox:IsVisible() ) then
			ChatFrameEditBox:SetFocus();
		end
		getglobal(this:GetName().."EditBox"):SetText("");
	end,
	EditBoxOnEnterPressed = function()
		local editBox = getglobal(this:GetParent():GetName().."EditBox");
		AddFriend(editBox:GetText());
		this:GetParent():Hide();
	end,
	EditBoxOnEscapePressed = function()
		this:GetParent():Hide();
	end,
	timeout = 0,
	exclusive = 1,
	whileDead = 1,
	hideOnEscape = 1
};
StaticPopupDialogs["ADD_IGNORE"] = {
	text = TEXT(ADD_IGNORE_LABEL),
	button1 = TEXT(ACCEPT),
	button2 = TEXT(CANCEL),
	hasEditBox = 1,
	maxLetters = 12,
	OnAccept = function()
		local editBox = getglobal(this:GetParent():GetName().."EditBox");
		AddIgnore(editBox:GetText());
	end,
	OnShow = function()
		getglobal(this:GetName().."EditBox"):SetFocus();
	end,
	OnHide = function()
		if ( ChatFrameEditBox:IsVisible() ) then
			ChatFrameEditBox:SetFocus();
		end
		getglobal(this:GetName().."EditBox"):SetText("");
	end,
	EditBoxOnEnterPressed = function()
		local editBox = getglobal(this:GetParent():GetName().."EditBox");
		AddIgnore(editBox:GetText());
		this:GetParent():Hide();
	end,
	EditBoxOnEscapePressed = function()
		this:GetParent():Hide();
	end,
	timeout = 0,
	exclusive = 1,
	whileDead = 1,
	hideOnEscape = 1
};
StaticPopupDialogs["ADD_GUILDMEMBER"] = {
	text = TEXT(ADD_GUILDMEMBER_LABEL),
	button1 = TEXT(ACCEPT),
	button2 = TEXT(CANCEL),
	hasEditBox = 1,
	maxLetters = 12,
	OnAccept = function()
		local editBox = getglobal(this:GetParent():GetName().."EditBox");
		GuildInviteByName(editBox:GetText());
	end,
	OnShow = function()
		getglobal(this:GetName().."EditBox"):SetFocus();
	end,
	OnHide = function()
		if ( ChatFrameEditBox:IsVisible() ) then
			ChatFrameEditBox:SetFocus();
		end
		getglobal(this:GetName().."EditBox"):SetText("");
	end,
	EditBoxOnEnterPressed = function()
		local editBox = getglobal(this:GetParent():GetName().."EditBox");
		GuildInviteByName(editBox:GetText());
		this:GetParent():Hide();
	end,
	EditBoxOnEscapePressed = function()
		this:GetParent():Hide();
	end,
	timeout = 0,
	exclusive = 1,
	whileDead = 1,
	hideOnEscape = 1
};
StaticPopupDialogs["ADD_RAIDMEMBER"] = {
	text = TEXT(ADD_RAIDMEMBER_LABEL),
	button1 = TEXT(ACCEPT),
	button2 = TEXT(CANCEL),
	hasEditBox = 1,
	maxLetters = 12,
	OnAccept = function()
		local editBox = getglobal(this:GetParent():GetName().."EditBox");
		InviteByName(editBox:GetText());
	end,
	OnShow = function()
		getglobal(this:GetName().."EditBox"):SetFocus();
	end,
	OnHide = function()
		if ( ChatFrameEditBox:IsVisible() ) then
			ChatFrameEditBox:SetFocus();
		end
		getglobal(this:GetName().."EditBox"):SetText("");
	end,
	EditBoxOnEnterPressed = function()
		local editBox = getglobal(this:GetParent():GetName().."EditBox");
		InviteByName(editBox:GetText());
		this:GetParent():Hide();
	end,
	EditBoxOnEscapePressed = function()
		this:GetParent():Hide();
	end,
	timeout = 0,
	exclusive = 1,
	hideOnEscape = 1
};
StaticPopupDialogs["REMOVE_GUILDMEMBER"] = {
	text = format(TEXT(REMOVE_GUILDMEMBER_LABEL), "XXX"),
	button1 = TEXT(YES),
	button2 = TEXT(NO),
	OnAccept = function()
		GuildUninviteByName(GuildFrame.selectedName);
		GuildMemberDetailFrame:Hide();
	end,
	OnShow = function()
		getglobal(this:GetName().."Text"):SetText(format(TEXT(REMOVE_GUILDMEMBER_LABEL), GuildFrame.selectedName));
	end,
	timeout = 0,
	exclusive = 1,
	whileDead = 1,
	hideOnEscape = 1
};
StaticPopupDialogs["ADD_GUILDRANK"] = {
	text = TEXT(ADD_GUILDRANK_LABEL),
	button1 = TEXT(ACCEPT),
	button2 = TEXT(CANCEL),
	hasEditBox = 1,
	maxLetters = 15,
	OnAccept = function()
		local editBox = getglobal(this:GetParent():GetName().."EditBox");
		GuildControlAddRank(editBox:GetText());
		GuildControlSetRank(UIDropDownMenu_GetSelectedID(GuildControlPopupFrameDropDown));
		UIDropDownMenu_SetSelectedID(GuildControlPopupFrameDropDown, UIDropDownMenu_GetSelectedID(GuildControlPopupFrameDropDown));
		GuildControlPopupFrameEditBox:SetText(GuildControlGetRankName(UIDropDownMenu_GetSelectedID(GuildControlPopupFrameDropDown)));
		GuildControlCheckboxUpdate(GuildControlGetRankFlags());
		CloseDropDownMenus();
	end,
	OnShow = function()
		getglobal(this:GetName().."EditBox"):SetFocus();
	end,
	OnHide = function()
		if ( ChatFrameEditBox:IsVisible() ) then
			ChatFrameEditBox:SetFocus();
		end
		getglobal(this:GetName().."EditBox"):SetText("");
	end,
	EditBoxOnEnterPressed = function()
		local editBox = getglobal(this:GetParent():GetName().."EditBox");
		GuildControlAddRank(editBox:GetText());
		GuildControlSetRank(UIDropDownMenu_GetSelectedID(GuildControlPopupFrameDropDown));
		UIDropDownMenu_SetSelectedID(GuildControlPopupFrameDropDown, UIDropDownMenu_GetSelectedID(GuildControlPopupFrameDropDown));
		GuildControlPopupFrameEditBox:SetText(GuildControlGetRankName(UIDropDownMenu_GetSelectedID(GuildControlPopupFrameDropDown)));
		GuildControlCheckboxUpdate(GuildControlGetRankFlags());
		CloseDropDownMenus();
		this:GetParent():Hide();
	end,
	EditBoxOnEscapePressed = function()
		this:GetParent():Hide();
	end,
	timeout = 0,
	exclusive = 1,
	whileDead = 1,
	hideOnEscape = 1
};
StaticPopupDialogs["SET_GUILDMOTD"] = {
	text = TEXT(SET_GUILDMOTD_LABEL),
	button1 = TEXT(ACCEPT),
	button2 = TEXT(CANCEL),
	hasEditBox = 1,
	maxLetters = 128,
	hasWideEditBox = 1,
	OnAccept = function()
		local editBox = getglobal(this:GetParent():GetName().."WideEditBox");
		GuildSetMOTD(editBox:GetText());
	end,
	OnShow = function()
		--getglobal(this:GetName().."WideEditBox"):SetText(GetGuildRosterMOTD());
		getglobal(this:GetName().."WideEditBox"):SetText(CURRENT_GUILD_MOTD);
		getglobal(this:GetName().."WideEditBox"):SetFocus();
	end,
	OnHide = function()
		if ( ChatFrameEditBox:IsVisible() ) then
			ChatFrameEditBox:SetFocus();
		end
		getglobal(this:GetName().."WideEditBox"):SetText("");
	end,
	EditBoxOnEnterPressed = function()
		local editBox = getglobal(this:GetParent():GetName().."WideEditBox");
		GuildSetMOTD(editBox:GetText());
		this:GetParent():Hide();
	end,
	EditBoxOnEscapePressed = function()
		this:GetParent():Hide();
	end,
	timeout = 0,
	exclusive = 1,
	whileDead = 1,
	hideOnEscape = 1
};
StaticPopupDialogs["SET_GUILDPLAYERNOTE"] = {
	text = TEXT(SET_GUILDPLAYERNOTE_LABEL),
	button1 = TEXT(ACCEPT),
	button2 = TEXT(CANCEL),
	hasEditBox = 1,
	maxLetters = 31,
	hasWideEditBox = 1,
	OnAccept = function()
		local editBox = getglobal(this:GetParent():GetName().."WideEditBox");
		GuildRosterSetPublicNote(GetGuildRosterSelection(), editBox:GetText());
	end,
	OnShow = function()
		local name, rank, rankIndex, level, class, zone, note, officernote, online;
		name, rank, rankIndex, level, class, zone, note, officernote, online = GetGuildRosterInfo(GetGuildRosterSelection());

		getglobal(this:GetName().."WideEditBox"):SetText(note);
		getglobal(this:GetName().."WideEditBox"):SetFocus();
	end,
	OnHide = function()
		if ( ChatFrameEditBox:IsVisible() ) then
			ChatFrameEditBox:SetFocus();
		end
		getglobal(this:GetName().."WideEditBox"):SetText("");
	end,
	EditBoxOnEnterPressed = function()
		local editBox = getglobal(this:GetParent():GetName().."WideEditBox");
		GuildRosterSetPublicNote(GetGuildRosterSelection(), editBox:GetText());
		this:GetParent():Hide();
	end,
	EditBoxOnEscapePressed = function()
		this:GetParent():Hide();
	end,
	timeout = 0,
	exclusive = 1,
	whileDead = 1,
	hideOnEscape = 1
};
StaticPopupDialogs["SET_GUILDOFFICERNOTE"] = {
	text = TEXT(SET_GUILDOFFICERNOTE_LABEL),
	button1 = TEXT(ACCEPT),
	button2 = TEXT(CANCEL),
	hasEditBox = 1,
	maxLetters = 31,
	hasWideEditBox = 1,
	OnAccept = function()
		local editBox = getglobal(this:GetParent():GetName().."WideEditBox");
		GuildRosterSetOfficerNote(GetGuildRosterSelection(), editBox:GetText());
	end,
	OnShow = function()
		local name, rank, rankIndex, level, class, zone, note, officernote, online;
		name, rank, rankIndex, level, class, zone, note, officernote, online = GetGuildRosterInfo(GetGuildRosterSelection());

		getglobal(this:GetName().."WideEditBox"):SetText(officernote);
		getglobal(this:GetName().."WideEditBox"):SetFocus();
	end,
	OnHide = function()
		if ( ChatFrameEditBox:IsVisible() ) then
			ChatFrameEditBox:SetFocus();
		end
		getglobal(this:GetName().."WideEditBox"):SetText("");
	end,
	EditBoxOnEnterPressed = function()
		local editBox = getglobal(this:GetParent():GetName().."WideEditBox");
		GuildRosterSetOfficerNote(GetGuildRosterSelection(), editBox:GetText());
		this:GetParent():Hide();
	end,
	EditBoxOnEscapePressed = function()
		this:GetParent():Hide();
	end,
	timeout = 0,
	exclusive = 1,
	whileDead = 1,
	hideOnEscape = 1
};
StaticPopupDialogs["RENAME_PET"] = {
	text = TEXT(PET_RENAME_LABEL),
	button1 = TEXT(ACCEPT),
	button2 = TEXT(CANCEL),
	hasEditBox = 1,
	maxLetters = 12,
	OnAccept = function()
		local text = getglobal(this:GetParent():GetName().."EditBox"):GetText();
		local dialogFrame = StaticPopup_Show("PETRENAMECONFIRM", text);
		if ( dialogFrame ) then
			dialogFrame.data = text;
		end
	end,
	EditBoxOnEnterPressed = function()
		local text = getglobal(this:GetParent():GetName().."EditBox"):GetText();
		local dialogFrame = StaticPopup_Show("PETRENAMECONFIRM", text);
		if ( dialogFrame ) then
			dialogFrame.data = text;
		end
		this:GetParent():Hide();
	end,
	OnShow = function()
		getglobal(this:GetName().."EditBox"):SetFocus();
	end,
	OnHide = function()
		if ( ChatFrameEditBox:IsVisible() ) then
			ChatFrameEditBox:SetFocus();
		end
		getglobal(this:GetName().."EditBox"):SetText("");
	end,
	timeout = 0,
	exclusive = 1,
	hideOnEscape = 1
};
StaticPopupDialogs["DUEL_REQUESTED"] = {
	text = TEXT(DUEL_REQUESTED),
	button1 = TEXT(ACCEPT),
	button2 = TEXT(DECLINE),
	sound = "igPlayerInvite",
	OnAccept = function()
		AcceptDuel();
	end,
	OnCancel = function()
		CancelDuel();
	end,
	timeout = 60,
	hideOnEscape = 1
};
StaticPopupDialogs["DUEL_OUTOFBOUNDS"] = {
	text = TEXT(DUEL_OUTOFBOUNDS_TIMER),
	timeout = 10,
};
StaticPopupDialogs["UNLEARN_SKILL"] = {
	text = TEXT(UNLEARN_SKILL),
	button1 = TEXT(UNLEARN),
	button2 = TEXT(CANCEL),
	OnAccept = function(index)
		AbandonSkill(index);
	end,
	timeout = 60,
	exclusive = 1,
	whileDead = 1,
	showAlert = 1,
	hideOnEscape = 1
};
StaticPopupDialogs["XP_LOSS"] = {
	text = TEXT(CONFIRM_XP_LOSS),
	button1 = TEXT(ACCEPT),
	button2 = TEXT(CANCEL),
	OnAccept = function(data)
		if ( data ) then
			getglobal(this:GetParent():GetName().."Text"):SetText(format(TEXT(CONFIRM_XP_LOSS_AGAIN), data));
			this:GetParent().data = nil;
			return 1;
		else
			AcceptXPLoss();
		end
	end,
	OnUpdate = function(elapsed, dialog)
		if ( not CheckSpiritHealerDist() ) then
			dialog:Hide();
		end
	end,
	timeout = 0,
	exclusive = 1,
	whileDead = 1,
	showAlert = 1,
	hideOnEscape = 1
};
StaticPopupDialogs["XP_LOSS_NO_SICKNESS"] = {
	text = TEXT(CONFIRM_XP_LOSS_NO_SICKNESS),
	button1 = TEXT(ACCEPT),
	button2 = TEXT(CANCEL),
	OnAccept = function(data)
		if ( data ) then
			getglobal(this:GetParent():GetName().."Text"):SetText(TEXT(CONFIRM_XP_LOSS_AGAIN_NO_SICKNESS));
			this:GetParent().data = nil;
			return 1;
		else
			AcceptXPLoss();
		end
	end,
	OnUpdate = function(elapsed, dialog)
		if ( not CheckSpiritHealerDist() ) then
			dialog:Hide();
		end
	end,
	timeout = 0,
	exclusive = 1,
	whileDead = 1,
	showAlert = 1,
	hideOnEscape = 1
};
StaticPopupDialogs["RECOVER_CORPSE"] = {
	StartDelay = GetCorpseRecoveryDelay,
	delayText = TEXT(RECOVER_CORPSE_TIMER),
	text = TEXT(RECOVER_CORPSE),
	button1 = TEXT(ACCEPT),
	OnAccept = function()
		RetrieveCorpse();
		return 1;
	end,
	timeout = 0,
	whileDead = 1,
	interruptCinematic = 1,
	notClosableByLogout = 1
};
StaticPopupDialogs["RECOVER_CORPSE_INSTANCE"] = {
	text = TEXT(RECOVER_CORPSE_INSTANCE),
	timeout = 0,
	whileDead = 1,
	interruptCinematic = 1,
	notClosableByLogout = 1
};
-- The old version of the dialog... the new one auto-accepts for you.
-- StaticPopupDialogs["AREA_SPIRIT_HEAL"] = {
-- 	text = TEXT(AREA_SPIRIT_HEAL),
-- 	button1 = TEXT(ACCEPT),
-- 	button2 = TEXT(CANCEL),
-- 	OnShow = function()
-- 		this.timeleft = GetAreaSpiritHealerTime();
-- 	end,
-- 	OnAccept = function()
-- 		AcceptAreaSpiritHeal();
-- 		getglobal(this:GetParent():GetName().."Button1"):Hide();
-- 		getglobal(this:GetParent():GetName().."Button2"):Hide();
-- 		return 1;
-- 	end,
-- 	timeout = 0,
-- 	whileDead = 1,
-- 	interruptCinematic = 1,
-- 	notClosableByLogout = 1,
-- 	hideOnEscape = 1
-- };

StaticPopupDialogs["AREA_SPIRIT_HEAL"] = {
	text = TEXT(AREA_SPIRIT_HEAL),
	button1 = TEXT(CANCEL),
	OnShow = function()
		this.timeleft = GetAreaSpiritHealerTime();
		AcceptAreaSpiritHeal();
	end,
	OnAccept = function()
		CancelAreaSpiritHeal();
	end,
	timeout = 0,
	whileDead = 1,
	interruptCinematic = 1,
	notClosableByLogout = 1,
	hideOnEscape = 1
};
StaticPopupDialogs["BIND_ENCHANT"] = {
	text = TEXT(BIND_ENCHANT),
	button1 = TEXT(OKAY),
	button2 = TEXT(CANCEL),
	OnAccept = function()
		BindEnchant();
	end,
	timeout = 0,
	exclusive = 1,
	showAlert = 1,
	hideOnEscape = 1
};
StaticPopupDialogs["REPLACE_ENCHANT"] = {
	text = TEXT(REPLACE_ENCHANT),
	button1 = TEXT(YES),
	button2 = TEXT(NO),
	OnAccept = function()
		ReplaceEnchant();
	end,
	timeout = 0,
	exclusive = 1,
	showAlert = 1,
	hideOnEscape = 1
};
StaticPopupDialogs["TRADE_REPLACE_ENCHANT"] = {
	text = TEXT(REPLACE_ENCHANT),
	button1 = TEXT(YES),
	button2 = TEXT(NO),
	OnAccept = function()
		ReplaceTradeEnchant();
	end,
	timeout = 0,
	exclusive = 1,
	showAlert = 1,
	hideOnEscape = 1
};
StaticPopupDialogs["INSTANCE_BOOT"] = {
	text = TEXT(INSTANCE_BOOT_TIMER),
	OnShow = function()
		this.timeleft = GetInstanceBootTimeRemaining();
		if ( this.timeleft <= 0 ) then
			StaticPopup_Hide("INSTANCE_BOOT");
		end
	end,
	timeout = 0,
	whileDead = 1,
	interruptCinematic = 1,
	notClosableByLogout = 1
};
StaticPopupDialogs["CONFIRM_TALENT_WIPE"] = {
	text = TEXT(CONFIRM_TALENT_WIPE),
	button1 = TEXT(ACCEPT),
	button2 = TEXT(CANCEL),
	OnAccept = function()
		ConfirmTalentWipe();
	end,
	OnUpdate = function(elapsed, dialog)
		if ( not CheckTalentMasterDist() ) then
			dialog:Hide();
		end
	end,
	hasMoneyFrame = 1,
	timeout = 0,
	hideOnEscape = 1
};
StaticPopupDialogs["CONFIRM_PET_UNLEARN"] = {
	text = TEXT(CONFIRM_PET_UNLEARN),
	button1 = TEXT(ACCEPT),
	button2 = TEXT(CANCEL),
	OnAccept = function()
		ConfirmPetUnlearn();
	end,
	OnUpdate = function(elapsed, dialog)
		if ( not CheckPetUntrainerDist() ) then
			dialog:Hide();
		end
	end,
	hasMoneyFrame = 1,
	timeout = 0,
	hideOnEscape = 1
};
StaticPopupDialogs["CONFIRM_BINDER"] = {
	text = TEXT(CONFIRM_BINDER),
	button1 = TEXT(ACCEPT),
	button2 = TEXT(CANCEL),
	OnAccept = function()
		ConfirmBinder();
	end,
	OnUpdate = function(elapsed, dialog)
		if ( not CheckBinderDist() ) then
			dialog:Hide();
		end
	end,
	timeout = 0,
	hideOnEscape = 1
};
StaticPopupDialogs["CONFIRM_SUMMON"] = {
	text = TEXT(CONFIRM_SUMMON);
	button1 = TEXT(ACCEPT),
	button2 = TEXT(CANCEL),
	OnShow = function()
		this.timeleft = GetSummonConfirmTimeLeft();
	end,
	OnAccept = function()
		ConfirmSummon();
	end,
	OnUpdate = function(elapsed, dialog)
		local button = getglobal(dialog:GetName().."Button1");
		if ( UnitAffectingCombat("player") ) then
			button:Disable();
		else
			button:Enable();
		end
	end,
	timeout = 0,
	interruptCinematic = 1,
	notClosableByLogout = 1,
	hideOnEscape = 1
};
StaticPopupDialogs["BILLING_NAG"] = {
	text = TEXT(BILLING_NAG_DIALOG);
	button1 = TEXT(OKAY),
	timeout = 0,
	showAlert = 1
};
StaticPopupDialogs["IGR_BILLING_NAG"] = {
	text = TEXT(IGR_BILLING_NAG_DIALOG);
	button1 = TEXT(OKAY),
	timeout = 0,
	showAlert = 1
};
-- StaticPopupDialogs["CONFIRM_LOOT_ROLL"] = {
-- 	text = TEXT(LOOT_NO_DROP),
-- 	button1 = TEXT(OKAY),
-- 	button2 = TEXT(CANCEL),
-- 	OnAccept = function(id, rollType)
-- 		ConfirmLootRoll(id, rollType);
-- 	end,
-- 	timeout = 0,
-- 	whileDead = 1,
-- 	exclusive = 1,
-- 	hideOnEscape = 1
-- };
