----------------------------------------------------------------------------------
--
-- QuestLink.lua
--
-- Author: Derkyle www.manaflux.com
--
-- Allows you to see everyone's quest in the party that has this mod currently installed.
-- Similiar to QuestShare from Cosmos but not dependent on it.
-- [I would like to thank the creator of Cosmos for their contribution!]
-- [Would also like to thank telo for the inspiration for the chat hook]
---------------------------------------------------------------------------------

---------------------------------------------------------------------------------
-- /questlink
-- /ql

-- commands
-- /ql turnon or /questlink turnon = turns on questlink
-- turnoff = turns off questlink
-- ver = tells you the versions
---------------------------------------------------------------------------------

--globals
QUESTLINK_VER = "10.1";

--local
local QuestLink_ITEM_HEIGHT = 16;	--how high to make each item button
local QuestLink_ITEM_SHOWN = 23;	--how many items to show on the log window
local sLastMsg = "";


local QL_isProtected = 0;
local QL_oldevent;
local QL_collapseinfo = {};
local QL_lastselect = 0;
local QL_saveScrollBar = 0;
local QL_saveScrollVal = 0;

local storeString= "";
local LogStoreString= "";
local QuestLink_Target_Quests = { };


BINDING_HEADER_QUESTLINK = "QuestLink Activation Button";
BINDING_NAME_QUESTLINKACTIVATE = "Activate QuestLink on target user.";


---------------------------------------------------
-- QuestLink_OnLoad
-----------------------------------------------

function QuestLink_OnLoad()

	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("CHAT_MSG_ADDON");

	if( DEFAULT_CHAT_FRAME ) then
		DEFAULT_CHAT_FRAME:AddMessage("|c004ECA00Derkyle's QuestLink Loaded Ver: "..QUESTLINK_VER..".|r");
	end

	-- Register our slash command
	SLASH_QUESTLINK1 = "/questlink";
	SLASH_QUESTLINK2 = "/ql";
	SlashCmdList["QUESTLINK"] = function(msg)
		QuestLink_SlashCommandHandler(msg);
	end
	

	--this adds our frame to a special list of frames that will close when you press escape
	--supposely lol
	tinsert(UISpecialFrames, "QuestLinkFrame");
	
	
end



--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------


---------------------------------------------------
-- QuestLink_Activate
-----------------------------------------------
function QuestLink_Activate()

	local commType;
	
	if (not UnitName("target")) then
		DEFAULT_CHAT_FRAME:AddMessage("QuestLink: You must target something first!", 255/255, 0, 0 );
		return nil;
	end
	
	if (not UnitIsPlayer("target")) then --make sure they are a player
		DEFAULT_CHAT_FRAME:AddMessage("QuestLink: Targeted unit is not a player!", 255/255, 0, 0 );
		return nil;
	end
	
	--make sure they didn't target themselves
	if (UnitName("target") == UnitName("player")) then
		DEFAULT_CHAT_FRAME:AddMessage("QuestLink: You cannot target yourself!", 255/255, 0, 0 );
		return nil;
	end
	
	
		local guildName, guildRankName, guildRankIndex = GetGuildInfo("target"); --check if they are in a guild
		local guildNameP, guildRankNameP, guildRankIndexP = GetGuildInfo("player"); --get our info
		
	if (IsInGuild() and guildName and guildNameP) then --first check if were in a guild
		
		if (guildName == guildNameP) then --we are in the same guild so sent it through guild instead
			commType = "GUILD";
		end
		
	--if we are in a raid, and the unit is in the raid and is not a pet then use that instead
	elseif (GetNumRaidMembers() > 0 and UnitInRaid("target") and not UnitIsUnit("target", "pet")) then
	
		commType = "RAID";
	
	--if we are in a party, and the unit is in the party and is not a pet then use that instead
	elseif (GetNumPartyMembers() > 0 and UnitInParty("target") and not UnitIsUnit("target", "pet")) then
	
		commType = "PARTY";
		
	else
		DEFAULT_CHAT_FRAME:AddMessage("QuestLink: Unit is not in GUILD, RAID, or PARTY!", 255/255, 0, 0 );
		return nil;
	end
	

	--send the request
	ChatThrottleLib:SendAddonMessage("ALERT",  "QTL", "REQ#@"..UnitName("target"), commType);
	--display msg
	DEFAULT_CHAT_FRAME:AddMessage("QuestLink: Request sent to [|c00CC99FF"..UnitName("target").."|r].  |c00FF0000Please Wait!!|r", 156/256, 212/256, 1.0 );


end



--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------


---------------------------------------------------
-- QuestLink_OnEvent
-----------------------------------------------

function QuestLink_OnEvent(event)


	if(event == "VARIABLES_LOADED") then
	
		if( not QuestLink_State ) then
			QuestLink_State = { };
			QuestLink_State["State"] = 1;
		else
			if(QuestLink_State["State"] == nil) then
				QuestLink_State["State"] = 1;
			end
		end
		
	elseif ( event == "CHAT_MSG_ADDON" and arg1 == "QTL") then
	
		QuestLink_Process_Msg(arg4, arg2, arg3);
		
	end
	


end


---------------------------------------------------
-- QuestLink_SlashCommandHandler
-----------------------------------------------

function QuestLink_SlashCommandHandler(msg)

