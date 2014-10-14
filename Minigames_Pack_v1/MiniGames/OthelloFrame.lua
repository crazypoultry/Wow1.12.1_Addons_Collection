--------------------------------------------------------------------------
-- OthelloFrame.lua
--------------------------------------------------------------------------
--[[
MiniGames

	$Id: OthelloFrame.lua 3159 2006-03-07 22:34:10Z gryphon $
	$Rev: 3159 $
	$LastChangedBy: gryphon $
	$Date: 2006-03-07 16:34:10 -0600 (Tue, 07 Mar 2006) $

]]--

UIPanelWindows["OthelloFrame"] = { area = "center",	pushable = 0 };

Othello_IconPath = { };
Othello_IconPath[2] = { WoW = "Interface\\Icons\\INV_Misc_Bomb_03", Custom = "Interface\\AddOns\\MiniGames\\Skin\\Connect\\BlackKing"};
Othello_IconPath[3] = { WoW = "Interface\\Icons\\INV_Misc_Bomb_04", Custom = "Interface\\AddOns\\MiniGames\\Skin\\Connect\\Red"};

function Othello_ChangeValue(x, y, icon_state)
	local State = getglobal("OthelloButton"..x.."_"..y.."State");
	local Button = getglobal("OthelloButton"..x.."_"..y);
	local IconTexture = getglobal("OthelloButton"..x.."_"..y.."IconTexture");

	if (icon_state == 1) then
		IconTexture:Hide();
		State:SetText("1");
	else
		if (GamesList_UseCustomIcons == 0) then
			IconTexture:SetTexture(Othello_IconPath[icon_state * 1].WoW);
		else
			IconTexture:SetTexture(Othello_IconPath[icon_state * 1].Custom);
		end
		IconTexture:Show();
		State:SetText(icon_state);
	end
end

function Othello_SetUpBoard()
	for y = 1, 8 do
		for i = 1, 8 do
			Othello_ChangeValue(y, i, 1);
			Othello_UnCheck(y, i);
		end
	end
	Othello_ChangeValue(4,4,3);
	Othello_ChangeValue(5,5,3);
	Othello_ChangeValue(5,4,2);
	Othello_ChangeValue(4,5,2);

	OthelloButtonRestart:Disable();
	Othello_UpdateScores();
end

function Othello_Check(x, y)
	local Button = getglobal("OthelloButton"..x.."_"..y);
	Button:SetChecked("true");
end

function Othello_UnCheck(x, y)
	local Button = getglobal("OthelloButton"..x.."_"..y);
	Button:SetChecked("false");
end

function Othello_ClearSelected()
	for y = 1, 8 do
		for i = 1, 8 do
			local Button = getglobal("OthelloButton"..i.."_"..y);
			Button:SetChecked("false");
		end
	end
end

function Othello_ButtonState(x, y)
	local State = getglobal("OthelloButton"..x.."_"..y.."State");
	return State:GetText() * 1;
end

function Othello_MoveTest(x,y)
	HasMove = false;
	for y = 1, 8 do
		for i = 1, 8 do
			if (Othello_ValidMove(i,y)==true) then
				HasMove = true;
			end
		end
	end
	return(HasMove);
end

function Othello_GetBoardState(x, y)
	local State = getglobal("OthelloButton"..x.."_"..y.."State");
	return State:GetText() * 1;
end

function Othello_RecursiveTest(x, y, a, b)
	TestX = x + a;
	TestY = y + b;
	if ((TestX<1 or TestX>8)or(TestY<1 or TestY>8)) then
		return false;
	elseif (Othello_GetBoardState(TestX, TestY) == 1) then
		return false;
	elseif (Othello_GetBoardState(TestX, TestY) == GamesList_CurrentCaseType) then
		return true;
	else
		return Othello_RecursiveTest(TestX, TestY, a, b);
	end
end

function Othello_DirectionTest(x, y, a, b)
	TestX = x + a;
	TestY = y + b;
	if ((TestX<1 or TestX>8)or(TestY<1 or TestY>8)) then
		return false;
	elseif (Othello_GetBoardState(TestX, TestY)==TicTacToe_Invert(GamesList_CurrentCaseType)) then
		return Othello_RecursiveTest(TestX, TestY, a, b);
	end
	return false;
end

function Othello_FindFlips(x, y, a, b)
	TestX = x + a;
	TestY = y + b;
	if (Othello_GetBoardState(TestX, TestY) == GamesList_CurrentCaseType) then
		return;
	elseif (Othello_GetBoardState(TestX, TestY) == TicTacToe_Invert(GamesList_CurrentCaseType)) then
		Othello_ChangeValue(TestX, TestY, GamesList_CurrentCaseType);
		Othello_FindFlips(TestX, TestY, a, b);
	end
end

