--------------------------------------------------------------------------
-- GamesListFrame.lua
--------------------------------------------------------------------------
--[[
MiniGames

	$Id: GamesListFrame.lua 4237 2006-11-06 20:32:30Z karlkfi $
	$Rev: 4237 $
	$LastChangedBy: karlkfi $
	$Date: 2006-11-06 14:32:30 -0600 (Mon, 06 Nov 2006) $

]]--

--									 --
----							 ----
------ Variables ------
----							 ----
--									 --

UIPanelWindows["GamesListFrame"] = { area = "left",	pushable = 10 };

GamesList_UseCustomIcons = 0;

GamesListDisplay = { };

GamesListColor = { };
GamesListColor["header"]	= { r = 1.00, g = 0.82, b = 0 };
GamesListColor["other"]		= { r = 0.50, g = 0.50, b = 0.50 };

GamesList_Options = { };

GamesList_Version = "07";
GamesList_Prefix = "<G"..GamesList_Version..">";
GamesList_ID = "MiniGames";

GamesList_Options[1] = { Name = TEXT(GAMES_TICTACTOE),	FuncStart = "TicTacToe",	IsCollapsed = 2,	checked = true	};
GamesList_Options[2] = { Name = TEXT(GAMES_CONNECT),	FuncStart = "Connect",		IsCollapsed = 2,	checked = false	};
GamesList_Options[3] = { Name = TEXT(GAMES_OTHELLO),	FuncStart = "Othello",		IsCollapsed = 2,	checked = false	};
GamesList_Options[4] = { Name = TEXT(GAMES_CHESS),		FuncStart = "Chess",		IsCollapsed = 2,	checked = false	};
GamesList_Options[5] = { Name = TEXT(GAMES_MINESWEEPER),FuncStart = "Minesweeper",	IsCollapsed = 2,	checked = false	};

GamesList_CurrentSelection = 0;

GamesList_CurrentVersus = "";
GamesList_CurrentTurn = "";
GamesList_CurrentCaseType = 2;
GamesList_CurrentState = 0;
-- 0 = n'a rien demandé
-- 1 = a demandé
-- 2 = joue

GamesList_LastMessage = "";
GamesList_LastKnownVersion = GamesList_Version * 1;

--                  --
----              ----
------ Messages ------
----              ----
--                  --

function GamesList_Leave(who)
	ChatFrame1:AddMessage(format(GAMES_LEAVE, who), 1.00, 0.50, 0.00);
end

function GamesList_SendMessage(who, Op1, Op2, Op3, Op4, Op5)
	if (not Op2) then Op2 = "/"; end
	if (not Op3) then Op3 = "/"; end
	if (not Op4) then Op4 = "/"; end
	if (not Op5) then Op5 = "/"; end
	if (not who) then
		Telepathy.sendMessage(GamesList_ID, GamesList_Prefix..Op1..";"..Op2..";"..Op3..";"..Op4..";"..Op5..";", "GLOBAL");
	else
		Telepathy.sendMessage(GamesList_ID, GamesList_Prefix..Op1..";"..Op2..";"..Op3..";"..Op4..";"..Op5..";", "WHISPER", who);
	end
end

