-- Thanks Flaye for teaching me how to use xml

BGInvite_TitleText = "BGInvite " ..BGvar_version;

function BGInviteUI_OnShow()
	BGInviteUI:Show();
	BGInviteTitle:SetText (BGInvite_TitleText);
	BGInviteTitle:Show();
	BGInviteAutoInviteEnable:SetChecked(BGInvite_GetNumber(BGvar_save.auto));
	BGInviteAutoPurgeEnable:SetChecked (BGInvite_GetNumber(BGvar_save.purge));
	BGInviteMagicwordEditBox:SetText(BGvar_save.magicword)
	BGInviteBlacklistEditBox:SetText("NewName")
	BGInviteScrollBar:Show()
	BGvar_CopiedBlacklist = {}
end

function BGInvite_CheckBoxCommand (command)
    if (command == nil) then
        return;
    end  
    if (command == "autoinvite") then
        if (BGvar_save.auto == "enabled") then
            BGvar_save.auto = "disabled"
			BGinvite_print(BGlocal_NOT_AUTO_INVITING)
        else
            BGvar_save.auto = "enabled"
			BGinvite_print(BGlocal_AUTO_INVITING)
        end
    elseif (command == "autopurge") then
        if (BGvar_save.purge == "enabled") then
            BGvar_save.purge = "disabled"
			BGinvite_print(BGlocal_NOT_PURGING)
        else
            BGvar_save.purge = "enabled"
			BGinvite_print(BGlocal_NOW_PURGING)
        end
    end
end

function BGInvite_GetNumber (boolean)
    if (boolean == "enabled") then
        return 1;
    else
        return 0;
    end
end

function BGinvite_CopyBlacklist()
	BGvar_CopiedBlacklist = {}
	table.foreach(BGvar_blacklist, BGinvite_CheckBlacklistNames)
end

function BGinvite_CheckBlacklistNames(name)
	if BGvar_blacklist[name] == 1 then
		table.insert(BGvar_CopiedBlacklist, name)
	end
end



function BGinviteScrollBar_Update()
	BGinvite_CopyBlacklist()
	local line; -- 1 through 5 of our window to scroll
	local lineplusoffset; -- an index into our data calculated from the scroll offset
	FauxScrollFrame_Update(BGInviteScrollBar,table.getn(BGvar_CopiedBlacklist),7,40);
	for line=1,7 do
		local lineplusoffset = line + FauxScrollFrame_GetOffset(BGInviteScrollBar);
		if lineplusoffset <= table.getn(BGvar_CopiedBlacklist) then
			getglobal("BGInviteEntry"..line.."Text"):SetText(BGvar_CopiedBlacklist[lineplusoffset])
			getglobal("BGInviteEntry"..line):Show()
		else
			getglobal("BGInviteEntry"..line):Hide()
		end
	end
end