local command = string.lower(msg);


	if( command == "ver" ) then
		
		DEFAULT_CHAT_FRAME:AddMessage("QuestLink: Version |c0000FF00"..QUESTLINK_VER.."|r");

	elseif( command == "turnon" ) then
		
		QuestLink_ToggleOn();

	elseif( command == "turnoff" ) then

		QuestLink_ToggleOff();
		
	elseif( command == "chk" ) then
		
		QuestLink_Activate();
		
	elseif(strsub(command, 1, 5) == "bladd") then --black list add
	
		
		QuestLink_ProcessBL(1,command);
	
	
	elseif(strsub(command, 1, 5) == "blrem") then --black list rem
	
		
		QuestLink_ProcessBL(2,command);
		
	
	elseif( command == "blshow") then
	
	
		QuestLink_ShowBL();


	else
		QLHelpFrame_Frame:Show();
		QL_HelpFrameText:SetText("QuestLink Help:\n\nNote: In order to activate QuestLink on a target, you can bind a key to Questlink or use the /ql chk command.  To request quest logs from the current target simply press the bind Questlink key or type /ql chk.\n\n\n/ql chk  -request from current target\n/ql turnon  -turns on questlink\n/ql turnoff  -turns off questlink\n/ql ver  -returns version number\n/ql blshow - Shows BlackList Players\n/ql bladd username -Adds a user to the BlackList.\n/ql blrem username -Removes a user from the BlackList.\n\n");


	end



end


---------------------------------------------------
-- QuestLink_Toggle
---------------------------------------------------
function QuestLink_ToggleOn() 


	QuestLink_State["State"] = 1;
	DEFAULT_CHAT_FRAME:AddMessage("QuestLink: Activated");

end


---------------------------------------------------
-- QuestLink_Toggle
---------------------------------------------------
function QuestLink_ToggleOff() 

	QuestLink_State["State"] = 0;
	DEFAULT_CHAT_FRAME:AddMessage("QuestLink: Deactivated");

end



---------------------------------------------------
-- QuestLink_OnShow
-----------------------------------------------

function QuestLink_OnShow()

	--do nothing for now
	PlaySound("igBackPackOpen");
end


---------------------------------------------------
-- QuestLink_OnUpdate
-----------------------------------------------

function QuestLink_OnUpdate()

	--do nothing for now

end

---------------------------------------------------
-- QuestLink_OnHide
---------------------------------------------------
function QuestLink_OnHide()

	if ( QuestLinkFrame:IsVisible() ) then 
		QuestLinkFrame:Hide();
	end
	
	
end



---------------------------------------------------
-- QuestLinkItemButton_OnClick
---------------------------------------------------
function QuestLinkItemButton_OnClick(button)

	if (this.info and tonumber(this.info.header) == 0) then
	
		ChatThrottleLib:SendAddonMessage("ALERT",  "QTL", "LOG#@"..this.info.player.."#@"..this.info.title, this.info.commType);
		
		DEFAULT_CHAT_FRAME:AddMessage("QuestLink: Log Request sent to [|c00CC99FF"..this.info.player.."|r] for [|c00BDFCC9"..this.info.title.."|r].  |c00FF0000Please Wait!!|r", 156/256, 212/256, 1.0 );
		
	end

end

--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------