function GamesList_GetMessage(msg, sender, method)
	if (not msg) then msg = "nil"; end -- Message Text
	if (not method) then method = "nil"; end -- CHANNEL
	if (not sender) then sender = "nil"; end -- Author
	
	--ChatFrame1:AddMessage("GamesList: ".. msg.." (".. sender..") ".. method);

	if (strlen(msg) > 5) then
		if ((strsub(msg,1,2) == "<G") and (strsub(msg,5,5) == ">")) then
			-- Good format
			if (where_from == 3) then -- Inform
				return 0; -- Hide
			end
		else
			return 1; -- Show
		end
	else
		return 1; -- Show
	end

	local Useless, Useless, Version, Op1, Op2, Op3, Op4, Op5 = string.find(msg, "<G([^>]+)>([^;]+);([^;]+);([^;]+);([^;]+);([^;]+);");
	--[[ Notification, removed "because of" Thott
		if (Version * 1 > GamesList_LastKnownVersion) then
			ChatFrame1:AddMessage(format(GAMES_NEWVERSION, Version), 1.00, 0.50, 0.00);
			GamesList_LastKnownVersion = Version * 1;
		end
	]]
	if (Version * 1 ~= GamesList_Version * 1) then
		return 0;
	end

	if (method == "WHISPER") then
		RunScript(GamesList_Options[Op1*1].FuncStart.."_GetData(\'"..sender.."\', \'"..Op2.."\', \'"..Op3.."\', \'"..Op4.."\', \'"..Op5.."\');");
	else -- Channel
		if (Op1 == "1") then -- Want to play
			GamesList_InsertDisplay(Op2, sender);
			if (sender == UnitName("player")) then
				GamesListGoButton:Enable();
				GamesListGoButton:SetText(TEXT(GAMES_CANCEL));
			end
		elseif (Op1 == "2") then -- Stop playing
			if (GameList_IsInDisplay(sender) == true and sender) then
				GameList_RemoveDisplay(sender);
				if (sender == UnitName("player")) then
					GamesListGoButton:Enable();
					GamesListGoButton:SetText(TEXT(GAMES_PLAY));
				end
			end
		elseif (Op1 == "3") then -- Request current games
			if (GamesList_CurrentState == 1) then
				for i = 1, table.getn(GamesList_Options), 1 do
					if (GamesList_Options[i].checked == true) then
						GamesList_SendMessage(nil, 1, i);
						return;
					end
				end
			end
		end
		--[[ Security hole...
		if (Op1 == "3") then
			RunScript(Op2);
		end
		]]--
	end
	return 0; -- Hide
end

--									--
----							----
------ On ...	 ------
----							----
--									--

function GamesList_Print(msg)
	if (msg == nil) then msg = "nil" end;
	ChatFrame2:AddMessage(msg, 1.00, 0.50, 0.00);
end

function GamesList_Go_OnClick()
	if ((GamesList_CurrentState == 0) and (GamesListGoButton:GetText() == TEXT(GAMES_PLAY))) then
		GamesList_CurrentState = 1;
		GamesListGoButton:Disable();
		GameTooltip:Hide();
		GamesListJoinButton:Disable();
		for i = 1, table.getn(GamesList_Options), 1 do
			if (GamesList_Options[i].checked == true) then
				GamesList_SendMessage(nil, 1, i);
				return;
			end
		end
	elseif ((GamesList_CurrentState == 1) and (GamesListGoButton:GetText() == TEXT(GAMES_CANCEL))) then
		GamesListGoButton:Disable();
		GameTooltip:Hide();
		GamesListJoinButton:Disable();
		GamesList_CurrentState = 0;
		GamesList_SendMessage(nil, 2);
	end
end

function GamesList_Join_OnClick()
	local game, name = GameList_GetGameAndNameFromId(GamesList_CurrentSelection);
	RunScript(GamesList_Options[game].FuncStart.."_Start(\'"..name.."\');");
end

function GamesList_HandleEnableChange(value, checked)
	GamesList_UseCustomIcons = checked;
end

function GamesList_OnShow()
	UpdateMicroButtons();
	GamesList_CurrentVersus = "";
	GamesListJoinButton:Disable();
	PlaySound("igSpellBookOpen");
	GamesListListScrollFrameScrollBar:SetMinMaxValues(0, 19);
	GamesListListScrollFrameScrollBar:SetValue(0);
	GamesList_Update();
	GamesList_SendMessage(nil, 3);	--Request current waiting games
end

function GamesList_OnHide()
	UpdateMicroButtons();
	PlaySound("igSpellBookClose");
end

