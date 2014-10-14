--------------------------------------------------------------------------
-- TicTacToeFrame.lua
--------------------------------------------------------------------------
--[[
MiniGames

	$Id: TicTacToeFrame.lua 3159 2006-03-07 22:34:10Z gryphon $
	$Rev: 3159 $
	$LastChangedBy: gryphon $
	$Date: 2006-03-07 16:34:10 -0600 (Tue, 07 Mar 2006) $

]]--

UIPanelWindows["TicTacToeFrame"] = { area = "center",	pushable = 0 };

TicTacToe_IconPath = { };
TicTacToe_IconPath[2] = { WoW = "Interface\\Icons\\Spell_Shadow_MindBomb", Custom = "Interface\\AddOns\\MiniGames\\Skin\\TicTacToe\\O"};
TicTacToe_IconPath[3] = { WoW = "Interface\\Icons\\Spell_Holy_BlessingOfStrength", Custom = "Interface\\AddOns\\MiniGames\\Skin\\TicTacToe\\X"};

function TicTacToe_Clear()
	for y = 1, 3 do
		for i = 1, 3 do
			TicTacToe_ChangeValue(y, i, 1);
		end
	end
end

function TicTacToe_ClearSelected()
	for y = 1, 3 do
		for i = 1, 3 do
			local Button = getglobal("TicTacToeButton"..i.."_"..y);
			Button:SetChecked("false");
		end
	end
end

function TicTacToe_ChangeValue(x, y, icon_state)
	local State = getglobal("TicTacToeButton"..x.."_"..y.."State");
	local Button = getglobal("TicTacToeButton"..x.."_"..y);
	local IconTexture = getglobal("TicTacToeButton"..x.."_"..y.."IconTexture");

	if (icon_state == 1) then
		IconTexture:Hide();
		State:SetText("1");
	else
		if (GamesList_UseCustomIcons == 0) then
			IconTexture:SetTexture(TicTacToe_IconPath[icon_state * 1].WoW);
		else
			IconTexture:SetTexture(TicTacToe_IconPath[icon_state * 1].Custom);
		end
		State:SetText(icon_state.."");
		IconTexture:Show();
	end
	TicTacToe_ClearSelected();
end

function TicTacToe_ButtonState(x, y)
	local State = getglobal("TicTacToeButton"..x.."_"..y.."State");
	return State:GetText() * 1;
end

function TicTacToe_WinTest()
	for i = 1, 3 do
		if ( ( TicTacToe_ButtonState(i, 1) == TicTacToe_ButtonState(i, 2) ) and ( TicTacToe_ButtonState(i, 2) == TicTacToe_ButtonState(i, 3) ) and ( TicTacToe_ButtonState(i, 3) ~= 1 ) ) then
			return TicTacToe_ButtonState(i, 1);
		elseif ( ( TicTacToe_ButtonState(1, i) == TicTacToe_ButtonState(2, i) ) and ( TicTacToe_ButtonState(2, i) == TicTacToe_ButtonState(3, i) ) and ( TicTacToe_ButtonState(3, i) ~= 1 ) ) then
			return TicTacToe_ButtonState(1, i);
		end
	end
	if ( ( TicTacToe_ButtonState(1, 1) == TicTacToe_ButtonState(2, 2) ) and ( TicTacToe_ButtonState(2, 2) == TicTacToe_ButtonState(3, 3) ) and ( TicTacToe_ButtonState(2, 2) ~= 1 ) ) then
		return TicTacToe_ButtonState(1, 1);
	elseif ( ( TicTacToe_ButtonState(1, 3) == TicTacToe_ButtonState(2, 2) ) and ( TicTacToe_ButtonState(2, 2) == TicTacToe_ButtonState(3, 1) ) and ( TicTacToe_ButtonState(3, 1) ~= 1 ) ) then
		return TicTacToe_ButtonState(1, 3);
	end

	for i = 1, 3 do
		for y = 1, 3 do
			if (TicTacToe_ButtonState(i, y) == 1) then
				return 0;
			end
		end
	end
	return 1;
end

function TicTacToe_Invert(inv)
	if (inv == 3) then
		return 2;
	else
		return 3;
	end
end

function TicTacToe_SendInfo(Type, Arg1, Arg2, Arg3)
	GamesList_SendMessage(GamesList_CurrentVersus, 1, Type, Arg1, Arg2, Arg3);
end

function TicTacToe_GetData(Who, Type, Arg1, Arg2, Arg3)
	Type = Type * 1;
	if (Type == 1) then -- Start
		ShowUIPanel(TicTacToeFrame);
		GamesList_CurrentVersus = Who;
		GamesList_ScoreLeft = 0;
		GamesList_ScoreRight = 0;
		GamesList_CurrentState = 2;
		GamesList_CurrentCaseType = 2;
		TicTacToe_Clear();
		GamesList_SendMessage(nil, 2);
		TicTacToeButtonRestart:Disable();
		TicTacToe_UpdateBorders();
		GamesList_CurrentTurn = 1;

	elseif (Who ~= GamesList_CurrentVersus) then
		return;

	elseif (Type == 2) then -- New Case
		TicTacToe_ChangeValue(Arg1 * 1, Arg2 * 1, TicTacToe_Invert(GamesList_CurrentCaseType));
		GamesList_CurrentTurn = 1;
		TicTacToe_UpdateBorders();

	elseif (Type == 3) then -- Win
		GamesList_ScoreRight = GamesList_ScoreRight + 1;
		TicTacToeButtonRestart:Enable();
		GamesList_CurrentTurn = 0;
		TicTacToe_UpdateBorders();

	elseif (Type == 4) then -- Restart
		TicTacToe_Clear();
		GamesList_CurrentTurn = 1;
		TicTacToeButtonRestart:Disable();
		TicTacToe_UpdateBorders();

	elseif (Type == 5) then -- Draw
		TicTacToeButtonRestart:Enable();
		GamesList_CurrentTurn = 0;

	elseif (Type == 6) then -- Leave
		GamesList_Leave(GamesList_CurrentVersus);
		TicTacToe_Clear();
		GamesList_CurrentState = 0;
		GamesList_CurrentVersus = "";
		HideUIPanel(TicTacToeFrame);
	end