---------------------------------------------------
-- QuestLink_Process_Msg
---------------------------------------------------
function QuestLink_Process_Msg(sNick, sText, commType)
	
	if (not sNick or not sText) then return nil; end
	if (sLastMsg == sText) then return nil; else sLastMsg = sText; end
	
	
	--first check to see if they are on the blacklist
	if (QuestLink_CheckIfBlackListed(string.lower(sNick)) == 1) then
		ChatThrottleLib:SendAddonMessage("ALERT",  "QTL", "DENY#@"..sNick, commType);
		return nil;
	end
	
	local r = {QuestLink_Split(sText, "#@")};
	if (not r) then return nil; end
	
	--make sure it's for us
	if (r[2] == UnitName("player")) then
	
		if (r[1] == "DENY") then
			DEFAULT_CHAT_FRAME:AddMessage("QuestLink: Access denied, blacklisted by [|c004ECA00"..sNick.."|r].", 255/255, 0, 0 );
			return nil;
			
		elseif (r[1] == "DENYLOG") then
			DEFAULT_CHAT_FRAME:AddMessage("QuestLink: Previous request to user is still being processed.  Access Denied.", 255/255, 0, 0 );
			return nil;	

		elseif (r[1] == "NOLOG") then
			DEFAULT_CHAT_FRAME:AddMessage("QuestLink: User no longer has quest [|c00BDFCC9"..r[3].."|r] in their quest log.", 255/255, 0, 0 );
			return nil;	

		elseif (r[1] == "REQ") then
		
			DEFAULT_CHAT_FRAME:AddMessage("QuestLink: Request granted to [|c004ECA00"..sNick.."|r].", 156/256, 212/256, 1.0 );
			
			local sSend = "";
			local NumEntries, NumQuests = GetNumQuestLogEntries();
			for i=1, NumEntries do
				local title, level, questTag, isHeader, isCollapsed, isComplete = GetQuestLogTitle(i);
				if ( isHeader ) then
					if (sSend == "") then
						sSend = "1#^0#^"..title.."#^nil";
					else
						sSend = sSend.."#;".."1#^0#^"..title.."#^nil";
					end
				elseif ( not isHeader and title) then
					
					if (not level) then level = 0; end
					
					if (sSend == "") then
						if (questTag) then
							sSend = "0#^"..level.."#^"..title.."#^"..questTag;
						else
							sSend = "0#^"..level.."#^"..title.."#^nil";
						end
					else
						if (questTag) then
							sSend = sSend.."#;".."0#^"..level.."#^"..title.."#^"..questTag;
						else
							sSend = sSend.."#;".."0#^"..level.."#^"..title.."#^nil";
						end
					end
				end
			end
			
			grabTheChunks = nil;
			grabTheChunks = {};

			grabTheChunks = BreakIntoChunks(sSend, 150);
			
			ChatThrottleLib:SendAddonMessage("NORMAL",  "QTL", "SL1#@"..sNick, commType);

			for index, value in grabTheChunks do

				--send the string
				ChatThrottleLib:SendAddonMessage("NORMAL",  "QTL", "SL2#@"..sNick.."#@"..grabTheChunks[index], commType);

			end
			--------------------------------------------------
			ChatThrottleLib:SendAddonMessage("NORMAL",  "QTL", "SL3#@"..sNick, commType);
			
			
			
		elseif (r[1] == "SL1") then --start recieve quest list
			storeString = "";
				
		elseif (r[1] == "SL2") then --add to current list
			storeString = storeString..r[3];
			
		elseif (r[1] == "SL3") then --end and display
			
			--display
			if (storeString == "") then
				DEFAULT_CHAT_FRAME:AddMessage("QuestLink: Log lookup error for [|c00CC99FF"..sNick.."|r] from [|c00BDFCC9"..UnitName("player").."|r].", 156/256, 212/256, 1.0 );
				return nil;
			end
			
			QuestLink_ShowLog(storeString, sNick, commType);
			QuestLink_UpdateView(sNick, commType);
			
		elseif (r[1] == "LOG") then --user sent a log request

			if (QL_isProtected == 1) then
				ChatThrottleLib:SendAddonMessage("ALERT",  "QTL", "DENYLOG#@"..sNick, commType);
				return nil;
			end
			
			DEFAULT_CHAT_FRAME:AddMessage("QuestLink: Log Request granted to [|c004ECA00"..sNick.."|r] for [|c00BDFCC9"..r[3].."|r].", 156/256, 212/256, 1.0 );

			local xNumEntries, xNumQuests = GetNumQuestLogEntries();
			local questID;
			for q=1, xNumEntries do
				local xtitle, xlevel, xquestTag, xisHeader, xisCollapsed, xisComplete = GetQuestLogTitle(q);
				if (xtitle == r[3]) then questID = q; break; end
			end
			
			if (questID) then
				local questInfo = Questlink_GetQuestData(questID);
				
				--we have the quest data now we must send this large data to the user for processing!
				--note this requires tons of patience!
				
				local sSend = "";
				
				--lets do header
				sSend = tostring(questInfo.id).."#;"..tostring(questInfo.title).."#;"..tostring(questInfo.level).."#;"..tostring(questInfo.tag).."#;";
				sSend = sSend..tostring(questInfo.failed).."#;";

				--we need to get rid of newline to prevent disconnects
				questInfo.description = string.gsub(questInfo.description, "\n", "<<n>>");
				questInfo.objective = string.gsub(questInfo.objective, "\n", "<<n>>");
				
				sSend = sSend..tostring(questInfo.description).."#;"..tostring(questInfo.objective).."#;"..tostring(questInfo.pushable).."#;"..tostring(questInfo.timer).."#;";

				
				--we ended the last one with #; for a split now to list objectives
				if (questInfo.objectives and table.getn(questInfo.objectives) > 0) then
				
					local sObjtext = "";
					for k,v in questInfo.objectives do

						sObjtext = sObjtext..tostring(questInfo.objectives[k].text).."#^"..tostring(questInfo.objectives[k].questType).."#^"..tostring(tostring(questInfo.objectives[k].finished)).."#^";
						sObjtext = sObjtext..tostring(questInfo.objectives[k].info.name).."#^"..tostring(questInfo.objectives[k].info.done).."#^"..tostring(tostring(questInfo.objectives[k].info.total)).."#!";
						--ended with a #! to sperate array within the array #;
					end

					--add the objectives to the text being sent
					sSend = sSend..tostring(sObjtext).."#;";
				else
					sSend = sSend.."nil".."#;";
				end
				
				
				
				--get required money
				if (questInfo.requiredMoney) then
					sSend = sSend..tostring(questInfo.requiredMoney).."#;";
				else
					sSend = sSend.."nil".."#;";
				end
				
				--get reward money
				if (questInfo.rewardMoney) then
					sSend = sSend..tostring(questInfo.rewardMoney).."#;";
				else
					sSend = sSend.."nil".."#;";
				end
				
				--do the choices with a split as well
				if (questInfo.choices and table.getn(questInfo.choices) > 0) then
				
					local sObjtext = "";
					for kc,vc in questInfo.choices do

						sObjtext = sObjtext..tostring(questInfo.choices[kc].name).."#^"..tostring(questInfo.choices[kc].texture).."#^"..tostring(tostring(questInfo.choices[kc].numItems)).."#^";
						sObjtext = sObjtext..tostring(questInfo.choices[kc].quality).."#^"..tostring(questInfo.choices[kc].isUsable).."#^";
						sObjtext = sObjtext..tostring(questInfo.choices[kc].info.color).."#^"..tostring(questInfo.choices[kc].info.link).."#^"..tostring(tostring(questInfo.choices[kc].info.linkname)).."#!";

						--ended with a #! to sperate array within the array #;
					end

					--add the choices to the text being sent
					sSend = sSend..tostring(sObjtext).."#;";
				else
					sSend = sSend.."nil".."#;";
				end


				--do the rewards with a split as well
				if (questInfo.rewards and table.getn(questInfo.rewards) > 0) then
				
					local sObjtext = "";
					for kr,vr in questInfo.rewards do

						sObjtext = sObjtext..tostring(questInfo.rewards[kr].name).."#^"..tostring(questInfo.rewards[kr].texture).."#^"..tostring(tostring(questInfo.rewards[kr].numItems)).."#^";
						sObjtext = sObjtext..tostring(questInfo.rewards[kr].quality).."#^"..tostring(questInfo.rewards[kr].isUsable).."#^";
						sObjtext = sObjtext..tostring(questInfo.rewards[kr].info.color).."#^"..tostring(questInfo.rewards[kr].info.link).."#^"..tostring(tostring(questInfo.rewards[kr].info.linkname)).."#!";

						--ended with a #! to sperate array within the array #;
					end

					--add the rewards to the text being sent
					sSend = sSend..tostring(sObjtext).."#;";
				else
					sSend = sSend.."nil".."#;";
				end
				
				
				--add spell reward to end if any
				if (questInfo.spellReward) then
					sSend = sSend..tostring(questInfo.spellReward.texture).."#;"..tostring(questInfo.spellReward.name);
				else
					sSend = sSend.."nil".."#;".."nil";
				end

				
				--SEND THIS LARGE THING
				grabTheChunks = nil;
				grabTheChunks = {};

				grabTheChunks = BreakIntoChunks(sSend, 150);

				ChatThrottleLib:SendAddonMessage("NORMAL",  "QTL", "QL1#@"..sNick, commType);

				for index, value in grabTheChunks do

					--send the string
					ChatThrottleLib:SendAddonMessage("NORMAL",  "QTL", "QL2#@"..sNick.."#@"..grabTheChunks[index], commType);

				end
				--------------------------------------------------
				ChatThrottleLib:SendAddonMessage("NORMAL",  "QTL", "QL3#@"..sNick.."#@"..questInfo.title, commType);

				
				return nil;
				
				
				
			else
				ChatThrottleLib:SendAddonMessage("ALERT",  "QTL", "NOLOG#@"..sNick.."#@"..r[3], commType);
				return nil;
			end
		

		elseif (r[1] == "QL1") then --start recieve quest list
			LogStoreString = "";
				
		elseif (r[1] == "QL2") then --add to current list
			LogStoreString = LogStoreString..r[3];
			
		elseif (r[1] == "QL3") then --end and display
			
			--display
			if (LogStoreString == "") then
				DEFAULT_CHAT_FRAME:AddMessage("QuestLink: Log lookup error for [|c00CC99FF"..sNick.."|r] from [|c00BDFCC9"..UnitName("player").."|r].", 156/256, 212/256, 1.0 );
				return nil;
			end
			
			--send for processing and displaying
			Questlink_ProcessLog(LogStoreString, r[3],  sNick, commType)
			
			
		end
	
	
	end--if (r[2] == UnitName("player")) then