function Othello_DoMove(x, y)
	if (Othello_DirectionTest(x, y, 0, -1) == true) then
		Othello_FindFlips(x, y, 0, -1);
	end
	if (Othello_DirectionTest(x, y, 1, -1) == true) then
		Othello_FindFlips(x, y, 1, -1);
	end
	if (Othello_DirectionTest(x, y, 1, 0) == true) then
		Othello_FindFlips(x, y, 1, 0);
	end
	if (Othello_DirectionTest(x, y, 1, 1) == true) then
		Othello_FindFlips(x, y, 1, 1);
	end
	if (Othello_DirectionTest(x, y, 0, 1) == true) then
		Othello_FindFlips(x, y, 0, 1);
	end
	if (Othello_DirectionTest(x, y, -1, -1) == true) then
		Othello_FindFlips(x, y, -1, -1);
	end
	if (Othello_DirectionTest(x, y, -1, 0) == true) then
		Othello_FindFlips(x, y, -1, 0);
	end
	if (Othello_DirectionTest(x, y, -1, 1) == true) then
		Othello_FindFlips(x, y, -1, 1);
	end
end

function Othello_CheckMove(x, y)
	OK = false;
	if (Othello_DirectionTest(x, y, 0, -1) == true) then
		OK = true;
	elseif (Othello_DirectionTest(x, y, 1, -1) == true) then
		OK = true;
	elseif (Othello_DirectionTest(x, y, 1, 0) == true) then
		OK = true;
	elseif (Othello_DirectionTest(x, y, 1, 1) == true) then
		OK = true;
	elseif (Othello_DirectionTest(x, y, 0, 1) == true) then
		OK = true;
	elseif (Othello_DirectionTest(x, y, -1, -1) == true) then
		OK = true;
	elseif (Othello_DirectionTest(x, y, -1, 0) == true) then
		OK = true;
	elseif (Othello_DirectionTest(x, y, -1, 1) == true) then
		OK = true;
	end
	return OK;
end

function Othello_ValidMove(x, y)
	if (Othello_GetBoardState(x,y) ~= 1) then
		Othello_InfoChange(OTHELLO_ERROR1);
		return false;
	elseif (Othello_CheckMove(x, y)~=true) then
		Othello_InfoChange(OTHELLO_ERROR2);
		return false;
	end
	return true;
end

function Othello_InfoChange(msg)
	OthelloInfo:SetText(msg);
end

function Othello_SendInfo(Type, Arg1, Arg2, Arg3)
	GamesList_SendMessage(GamesList_CurrentVersus, 3, Type, Arg1, Arg2, Arg3);
end

function Othello_GetData(Who, Type, Arg1, Arg2, Arg3)
	Type = Type * 1;

	if (Type == 1) then -- Start
		GamesList_CurrentState = 2;
		GamesList_CurrentCaseType = 2;
		GamesList_CurrentTurn = 1;
		GamesList_CurrentVersus = Who;
		GamesList_SendMessage(nil, 2);
		ShowUIPanel(OthelloFrame);
		Othello_SetUpBoard();

	elseif (Who ~= GamesList_CurrentVersus) then
		return;

	elseif (Type == 2) then -- New Case
		if (Arg1 * 1 ~= 0) then
			Othello_ClearSelected();
			Othello_ChangeValue(Arg1 * 1, Arg2 * 1, (TicTacToe_Invert(GamesList_CurrentCaseType)));

			GamesList_CurrentCaseType = TicTacToe_Invert(GamesList_CurrentCaseType);
			Othello_Check(Arg1 * 1, Arg2 * 1);
			Othello_DoMove(Arg1 * 1, Arg2 * 1);
			GamesList_CurrentCaseType = TicTacToe_Invert(GamesList_CurrentCaseType);

			GamesList_CurrentTurn = 1;

			if (Othello_MoveTest() == false) then
				if (Othello_MoveTest() == false) then
					OthelloButtonRestart:Enable();
					ME = OthelloScoreLeft2:GetText();
					YOU = OthelloScoreRight2:GetText();
					if (ME==YOU) then
						Othello_SendInfo(5);
						Othello_InfoChange(OTHELLO_DRAW);
					elseif (ME<YOU) then
						Othello_SendInfo(3);
						Othello_InfoChange(OTHELLO_YOUWIN);
					else
						Othello_SendInfo(4);
						Othello_InfoChange(format(OTHELLO_VSWIN,GamesList_CurrentVersus));
						OthelloButtonRestart:Enable();
					end
				else
					Othello_InfoChange(OTHELLO_ERROR3);
					GamesList_CurrentTurn = 0;
					Othello_SendInfo(2, 0, 0, 0);
				end
			else
				Othello_InfoChange(OTHELLO_VSMOVED);
			end
			Othello_UpdateScores();
		else
			Othello_InfoChange(OTHELLO_VSCANTMOVE);
			GamesList_CurrentTurn = 1;
			Othello_UpdateScores();
		end

	elseif (Type == 3) then -- Win
		OthelloButtonRestart:Enable();
		Othello_InfoChange(GamesList_CurrentVersus..OTHELLO_VSWIN);

	elseif (Type == 4) then -- Loose
		OthelloButtonRestart:Enable();
		Othello_InfoChange(OTHELLO_YOUWIN);

	elseif (Type == 5) then -- Draw
		OthelloButtonRestart:Enable();
		Othello_InfoChange(OTHELLO_DRAW);

	elseif (Type == 6) then -- Restart
		OthelloButtonRestart:Disable();
		GamesList_CurrentTurn = 0;
		Othello_SetUpBoard();
		Othello_InfoChange(OTHELLO_WELCOME);

	elseif (Type == 7) then -- Quit
		GamesList_Leave(GamesList_CurrentVersus);
		GamesList_CurrentVersus = "";
		HideUIPanel(OthelloFrame);
		GamesList_CurrentState = 0;
	end
