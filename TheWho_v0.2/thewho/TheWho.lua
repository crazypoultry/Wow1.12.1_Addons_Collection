local OldWhoCommand;
local guildnotes = {};
local awaiting_update = "";
local debug = 0;
function TW_OnLoad()

	this:RegisterEvent("GUILD_ROSTER_UPDATE");

OldWhoCommand = SetItemRef;

SetItemRef = MyRef;

end


function TW_OnEvent()
	if (event == "GUILD_ROSTER_UPDATE") then
		Update_List();
	end

end

function Update_List()
	guildnotes = {};
	--DEFAULT_CHAT_FRAME:AddMessage("Guild updated...", 1, 1, 0.5);
	local gindex = 1;
	name, rank, rankIndex, level, class, zone, note, officernote, online, status = GetGuildRosterInfo(gindex);
	while (name) do
		if (online) then
			guildnotes[name] = note;
		end
		gindex = gindex + 1;
		name, rank, rankIndex, level, class, zone, note, officernote, online, status = GetGuildRosterInfo(gindex);
	end
	if (strlen(awaiting_update) > 0) then
		if (guildnotes[awaiting_update]) then
			Print_Note(awaiting_update);
		elseif (debug) then
			DEFAULT_CHAT_FRAME:AddMessage("["..awaiting_update.."] Guild Note: Probably not in guild.", 1, 1, 0.5);
		end
	end
	awaiting_update = "";
end

function Print_Note(name)
	info = ChatTypeInfo["SYSTEM"];
	DEFAULT_CHAT_FRAME:AddMessage("["..name.."] Guild Note: "..guildnotes[name], info.r, info.g, info.b);
end

function MyRef(link, text, button)
--DEFAULT_CHAT_FRAME:AddMessage("Click Intercepted: "..link.." text:"..text.." button:"..button, 1, 1, 0.5);
	if ( strsub(link, 1, 6) == "player" ) then
		local name = strsub(link, 8);
		if ( name and (strlen(name) > 0) ) then
			name = gsub(name, "([^%s]*)%s+([^%s]*)%s+([^%s]*)", "%3");
			name = gsub(name, "([^%s]*)%s+([^%s]*)", "%2");
			if ( IsShiftKeyDown() ) then
				local staticPopup;
				staticPopup = (StaticPopup_Visible("ADD_IGNORE"));
				staticPopup = ((staticPopup) or (StaticPopup_Visible("ADD_FRIEND")));
				staticPopup = ((staticPopup) or (StaticPopup_Visible("ADD_GUILDMEMBER")));
				staticPopup = ((staticPopup) or (StaticPopup_Visible("ADD_RAIDMEMBER")));

				if not ( ( ChatFrameEditBox:IsVisible() ) or (staticPopup) ) then
					
					if not (guildnotes[name] == nil) then
						Print_Note(name);
					else
						awaiting_update = name;
						--DEFAULT_CHAT_FRAME:AddMessage("["..name.."] Guild Note: nil", 1, 1, 0.5);
						GuildRoster();
					end
				end
			end
		end
	end
OldWhoCommand(link, text, button);
end