end



--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------


---------------------------------------------------
-- QuestLink_ShowLog
-----------------------------------------------
function QuestLink_ShowLog(sMsg, sPlayer, commType)
local Quest_Chunks;
local Quest_Chunks2;
local storeCount;
local storeLastHeader = "";
local saveCount = 1;

	if(not sMsg) then
		return;
	end
	
	Quest_Chunks = nil; --reset
	QuestLink_Target_Quests = nil;
	storeCount = 0;
	
	local Quest_Chunks = {QuestLink_Split(sMsg, "#;")};
	
	if(not Quest_Chunks) then return; end
	

	--check
	if(table.getn(Quest_Chunks) > 0) then
	
		if(not QuestLink_Target_Quests) then
			QuestLink_Target_Quests = { };
		end

		for index = 1, table.getn(Quest_Chunks), 1 do


			if(Quest_Chunks[index] and Quest_Chunks[index] ~= "") then

				--split it again
				Quest_Chunks2 = nil; --reset
				Quest_Chunks2 = {QuestLink_Split(Quest_Chunks[index], "#^")};

				if(table.getn(Quest_Chunks2) == 4) then
				
					storeCount = storeCount + 1;
					
					QuestLink_Target_Quests[storeCount] = { };
					QuestLink_Target_Quests[storeCount].header = Quest_Chunks2[1];
					QuestLink_Target_Quests[storeCount].lvl = Quest_Chunks2[2];
					QuestLink_Target_Quests[storeCount].title = Quest_Chunks2[3];
					QuestLink_Target_Quests[storeCount].questtag = Quest_Chunks2[4];
					QuestLink_Target_Quests[storeCount].player = sPlayer;
					QuestLink_Target_Quests[storeCount].commType = commType;
					
					saveCount = saveCount + 1;
						
					
				end
				

			end
			

		end--end for
		QuestLink_Target_Quests.onePastEnd = saveCount;
	

	end
	

