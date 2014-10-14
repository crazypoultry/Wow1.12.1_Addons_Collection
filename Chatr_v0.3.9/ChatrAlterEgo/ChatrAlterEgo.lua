ChatrAlterEgo_List="# No Alter Egoes set.";
function ChatrAlterEgo_Init()
	Chatr_SaveThis("AlterEgoList");
	Chatr_CallMe("SettingsLoaded",ChatrAlterEgo_PostInit);
end

function ChatrAlterEgo_PostInit()
	ChatrAlterEgoList:SetText(ChatrAlterEgo_List);
	Chatr_Print(GetAddOnMetadata("ChatrAlterEgo","Title").." loaded.");
	ChatrAlterEgoOptionsTitle:SetText(GetAddOnMetadata("ChatrAlterEgo","Title"));
	ChatrAlterEgoHelpText:SetText("Lines starting with # are ignored.\nLine format: <oldname>:<newname>\nIf oldname starts with ~, it's considered\na Lua pattern to FIND");
	ChatrAlterEgoHelpText:SetFont("Fonts\\ARIALN.TTF",12);
	Chatr_AddPlugin("ChatrAlterEgo");
	Chatr_NameHook=ChatrAlterEgo_NameHook;
end


function ChatrAlterEgo_NameHook(name)
	local cnt,lst,line,lcnt,parts;
	cnt,lst=Chatr_Split("\n",ChatrAlterEgo_List,0);
	for _,line in lst do
		if strsub(line,1,1)~="#" and line~="" then
			
			lcnt,parts=Chatr_Split(":",line,0);
			if parts[1]==name then
				name=parts[2];
			end
			if strsub(parts[1],1,1)=="~" and strfind(name,strsub(parts[1],2))~=nil then
				name=parts[2];
			end
		end
	end
	return name;
end