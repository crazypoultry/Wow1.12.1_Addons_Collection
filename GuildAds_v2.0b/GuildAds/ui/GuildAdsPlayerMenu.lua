local currentLevel;

GuildAdsPlayerMenu = {

	initialize = function(owner, level)
		currentLevel = level;
		local online = GuildAdsComm:IsOnLine(owner);
		
		info = { };
		info.text =  owner;
		info.notCheckable = 1;
		info.textR = GuildAdsUITools.onlineColor[online].r;
		info.textG = GuildAdsUITools.onlineColor[online].g;
		info.textB = GuildAdsUITools.onlineColor[online].b;
		UIDropDownMenu_AddButton(info, level);

		info = { };
		info.text =  WHISPER_MESSAGE;
		info.notCheckable = 1;
		info.value = owner;
		info.func = GuildAdsPlayerMenu.whisper;
		UIDropDownMenu_AddButton(info, level);

		info = { };
		info.text =  INSPECT;
		info.notCheckable = 1;
		info.value = owner;
		if GuildAdsInspectWindow then
			info.func = GuildAdsPlayerMenu.inspect;
		else
			info.func = GuildAdsPlayerMenu.inspectDefault;
		end
		UIDropDownMenu_AddButton(info, level);


		info = { };
		info.text =  CHAT_INVITE_SEND;
		info.notCheckable = 1;
		info.value = owner;
		info.func = GuildAdsPlayerMenu.invite;
		UIDropDownMenu_AddButton(info, level);
		
		info = { };
		info.text =  TEXT(TRADE);
		info.notCheckable = 1;
		info.value = owner;
		info.func = GuildAdsPlayerMenu.trade;
		UIDropDownMenu_AddButton(info, level);
		
		info = { };
		info.text =  TEXT(FOLLOW);
		info.notCheckable = 1;
		info.value = owner;
		info.func = GuildAdsPlayerMenu.follow;
		UIDropDownMenu_AddButton(info, level);
	
		info = { };
		info.text =  WHO;
		info.notCheckable = 1;
		info.value = owner;
		info.func = GuildAdsPlayerMenu.who;
		UIDropDownMenu_AddButton(info, level);

		info = { };
		info.text = CANCEL;
		info.notCheckable = 1;
		info.func = GuildAdsPlayerMenu.cancel;
		UIDropDownMenu_AddButton(info, level);
	end;
	
	cancel = function()
		HideDropDownMenu(currentLevel);
	end;
	
	whisper = function()
		local owner = this.value;
		if owner then
			if ( not ChatFrameEditBox:IsVisible() ) then
				ChatFrame_OpenChat("/w "..owner.." ");
			else
				ChatFrameEditBox:SetText("/w "..owner.." ");
			end
			ChatEdit_ParseText(ChatFrame1.editBox, 0);
		end
	end;
	
	inspect = function()
		local owner = this.value;
		if owner then
			GuildAdsInspectWindow:Inspect(owner);
			GuildAdsInventory:Update(true);
		end
	end;
	
	inspectDefault = function()
		local owner = this.value;
		if owner then
			TargetByName(owner)
			if UnitName("target")==owner and CheckInteractDistance("target", 2) then
				InspectUnit("target")
			else
				TargetLastTarget()
			end
		end
	end;
	
	invite = function()
		local owner = this.value;
		if owner then
			InviteByName(owner);
		end
	end;
	
	trade = function()
		local owner = this.value;
		if owner then
			TargetByName(owner);
			if UnitName("target")==owner and CheckInteractDistance("target", 2) then
				InitiateTrade("target");
			else
				TargetLastTarget()
			end
		end
	end;
	
	follow = function()
		local owner = this.value;
		if owner then
			TargetByName(owner);
			if UnitName("target")==owner and CheckInteractDistance("target", 4) then
				FollowUnit(unit);
			else
				TargetLastTarget()
			end
		end
	end;
	
	who = function()
		local owner = this.value;
		if owner then
			local text = ChatFrameEditBox:GetText();
			ChatFrameEditBox:SetText("/who "..owner);
			ChatEdit_SendText(ChatFrameEditBox);
			ChatFrameEditBox:SetText(text);
		end
	end;

};