end

					
---------------------------------------------------
-- ItemsMatrix_UpdateView
---------------------------------------------------
function QuestLink_UpdateView(sNick, commType)
local iItem;

	if( QuestLink_Target_Quests == nil ) then
		DEFAULT_CHAT_FRAME:AddMessage("QuestLink: Log lookup error for [|c00CC99FF"..sNick.."|r] from [|c00BDFCC9"..UnitName("player").."|r].", 156/256, 212/256, 1.0 );
		return nil;
	end
	
	if(not QuestLink_Target_Quests.onePastEnd) then return; end

	QuestLinkFrame:Show(); --show the frame

	FauxScrollFrame_Update(QuestLinkListScrollFrame, QuestLink_Target_Quests.onePastEnd - 1, QuestLink_ITEM_SHOWN, QuestLink_ITEM_HEIGHT);
	
	for iItem = 1, QuestLink_ITEM_SHOWN, 1 do
	
			local itemIndex = iItem + FauxScrollFrame_GetOffset(QuestLinkListScrollFrame);
			local IMItemObj = getglobal("QuestLinkItem"..iItem);
			local IMItemGreenObj = getglobal("QuestLinkItemGreenButton"..iItem);
			local IMItemTagObj = getglobal("QuestLinkItemTagButton"..iItem);
	
			IMItemTagObj:Hide(); --reset
			IMItemGreenObj:Hide(); --reset because it was showing up sometimes
			
			if( itemIndex < QuestLink_Target_Quests.onePastEnd ) then
			
				local color = { };
	
	
				--check for headers by looking to see if it has a .title
				if(QuestLink_Target_Quests[itemIndex] and tonumber(QuestLink_Target_Quests[itemIndex].header) == 1) then --it's a header
				
						IMItemObj:SetText("-"..QuestLink_Target_Quests[itemIndex].title);
		
						color.r, color.g, color.b = QuestLink_GetRGBFromHexColor("FFC0C0C0");
						IMItemObj:SetTextColor(color.r, color.g, color.b);
						IMItemObj.r = color.r;
						IMItemObj.g = color.g;
						IMItemObj.b = color.b;
	
						IMItemObj:Show();
						IMItemGreenObj:Hide();--hide green button
				
				elseif(QuestLink_Target_Quests[itemIndex] and tonumber(QuestLink_Target_Quests[itemIndex].header) == 0) then
				
					--it's an actual quest
					local name2;
					
					--check to see if the local user has the same quest
					
					if(QuestLink_CheckQuest(QuestLink_Target_Quests[itemIndex].title)) then
		
						name2 = "  ["..QuestLink_Target_Quests[itemIndex].lvl.."] "..QuestLink_Target_Quests[itemIndex].title;
	
						IMItemGreenObj:Show();--show green button				
					else
					
						name2 = "  ["..QuestLink_Target_Quests[itemIndex].lvl.."] "..QuestLink_Target_Quests[itemIndex].title;
	
						IMItemGreenObj:Hide();--hide green button
					end
	
	
					--check for empty null spaces and such
					if(name2 ~= nil and name2 ~= "" and name2 ~= " " and IMItemObj) then
	
						IMItemObj:SetText("   "..name2);
	
						color = GetDifficultyColor(tonumber(QuestLink_Target_Quests[itemIndex].lvl));
	
						IMItemObj:SetTextColor(color.r, color.g, color.b);
						IMItemObj.r = color.r;
						IMItemObj.g = color.g;
						IMItemObj.b = color.b;
	
						IMItemObj:Show();
	
	
					end
					
					--set the quest tag icons
					if (QuestLink_Target_Quests[itemIndex].questtag ~= "nil") then
					
						if (QuestLink_Target_Quests[itemIndex].questtag == "Dungeon") then
						
							getglobal(IMItemTagObj:GetName().."GreenButtonTexture"):SetTexture("Interface\\AddOns\\QuestLink\\dungeon");
							
						elseif (QuestLink_Target_Quests[itemIndex].questtag == "PvP") then
						
							getglobal(IMItemTagObj:GetName().."GreenButtonTexture"):SetTexture("Interface\\AddOns\\QuestLink\\pvp");
							
						elseif (QuestLink_Target_Quests[itemIndex].questtag == "Raid") then
						
							getglobal(IMItemTagObj:GetName().."GreenButtonTexture"):SetTexture("Interface\\AddOns\\QuestLink\\raid");
							
						elseif (QuestLink_Target_Quests[itemIndex].questtag == "Elite") then
						
							getglobal(IMItemTagObj:GetName().."GreenButtonTexture"):SetTexture("Interface\\AddOns\\QuestLink\\elite");
						end
						
						IMItemTagObj:Show();
					end
					
				
				end
				
			
				IMItemObj.info = QuestLink_Target_Quests[itemIndex];
				
			else
				IMItemObj:Hide();
			end
			
			
	end--end for

	
end


---------------------------------------------------
-- QuestLink_CheckQuest
---------------------------------------------------
function QuestLink_CheckQuest(sQuest)
local sChkBool;
	
	local NumEntries, NumQuests = GetNumQuestLogEntries();
	for i=1, NumEntries do
		local title, level, questTag, isHeader, isCollapsed, isComplete = GetQuestLogTitle(i);
		if ( title and title == sQuest) then
			sChkBool = 1;
			break;
		end
	end	
	
	return sChkBool;
			
end


---------------------------------------------------
-- QuestLink_GetRGBFromHexColor
---------------------------------------------------
function QuestLink_GetRGBFromHexColor(hexColor)

	if(not hexColor or hexColor == nil) then
		return;
	end
	
	local red = QuestLink_MakeIntFromHexString(strsub(hexColor, 3, 4)) / 255;
	local green = QuestLink_MakeIntFromHexString(strsub(hexColor, 5, 6)) / 255;
	local blue = QuestLink_MakeIntFromHexString(strsub(hexColor, 7, 8)) / 255;
	return red, green, blue;
end


---------------------------------------------------
-- QuestLink_MakeIntFromHexString
---------------------------------------------------
function QuestLink_MakeIntFromHexString(str)

	if(not str or str == nil) then
		return 0;
	end
	
	local remain = str;
	local amount = 0;
	while( remain ~= "" ) do
		amount = amount * 16;
		local byteVal = string.byte(strupper(strsub(remain, 1, 1)));
		if( byteVal >= string.byte("0") and byteVal <= string.byte("9") ) then
			amount = amount + (byteVal - string.byte("0"));
		elseif( byteVal >= string.byte("A") and byteVal <= string.byte("F") ) then
			amount = amount + 10 + (byteVal - string.byte("A"));
		end
		remain = strsub(remain, 2);
	end
	return amount;
end


--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------

---------------------------------------------------
-- QL_ChkNil
---------------------------------------------------
function QL_ChkNil(t)

	if (t == "nil") then
		return nil;
	else
		--return number if number else return string
		if (tonumber(t)) then
			return tonumber(t);
		else
			return t;
		end
	end

end

