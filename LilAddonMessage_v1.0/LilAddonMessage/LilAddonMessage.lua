function LilAddonMessage_OnLoad()
	SlashCmdList["LILADDONMESSAGE"] = LilAddonMessage_Command; 
	SLASH_LILADDONMESSAGE1 = "/liladdonmessage"; 
	SLASH_LILADDONMESSAGE2 = "/am";
	LilAddonMessageData = {};
	LilAddonMessageMain:Hide();
end

function LilAddonMessage_Command(msg)
	if(msg == nil or msg == "") then
		LilAddonMessage_Toggle();
	else
		DEFAULT_CHAT_FRAME:AddMessage("USAGE: /am			Toggle whether the window is shown or not");
	end
end

function LilAddonMessage_UpdateScrollBars(smf)
	local parentName = smf:GetParent():GetName();
	if(smf:AtTop()) then
		getglobal(parentName.."ScrollUp"):Disable();
	else
		getglobal(parentName.."ScrollUp"):Enable();
	end
	if(smf:AtBottom()) then
		getglobal(parentName.."ScrollDown"):Disable();
	else
		getglobal(parentName.."ScrollDown"):Enable();
	end
end

function LilAddonMessage_AddonMessage()
	LilAddonMessageMainScrollingMessageFrame:AddMessage(date("|cffFFFFFF[%T]",time()).. ":|cffFF8C00 "..arg1.." | "..arg2.." | "..arg3.." | "..arg4);
end

function LilAddonMessage_Toggle()
	if(LilAddonMessageMain:IsVisible()) then
		LilAddonMessageMain:Hide();
	else
		LilAddonMessageMain:Show();
	end
end