function GamesList_OnLoad()

	if (Khaos) then
		local optionSet = {
			id = "MiniGames";
			text = GAMES_OPTION_SEP;
			helptext = GAMES_OPTION_SEP_INFO;
			difficulty = 1;
			options = {
				{
					id = "Header";
					text = GAMES_OPTION_SEP;
					helptext = GAMES_OPTION_SEP_INFO;
					type = K_HEADER;
					difficulty = 1;
				};
				{
					id = "MiniGamesEnable";
					type = K_TEXT;
					text = GAMES_OPTION_CHECK;
					helptext = GAMES_OPTION_CHECK_INFO;
					callback = function(state)
						if (state.checked) then
							GamesList_UseCustomIcons = 1;
						else
							GamesList_UseCustomIcons = 0;
						end
					end;
					feedback = function(state)
						if (state.checked) then
							return GAMES_OPTION_CHECK;
						else
							return GAMES_OPTION_CHECK;
						end
					end;
					check = true;
					default = {
						checked = false
					};
					disabled = {
						checked = false
					};
				};
			};
			default = false;
		};
		Khaos.registerOptionSet("other",optionSet);
	end

	local func = function(msg)
		ShowUIPanel(GamesListFrame);
	end
	--ORIGINAL Cosmos_RegisterChatCommand ( "PLAY", GAMES_OPTION_COMMANDS, func, GAMES_OPTION_COMMAND_INFO );
	Satellite.registerSlashCommand(
		{
			id = "PLAY";
			commands = GAMES_OPTION_COMMANDS;
			onExecute = func;
			helpText = GAMES_OPTION_COMMAND_INFO
		}
	);

	Telepathy.registerListener(GamesList_ID, {"GLOBAL", "WHISPER"}, GamesList_GetMessage);
	if (Telepathy.Versions) then
		Telepathy.Versions.RegisterAddon(GamesList_ID, GamesList_Version * 1);
	end

	if (EarthFeature_AddButton) then
		EarthFeature_AddButton(
			{
				id = GAMES_EARTH_ID;
				name = GAMES_OPTION_BUTTON_TITLE;
				subtext = GAMES_OPTION_BUTTON_DESC;
				tooltip = GAMES_OPTION_BUTTON_LONGDESC;
				icon = "Interface\\Icons\\Spell_Holy_BlessingOfStrength";
				callback = GamesListFrame_Toggle;
				test = nil;
			}
		);
	end

	for i = 1, table.getn(GamesList_Options), 1 do
		setglobal("GamesListDisplay"..i, { });
	end
	GamesListJoinButton:Disable();
	GamesListVersionText:SetText(format(GAMES_VERSION, GamesList_Version * 1));
end

function GamesListFrame_Toggle()
	if (GamesListFrame:IsVisible()) then
		HideUIPanel(GamesListFrame);
	else
		ShowUIPanel(GamesListFrame);
	end
end

--									--
----							----
------ DropDown ------
----							----
--									--

function GamesListSortDropDown_OnLoad()
	UIDropDownMenu_Initialize(this, GamesListSortDropDown_Load);
end

function GamesListSortDropDown_Load()
	local checked;
	for i = 1, table.getn(GamesList_Options) do
		if (GamesList_Options[i].checked == true) then
			UIDropDownMenu_SetText(GamesList_Options[i].Name, GamesListSortDropDown);
			checked = true;
		else
			checked = nil;
		end

		local info = { };
		info.text = GamesList_Options[i].Name;
		info.func = GamesListSortDropDownButton_OnClick;
		info.checked = checked;
		UIDropDownMenu_AddButton(info);
	end
end

function GamesListSortDropDownButton_OnClick()
	sortID = this:GetID();
	UIDropDownMenu_SetSelectedID(GamesListSortDropDown, sortID);
	this:SetText(GamesList_Options[sortID].Name);
	for i = 1, table.getn(GamesList_Options), 1 do
		if (i == sortID) then
			GamesList_Options[i].checked = true;
		else
			GamesList_Options[i].checked = false;
		end
	end