---------------------------------------------------
-- Questlink_ProcessLog
---------------------------------------------------
function Questlink_ProcessLog(sData, sTitle, sNick, commType)
	
	if (not sData) then return nil; end

	local QuestData = { };

	local r = {QuestLink_Split(sData, "#;")};
	
	QuestData.id = QL_ChkNil(r[1]);
	QuestData.title = QL_ChkNil(r[2]);
	QuestData.level = QL_ChkNil(r[3]);
	QuestData.tag = QL_ChkNil(r[4]);
	QuestData.failed = QL_ChkNil(r[5]);

	QuestData.description = QL_ChkNil(r[6]);
	QuestData.description = string.gsub(QuestData.description, "<<n>>", "\n");
	QuestData.description = QuestData.description.."\n\n"; --add two spaces at the bottom cause somtimes it doesn't scroll
	
	QuestData.objective = QL_ChkNil(r[7]);
	QuestData.objective = string.gsub(QuestData.objective, "<<n>>", "\n");
	
	QuestData.pushable = QL_ChkNil(r[8]);
	QuestData.timer = QL_ChkNil(r[9]);


	--do objectives
	--/////////////////////////
	QuestData.objectives = {};
	
	if ( QL_ChkNil(r[10]) ) then
	
		local obj = {QuestLink_Split(r[10], "#!")};

		for ko,vo in obj do

			if (vo ~= "") then
			
				local item = {};
				item.info = {};

				local obj_p = {QuestLink_Split(vo, "#^")};

				item.text = QL_ChkNil(obj_p[1]);
				item.questType = QL_ChkNil(obj_p[2]);
				item.finished = QL_ChkNil(obj_p[3]);

				item.info.name = QL_ChkNil(obj_p[4]);
				item.info.done = QL_ChkNil(obj_p[5]);
				item.info.total = QL_ChkNil(obj_p[6]);

				table.insert(QuestData.objectives, item);
			
			end

		end
	end
	--/////////////////////////

	QuestData.requiredMoney = QL_ChkNil(r[11]);
	QuestData.rewardMoney = QL_ChkNil(r[12]);	
		
	--do choices
	--/////////////////////////
	QuestData.choices = {};
	
	if ( QL_ChkNil(r[13]) ) then
	
		local obj = {QuestLink_Split(r[13], "#!")};

		for ko,vo in obj do
		
			if (vo ~= "") then
			
				local item = {};
				item.info = {};

				local obj_p = {QuestLink_Split(vo, "#^")};

				item.name = QL_ChkNil(obj_p[1]);
				item.texture = QL_ChkNil(obj_p[2]);
				item.numItems = QL_ChkNil(obj_p[3]);
				item.quality = QL_ChkNil(obj_p[4]);
				item.isUsable = QL_ChkNil(obj_p[5]);

				item.info.color = QL_ChkNil(obj_p[6]);
				item.info.link = QL_ChkNil(obj_p[7]);
				item.info.linkname = QL_ChkNil(obj_p[8]);

				table.insert(QuestData.choices, item);
			
			end

		end
	
	end
	--/////////////////////////
				
				
	--do rewards
	--/////////////////////////
	QuestData.rewards = {};
	
	if ( QL_ChkNil(r[14]) ) then
	
		local obj = {QuestLink_Split(r[14], "#!")};

		for ko,vo in obj do
			
			if (vo ~= "") then
			
				local item = {};
				item.info = {};

				local obj_p = {QuestLink_Split(vo, "#^")};

				item.name = QL_ChkNil(obj_p[1]);
				item.texture = QL_ChkNil(obj_p[2]);
				item.numItems = QL_ChkNil(obj_p[3]);
				item.quality = QL_ChkNil(obj_p[4]);
				item.isUsable = QL_ChkNil(obj_p[5]);

				item.info.color = QL_ChkNil(obj_p[6]);
				item.info.link = QL_ChkNil(obj_p[7]);
				item.info.linkname = QL_ChkNil(obj_p[8]);

				table.insert(QuestData.rewards, item);
			
			end
		end
	
	end
	--/////////////////////////
	
	
	--check for spellreward
	if ( QL_ChkNil(r[15]) ) then --check for spelltexture
		
		QuestData.spellReward = { };
		QuestData.spellReward.texture = QL_ChkNil(r[15]);
		QuestData.spellReward.name = QL_ChkNil(r[16]);
	
	end

	
	--now send to Aurora
	AuroraQuestLog_LoadQuest("AuroraLog", QuestData);
	AuroraQuestLog_Update("AuroraLog");
	AuroraQuestFrameTitleText:SetText(sTitle);
	AuroraQuestFrame:Show();
	
				
end



--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------