end

function Othello_UpdateScores()
	SCORE1 = 0;
	SCORE2 = 0;
	for y = 1, 8 do
		for i = 1, 8 do
			if (Othello_GetBoardState(i,y) == GamesList_CurrentCaseType) then
				SCORE1 = SCORE1 + 1;
			elseif (Othello_GetBoardState(i,y) == TicTacToe_Invert(GamesList_CurrentCaseType)) then
				SCORE2 = SCORE2 + 1;
			end
		end
	end
	if (GamesList_UseCustomIcons == 0) then
		OthelloButtonLeftIconTexture:SetTexture(Othello_IconPath[GamesList_CurrentCaseType].WoW);
		OthelloButtonRightIconTexture:SetTexture(Othello_IconPath[TicTacToe_Invert(GamesList_CurrentCaseType)].WoW);
	else
		OthelloButtonLeftIconTexture:SetTexture(Othello_IconPath[GamesList_CurrentCaseType].Custom);
		OthelloButtonRightIconTexture:SetTexture(Othello_IconPath[TicTacToe_Invert(GamesList_CurrentCaseType)].Custom);
	end
	OthelloButtonRightIconTexture:Show();
	OthelloButtonLeftIconTexture:Show();

	OthelloScoreLeft2:SetText(SCORE1);
	OthelloScoreRight2:SetText(SCORE2);
	OthelloNameLeft:SetText(UnitName("player"));
	OthelloNameRight:SetText(GamesList_CurrentVersus);
	if (GamesList_CurrentTurn ~= 0) then
		OthelloButtonLeft:SetChecked("true");
		OthelloButtonRight:SetChecked("false");
	else
		OthelloButtonLeft:SetChecked("false");
		OthelloButtonRight:SetChecked("true");
	end
end

function Othello_Restart_OnClick()
	OthelloButtonRestart:Disable();
	Othello_SendInfo(6);
	GamesList_CurrentTurn = 1;
	Othello_SetUpBoard();
end

function Othello_OnHide()
	if (GamesList_CurrentVersus ~= "") then
		Othello_Quit_OnClick();
	end
end

function Othello_Quit_OnClick()
	Othello_UpdateScores();
	Othello_SendInfo(7);
	GamesList_CurrentVersus = "";
	HideUIPanel(OthelloFrame);
	GamesList_CurrentState = 0;
end

function Othello_Start(Who)
	ShowUIPanel(OthelloFrame);
	GamesList_CurrentCaseType = 3;
	GamesList_CurrentTurn = 0;
	Othello_UpdateScores();
	GamesList_CurrentVersus = Who;
	Othello_SendInfo(1);
	Othello_OnLoad();
end

function Othello_OnLoad()
	OthelloTitle:SetText(GamesList_Options[3].Name);
	OthelloAnchorRight:Hide();
	OthelloButtonRestart:Disable();
	Othello_SetUpBoard();
	GamesList_ScoreLeft = 0;
	GamesList_ScoreRight = 0;
	GamesList_CurrentState = 2;
end

function Othello_OnClick()
	Othello_UpdateScores();
	if (this:GetID() * 1 < 1) then PlaySound("igCharacterInfoClose"); return; end
	local x = strsub(this:GetID(), 1, 1) * 1;
	local y = strsub(this:GetID(), 2, 2) * 1;
	if ( (GamesList_CurrentTurn == 1) and ( Othello_ValidMove(x, y) == true) ) then
		Othello_ClearSelected();
		GamesList_CurrentTurn = 0;
		Othello_UpdateScores();
		Othello_ChangeValue(x, y, GamesList_CurrentCaseType);
		Othello_DoMove(x, y);
		Othello_Check(x, y);
		Othello_UpdateScores();
		Othello_SendInfo(2, x, y);
		Othello_InfoChange(OTHELLO_WAITVSMOVE);
		this:SetChecked("true");
		PlaySound("gsLoginChangeRealmOK");
		return;
	end
	PlaySound("igCharacterInfoClose");
	this:SetChecked("false");
end