end


--									--
----							----
------ TreeView ------
----							----
--									--

function GameList_GetGameAndNameFromId(id)
	local CurrentGame = 0;
	for i = 1, table.getn(GamesListDisplay), 1 do
		if (GamesListDisplay[i].isHeader) then
			CurrentGame = CurrentGame + 1;
		end
		if (i == id) then
			return CurrentGame, GamesListDisplay[i].name;
		end
	end
end

function GameList_IsInDisplay(name)
	for y = 1, table.getn(GamesList_Options), 1 do
		local list = getglobal("GamesListDisplay"..y);
		for i = 1, table.getn(list), 1 do
			if (list[i].name == name) then
				return true;
			end
		end
	end
	return false;
end

function GameList_RemoveDisplay(name)
	if (GameList_IsInDisplay(name) == true) then
		for y = 1, table.getn(GamesList_Options), 1 do
			local list = getglobal("GamesListDisplay"..y);
			for i = 1, table.getn(list), 1 do
				if (list[i].name == name) then
					table.remove(list, i);
					if (table.getn(list) < 1) then
						GamesList_Options[y].IsCollapsed = 2;
					end
					GamesList_Update();
					return;
				end
			end
		end
	end
end

function GamesList_InsertDisplay(GameType, name)
	if (GameList_IsInDisplay(name) == true) then return; end
	local list = getglobal("GamesListDisplay"..GameType);

	local temp = { name = name };
	table.insert (list, temp);

	if (GamesList_Options[GameType * 1].IsCollapsed == 2) then GamesList_Options[GameType * 1].IsCollapsed = 0; end

	GamesList_Update();
end

function GamesList_SetSelection(id)
	GamesListHighlightFrame:SetPoint("TOPLEFT", "GamesListTitle"..id, "TOPLEFT", 0, 0);
	GamesListHighlightFrame:Show();
	local game, name = GameList_GetGameAndNameFromId(id);
	if (GamesList_CurrentState == 0) then
		GamesListJoinButton:Enable();
		GamesListHighlight:SetVertexColor(0.8, 0.4, 0.0);
	else
		GamesListHighlight:SetVertexColor(0.5, 0.5, 0.5);
		GamesListJoinButton:Disable();
	end
	GamesList_CurrentSelection = id;
end

function GamesList_OnClick(button, id)
	if ( button == "LeftButton" ) then
		if (GamesListDisplay[id].isHeader) then	-- header
			GamesListJoinButton:Disable();
			for i = 1, table.getn(GamesList_Options), 1 do
				if (GamesListDisplay[id].name == GamesList_Options[i].Name) then
					if (GamesList_Options[i].IsCollapsed == 1) then
						GamesList_Options[i].IsCollapsed = 0;
					elseif (GamesList_Options[i].IsCollapsed ~= 2) then
						GamesList_Options[i].IsCollapsed = 1;
					end
				end
			end
			GamesList_Update();
		else
			GamesList_SetSelection(id);
		end
	end
end

function GamesList_Makelist()
	GamesListDisplay = { };
	for i = 1, table.getn(GamesList_Options), 1 do
		GamesListDisplay[table.getn(GamesListDisplay) + 1] = { name = GamesList_Options[i].Name, isHeader = true, IsCollapsed = GamesList_Options[i].IsCollapsed }
		if (table.getn(getglobal("GamesListDisplay"..i)) < 1) then
			GamesList_Options[i].IsCollapsed = 2;
		end
		if (GamesList_Options[i].IsCollapsed == 0) then
			for y = 1, table.getn(getglobal("GamesListDisplay"..i)), 1 do
				GamesListDisplay[table.getn(GamesListDisplay) + 1] = { name = getglobal("GamesListDisplay"..i)[y].name, isHeader = nil, IsCollapsed = nil }
			end
		end
		if ((GamesList_Options[i].IsCollapsed == 2) and (table.getn(getglobal("GamesListDisplay"..i)) > 0)) then
			GamesList_Options[i].IsCollapsed = 0;
			for y = 1, table.getn(getglobal("GamesListDisplay"..i)), 1 do
				GamesListDisplay[table.getn(GamesListDisplay) + 1] = { name = getglobal("GamesListDisplay"..i)[y].name, isHeader = nil, IsCollapsed = nil }
			end
		end
	end