---------------------------------------------------
-- Questlink_GetQuestData
---------------------------------------------------
function Questlink_GetQuestData( id )
	if ( QL_isProtected == 1 ) then
		return false;
	end
	
	Questlink_Lock(); -- Protect

	if ( not id ) then
		-- Unprotect
		Questlink_Unlock()
		return nil;
	end

	local questInfo = {};

	-- Expand everything
	ExpandQuestHeader(0);

	-- Select it
	SelectQuestLogEntry(id);

	questInfo.id = id;
	questInfo.title, questInfo.level, questInfo.tag = GetQuestLogTitle(id);
	questInfo.failed = IsCurrentQuestFailed();
	questInfo.description, questInfo.objective = GetQuestLogQuestText();
	questInfo.pushable = GetQuestLogPushable();
	questInfo.timer = GetQuestLogTimeLeft();

	questInfo.objectives = {};

	for i=1, GetNumQuestLeaderBoards(), 1 do
		local item = {};

		item.text, item.questType, item.finished = GetQuestLogLeaderBoard(i);

		if ( item.questType == "item" ) then
			local realGlobal = QUEST_ITEMS_NEEDED;
			QUEST_ITEMS_NEEDED = "%s:%d:%d";
			local info = {QuestLink_Split(GetQuestLogLeaderBoard(i), ":")};
			QUEST_ITEMS_NEEDED = realGlobal;

			item.info = {};
			item.info.name = info[1];
			item.info.done = tonumber(info[2]);
			item.info.total = tonumber(info[3]);
		elseif ( item.questType == "monster" ) then
			local realGlobal = QUEST_MONSTERS_KILLED;
			QUEST_MONSTERS_KILLED = "%s:%d:%d";
			local info = {QuestLink_Split(GetQuestLogLeaderBoard(i), ":")};
			QUEST_MONSTERS_KILLED = realGlobal;

			item.info = {};
			item.info.name = info[1];
			item.info.done = tonumber(info[2]);
			item.info.total = tonumber(info[3]);
		elseif ( item.questType == "reputation" ) then
			local realGlobal = QUEST_FACTION_NEEDED;
			QUEST_FACTION_NEEDED = "%s:%s:%s";
			local info = {QuestLink_Split(GetQuestLogLeaderBoard(i), ":")};
			QUEST_FACTION_NEEDED = realGlobal;

			item.info = {};
			item.info.name = info[1];
			item.info.done = info[2];
			item.info.total = info[3];
			
		else
			item.info = {};
			item.info.name = "nil";
			item.info.done = "nil";
			item.info.total = "nil";
		end
		table.insert(questInfo.objectives, item);
	end

	if ( GetQuestLogRequiredMoney() > 0 ) then
		questInfo.requiredMoney = GetQuestLogRequiredMoney();
	end
	questInfo.rewardMoney = GetQuestLogRewardMoney();

	questInfo.rewards = {};
	questInfo.choices = {};

	for i=1, GetNumQuestLogChoices(), 1 do
		local item = {};
		item.name, item.texture, item.numItems, item.quality, item.isUsable = GetQuestLogChoiceInfo(i);

		local info = GetQuestLogItemLink("choice", i );
		if ( info ) then
			item.info = {};
			item.info.color = string.gsub(info, "|c(.*)|H(.*)|h(.*)|h|r.*", "%1");
			item.info.link = string.gsub(info, "|c(.*)|H(.*)|h(.*)|h|r.*", "%2");
			item.info.linkname = string.gsub(info, "|c(.*)|H(.*)|h(.*)|h|r.*", "%3");
		else
			item.info = {};
			item.info.color = "nil";
			item.info.link = "nil";
			item.info.linkname = "nil";
		end
		table.insert(questInfo.choices, item);
	end
	for i=1, GetNumQuestLogRewards(), 1 do
		local item = {};
		item.name, item.texture, item.numItems, item.quality, item.isUsable = GetQuestLogRewardInfo(i);

		local info = GetQuestLogItemLink("reward", i );
		if ( info ) then
			item.info = {};
			item.info.color = string.gsub(info, "|c(.*)|H(.*)|h(.*)|h|r.*", "%1");
			item.info.link = string.gsub(info, "|c(.*)|H(.*)|h(.*)|h|r.*", "%2");
			item.info.linkname = string.gsub(info, "|c(.*)|H(.*)|h(.*)|h|r.*", "%3");
		else
			item.info = {};
			item.info.color = "nil";
			item.info.link = "nil";
			item.info.linkname = "nil";
		end

		table.insert(questInfo.rewards, item);
	end

	if ( GetRewardSpell() ) then
		questInfo.spellReward={};
		questInfo.spellReward.texture, questInfo.spellReward.name = GetQuestLogRewardSpell();
	end

	-- Unprotect
	Questlink_Unlock()

	return questInfo;
end
	
	
---------------------------------------------------
-- Questlink_Lock
---------------------------------------------------
function Questlink_Lock()
	if ( QL_isProtected == 1 ) then
		return nil;
	end

	-- Store the protected state
	QL_isProtected = 1;

	-- Store the event
	QL_oldevent = QuestLog_OnEvent;
	QuestLog_OnEvent = function() end;
		
	-- Store the collapsed
	local collapsed = {};
	local NumEntries, NumQuests = GetNumQuestLogEntries();
	for i=1, NumEntries do
		local title, level, questTag, isHeader, isCollapsed, isComplete = GetQuestLogTitle(i);
		if ( isCollapsed ) then
			table.insert(collapsed, title);
			DEFAULT_CHAT_FRAME:AddMessage("locked: "..title);
		end
	end
	QL_collapseinfo = collapsed;

	-- Store the selection
	QL_lastselect = GetQuestLogSelection();

	-- Store the scroll bar position
	QL_saveScrollBar = FauxScrollFrame_GetOffset(QuestLogListScrollFrame);
	QL_saveScrollVal = QuestLogListScrollFrameScrollBar:GetValue()

	return true;
end

---------------------------------------------------
-- Questlink_Unlock
---------------------------------------------------
function Questlink_Unlock()

	-- Collapse again
	local NumEntries, NumQuests = GetNumQuestLogEntries();
	for i=1, NumEntries do
		local title, level, questTag, isHeader, isCollapsed, isComplete = GetQuestLogTitle(i);
		
		for k, v in QL_collapseinfo do --rebuild the string and store it
			if (v == title) then
				CollapseQuestHeader(i);
				DEFAULT_CHAT_FRAME:AddMessage("unlocked: "..v);
				break;
			end
		end
	end
		
	-- Restore the scroll bar position
	FauxScrollFrame_SetOffset(QuestLogListScrollFrame,QL_saveScrollBar)
	QuestLogListScrollFrameScrollBar:SetValue( QL_saveScrollVal )

	-- Restore the selection
	SelectQuestLogEntry(QL_lastselect);

	-- Restore the event
	QuestLog_OnEvent = QL_oldevent;
	QL_oldevent =  nil;

	-- Unprotect
	QL_isProtected = 0;
end



	
	
	
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------

	

