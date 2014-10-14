ChatrShoo_LastUpd=0;
ChatrShoo_LastActivity={};
Chatr_ShooTimeout=0;

function ChatrShoo_OnUpdate(elapsed)
  ChatrShoo_LastUpd = ChatrShoo_LastUpd + elapsed;
  if (ChatrShoo_LastUpd > 1) then
    ChatrShoo_Check();
    ChatrShoo_LastUpd = 0;
  end
end

function ChatrShoo_Init()
	Chatr_SaveThis("ShooTimeout");
	Chatr_CallMe("ShowSettings",ChatrShoo_ShowSettings);
	Chatr_CallMe("SettingsLoaded",ChatrShoo_PostInit);
	Chatr_CallMe("OpenChatr",ChatrShoo_ResetTimeout);
	Chatr_CallMe("IncomingWhisper",ChatrShoo_ResetTimeout);
	Chatr_CallMe("OutgoingWhisper",ChatrShoo_ResetTimeout);
end

function ChatrShoo_PostInit()
	Chatr_Print(GetAddOnMetadata("ChatrShoo","Title").." loaded.");
	ChatrShooOptionsTitle:SetText(GetAddOnMetadata("ChatrShoo","Title"));	
	Chatr_AddPlugin("ChatrShoo");
end

function ChatrShoo_ShowSettings(tab)
	ChatrShooTimeout:SetValue(Chatr_ShooTimeout);
	ChatrShoo_SetLabel();
end

function ChatrShoo_ResetTimeout(tab)
	ChatrShoo_LastActivity[tab[2].target]=time();
	Chatr_Debug("Shoo: Set activity for "..tab[2].target);
end

function ChatrShoo_Check()
	local c,i,k,v;
	if Chatr_ShooTimeout>0 then
		for k,v in ChatrShoo_LastActivity do
			i=Chatr_FindByName(k);
			if i>-1 then
				c=getglobal("Chatr"..i);
				if time()-v>Chatr_ShooTimeout and Chatr_EditFocus==nil and c.minimized==0 then
					Chatr_Close(c);
					ChatrShoo_LastActivity[k]=nil;
					Chatr_Debug("Shoo: Closed "..k);
				end

			else
				ChatrShoo_LastActivity[k]=nil;
				Chatr_Debug("Shoo: Removed "..k);
			end
		end
	end
end

function ChatrShoo_SetLabel()
	if Chatr_ShooTimeout==0 then
		ChatrShooTimeoutLabel:SetText("Disabled");
	elseif Chatr_ShooTimeout>=60 then
		ChatrShooTimeoutLabel:SetText(format("%d:%02d",floor(Chatr_ShooTimeout/60),mod(Chatr_ShooTimeout,60)));
	else
		ChatrShooTimeoutLabel:SetText(tostring(Chatr_ShooTimeout));
	end
end