end

function TicTacToe_UpdateBorders()
	TicTacToeNameLeft:SetText(UnitName("player"));
	TicTacToeNameRight:SetText(GamesList_CurrentVersus);
	TicTacToeScoreLeft:SetText(GamesList_ScoreLeft);
	TicTacToeScoreRight:SetText(GamesList_ScoreRight);

	if (GamesList_UseCustomIcons == 0) then
		TicTacToeButtonLeftIconTexture:SetTexture(TicTacToe_IconPath[GamesList_CurrentCaseType].WoW);
		TicTacToeButtonRightIconTexture:SetTexture(TicTacToe_IconPath[TicTacToe_Invert(GamesList_CurrentCaseType)].WoW);
	else
		TicTacToeButtonLeftIconTexture:SetTexture(TicTacToe_IconPath[GamesList_CurrentCaseType].Custom);
		TicTacToeButtonRightIconTexture:SetTexture(TicTacToe_IconPath[TicTacToe_Invert(GamesList_CurrentCaseType)].Custom);
	end
	TicTacToeButtonRightIconTexture:Show();
	TicTacToeButtonLeftIconTexture:Show();

	if (GamesList_CurrentTurn ~= 0) then
		TicTacToeButtonLeft:SetChecked("true");
		TicTacToeButtonRight:SetChecked("false");
	else
		TicTacToeButtonLeft:SetChecked("false");
		TicTacToeButtonRight:SetChecked("true");
	end
end

function TicTacToe_Start(Who)
	GamesList_CurrentVersus = Who;
	GamesList_ScoreLeft = 0;
	GamesList_ScoreRight = 0;
	GamesList_CurrentState = 2;
	GamesList_CurrentCaseType = 3;
	GamesList_CurrentTurn = 0;
	ShowUIPanel(TicTacToeFrame);
	TicTacToe_SendInfo(1);
	TicTacToe_UpdateBorders();
	TicTacToe_OnLoad();
end

function TicTacToe_HelpText(msg)
	TicTacToeHelpText:SetText(msg);
end

function TicTacToe_OnLoad()
	TicTacToeTitle:SetText(GamesList_Options[1].Name);
	TicTacToeButtonRestart:Disable();
	TicTacToe_Clear();
	GamesList_CurrentTurn = 0;
	GamesList_ScoreLeft = 0;
	GamesList_ScoreRight = 0;
	TicTacToe_UpdateBorders();
end

function TicTacToe_Restart_OnClick()
	TicTacToe_Clear()
	GamesList_CurrentTurn = 1;
	TicTacToeButtonRestart:Disable();
	TicTacToe_UpdateBorders();
	TicTacToe_SendInfo(4);
end

function TicTacToe_OnHide()
	if (strlen(GamesList_CurrentVersus) > 1) then
		TicTacToe_Quit_OnClick();
	end
end

function TicTacToe_Quit_OnClick()
	TicTacToe_SendInfo(6);
	GamesList_CurrentState = 0;
	GamesList_CurrentTurn = 0;
	GamesList_CurrentVersus = "";
	HideUIPanel(TicTacToeFrame);
end

function TicTacToe_OnClick()
	local x = strsub(this:GetID(), 1, 1);
	local y = strsub(this:GetID(), 2, 2);
	if ( (GamesList_CurrentTurn == 1) and ( TicTacToe_ButtonState(x * 1, y * 1) == 1) ) then
		GamesList_CurrentTurn = 0;
		TicTacToe_ChangeValue(x, y, GamesList_CurrentCaseType );
		TicTacToe_SendInfo(2, x, y);
		TicTacToe_UpdateBorders();

		this:SetChecked("true");
		PlaySound("gsLoginChangeRealmOK");
		local WinTest = TicTacToe_WinTest();
		if (WinTest ~= 0) then
			if (WinTest == 1) then
				TicTacToe_SendInfo(5);
				TicTacToeButtonRestart:Enable();
				GamesList_CurrentTurn = 0;
			elseif (WinTest == GamesList_CurrentCaseType) then
				GamesList_ScoreLeft = GamesList_ScoreLeft + 1;
				TicTacToe_UpdateBorders();
				TicTacToe_SendInfo(3);
				TicTacToeButtonRestart:Enable();
				GamesList_CurrentTurn = 0;
			end
		end
		return;
	end
	PlaySound("igCharacterInfoClose");
	this:SetChecked("false");
	TicTacToe_UpdateBorders();
end