---------------------------------------------------
-- QuestLink_ProcessBL
---------------------------------------------------
function QuestLink_ProcessBL(sOption, sCommand)
local storeTemp = {};
local sNum = 0;
local sFound = 0;

	--hide if visible
	if( QLBlackListFrame_Frame:IsVisible() ) then
		QLBlackListFrame_Frame:Hide();
	end


	--first make sure there is a gap inbetween
	if( string.sub( sCommand,  6  , 6 ) ~= " ") then
	
		DEFAULT_CHAT_FRAME:AddMessage("|c004ECA00QuestLink: You must have a space in between when adding users.  Example: /ql bladd myuser|r");
		return nil;
	end


	--make sure the user exists
	if(QuestLink_BLUsers) then
	
			for index, value in QuestLink_BLUsers do


				--if the name doesn't match the one we want to delete then add it to temp otherwise ignore
				if(string.lower(QuestLink_BLUsers[index])  == string.lower(string.sub( sCommand,  7  , string.len(sCommand))) ) then
				
					sFound = 1;
			
				end
				

			end --end for
			
			
			if(sFound == 0) then
			
				DEFAULT_CHAT_FRAME:AddMessage("|c004ECA00QuestLink: User not in BlackList Database!|r");
				return nil;
			end
			
	end
	


	--they are adding
	if(sOption == 1) then
	
	
	
	
		if(not QuestLink_BLUsers) then
		
			QuestLink_BLUsers = { };
			QuestLink_BLUsers[1] =  string.lower(string.sub( sCommand,  7  , string.len(sCommand)));
		
			DEFAULT_CHAT_FRAME:AddMessage("QuestLink: [|c004ECA00"..string.lower(string.sub( sCommand,  7  , string.len(sCommand))).."|r] added to BlackList Users.", 156/256, 212/256, 1.0 );
		
		else
		
			sNum = table.getn(QuestLink_BLUsers) + 1;
	
			QuestLink_BLUsers[sNum] =  string.lower(string.sub( sCommand,  7  , string.len(sCommand)));
		
			DEFAULT_CHAT_FRAME:AddMessage("QuestLink: [|c004ECA00"..string.lower(string.sub( sCommand,  7  , string.len(sCommand))).."|r] added to BlackList Users.", 156/256, 212/256, 1.0 );
		
		
		end
		
	
	--remove user
	elseif(sOption == 2) then
	

		if(not QuestLink_BLUsers) then
		
			DEFAULT_CHAT_FRAME:AddMessage("QuestLink: No users to delete!", 156/256, 212/256, 1.0 );
				
		
		else
		

			sNum = 1;
			
			for index, value in QuestLink_BLUsers do


				--if the name doesn't match the one we want to delete then add it to temp otherwise ignore
				if(string.lower(QuestLink_BLUsers[index])  ~= string.lower(string.sub( sCommand,  7  , string.len(sCommand))) ) then
				
					
					storeTemp[sNum] = QuestLink_BLUsers[index];
					sNum = sNum + 1; --increment
					
					
			
				end
				

			end --end for
		

			if(table.getn(storeTemp) == 0) then
				QuestLink_BLUsers = nil;
				storeTemp = nil;
			else

				--now transfer
				QuestLink_BLUsers = nil;
				QuestLink_BLUsers = { };

				QuestLink_BLUsers = storeTemp; --transfer

				storeTemp = nil;
				storeTemp = { };
			
			end

			DEFAULT_CHAT_FRAME:AddMessage("QuestLink: [|c004ECA00"..string.lower(string.sub( sCommand,  7  , string.len(sCommand))).."|r] removed from BlackList Users.", 156/256, 212/256, 1.0 );
		
		
		
		end
		

		


	
	end






end




---------------------------------------------------
-- QuestLink_ShowBL
---------------------------------------------------
function QuestLink_ShowBL()
local storeUsers = "";


	if(not QuestLink_BLUsers) then
	
		QLBlackListFrame_Frame:Show();
		QLBlackListFrameText:SetText("No players on BlackList!");

	else
	
	
		for index, value in QuestLink_BLUsers do
		
		
			storeUsers = storeUsers.."\n"..index..": "..QuestLink_BLUsers[index];
		
		
		end --end for
		
	
		if(storeUsers and storeUsers ~= "") then
		
			QLBlackListFrameText:SetText(storeUsers);
	
		end
	
	
		QLBlackListFrame_Frame:Show();
	
	
	end
	


end



---------------------------------------------------
-- QuestLink_CheckIfBlackListed
---------------------------------------------------
function QuestLink_CheckIfBlackListed(sUser)
local sFound = 0;

	--make sure the user exists
	if(QuestLink_BLUsers) then
	
			for index, value in QuestLink_BLUsers do


				--if the name doesn't match the one we want to delete then add it to temp otherwise ignore
				if(string.lower(QuestLink_BLUsers[index])  == string.lower(sUser) ) then
				
					sFound = 1;
			
				end
				

			end --end for
			
			
			if(sFound == 0) then
			
				return 0;
			
			--they were found so return 1
			else
				return 1;
			end
			
			
	else
		
		return 0;
			
	end


end


			
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------


---------------------------------------------------
-- QuestLink_Split
-- (text, sep, num)
-----------------------------------------------
function QuestLink_Split(s,p,n)
	if (type(s) ~= "string") then return nil; end
	    local l,sp,ep = {},0
	    while(sp) do
		sp,ep=strfind(s,p)
		if(sp) then
		    tinsert(l,strsub(s,1,sp-1))
		    s=strsub(s,ep+1)
		else
		    tinsert(l,s)
		    break
		end
		if(n) then n=n-1 end
		if(n and (n==0)) then tinsert(l,s) break end
	    end
	    return unpack(l)
end



---------------------------------------------------
-- BreakIntoChunks
-----------------------------------------------
function BreakIntoChunks(text, chunkSize)	
	local list = {};
	local pos = 0;
	local lastPos;
	local currentPos;


	for i=1, string.len(text), 1 do
			
		if(pos > chunkSize) then

			pos = 0;
			
			tinsert(list, string.sub(text, lastPos, i));

			lastPos = i+1; --add to last position
			

		else

			pos = pos + 1;

		end


		if(lastPos == nil or lastPos == 0) then

			lastPos = i;
		end


	end

	--if some chance the list did not finish to imput the end lets add it
	if(pos ~= 0 or pos > 0 and pos < chunkSize) then

		--from lastpos to end
		if(string.len(string.sub(text, lastPos)) < chunkSize) then

			tinsert(list, string.sub(text, lastPos));
	
		end

	end
	
	return list
  
end