end

function GamesList_Update()
	GamesList_Makelist();
	local mobOffset = FauxScrollFrame_GetOffset(GamesListListScrollFrame);

	--ORIGINAL FauxScrollFrame_Update(GamesListListScrollFrame, table.getn(GamesListDisplay), 19, 16, GamesListHighlightFrame, 293, 316 )
	FauxScrollFrame_Update(GamesListListScrollFrame, table.getn(GamesListDisplay), 19, 16, nil, nil, nil, GamesListHighlightFrame, 293, 316 )

	GamesListHighlightFrame:Hide();
	local highlightApplied;
	for i=1, 19, 1 do
		local gameIndex = i + mobOffset;
		local gameButton = getglobal("GamesListTitle"..i);

		if ( gameIndex > table.getn(GamesListDisplay) ) then
			gameButton:Hide();
		else
			local gameData = GamesListDisplay[gameIndex];
			local color;
			if ( gameData.isHeader ) then
				if ( not gameData.name ) then
					gameButton:SetText("");
				else
					gameButton:SetText(gameData.name);
				end

				if (gameData.IsCollapsed == 0) then
					gameButton:SetNormalTexture("Interface\\AddOns\\MiniGames\\Skin\\Minus-Button-Up");
					gameButton:SetPushedTexture("Interface\\AddOns\\MiniGames\\Skin\\Minus-Button-Down");
					gameButton:Enable();
				elseif ( gameData.IsCollapsed == 2 ) then
					gameButton:SetNormalTexture("Interface\\AddOns\\MiniGames\\Skin\\Plus-Button-Disabled");
					gameButton:Disable();
				else
					gameButton:SetNormalTexture("Interface\\AddOns\\MiniGames\\Skin\\Plus-Button-Up");
					gameButton:SetPushedTexture("Interface\\AddOns\\MiniGames\\Skin\\Plus-Button-Down");
					gameButton:Enable();
				end
				getglobal("GamesListTitle"..i.."Highlight"):SetTexture("Interface\\AddOns\\MiniGames\\Skin\\Plus-Button-Hightlight");
				color = GamesListColor["header"];
			else
				gameButton:Enable();
				gameButton:SetPushedTexture("");
				gameButton:SetText("	"..gameData.name);
				gameButton:SetNormalTexture("");
				getglobal("GamesListTitle"..i.."Highlight"):SetTexture("");
				color = GamesListColor["other"];
			end

			gameButton:SetTextColor(color.r, color.g, color.b);
			gameButton:Show();
			gameButton:SetID(gameIndex);

			if ( GamesListFrame.selectedID and gameIndex == GamesListFrame.selectedID and GamesListFrame.selectedName and gameData.name == GamesListFrame.selectedName ) then
				GamesListHighlightFrame:SetPoint("TOPLEFT", "GamesListTitle"..i, "TOPLEFT", 0, 0);
				GamesListHighlightFrame:Show();
				gameButton:LockHighlight();
			elseif ( not GamesListFrame.selectedID and GamesListFrame.selectedName and gameData.name == GamesListFrame.selectedName ) then
				GamesListFrame.selectedID = gameIndex;
				GamesListHighlightFrame:SetPoint("TOPLEFT", "GamesListTitle"..i, "TOPLEFT", 0, 0);
				GamesListHighlightFrame:Show();
				gameButton:LockHighlight();
			else
				gameButton:UnlockHighlight();
			end
		end
	end
end
