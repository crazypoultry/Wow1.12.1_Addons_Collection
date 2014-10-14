--------------------------------------------------------------------------
-- ConnectFrame.lua
--------------------------------------------------------------------------
--[[
MiniGames

	$Id: ConnectFrame.lua 3159 2006-03-07 22:34:10Z gryphon $
	$Rev: 3159 $
	$LastChangedBy: gryphon $
	$Date: 2006-03-07 16:34:10 -0600 (Tue, 07 Mar 2006) $

]]--

UIPanelWindows["ConnectFrame"] = { area = "center",	pushable = 0 };

Connect_IconPath = { };
Connect_IconPath[2] = { WoW = "Interface\\Icons\\INV_Misc_Bomb_03", Custom = "Interface\\AddOns\\MiniGames\\Skin\\Connect\\BlackKing"};
Connect_IconPath[3] = { WoW = "Interface\\Icons\\INV_Misc_Bomb_04", Custom = "Interface\\AddOns\\MiniGames\\Skin\\Connect\\Red"};
Connect_IconPath[4] = { WoW = "Interface\\Icons\\Spell_Nature_NullifyPoison_02", Custom = "Interface\\AddOns\\MiniGames\\Skin\\Connect\\BlueArrow"};
Connect_IconPath[5] = { WoW = "Interface\\Icons\\Spell_Shadow_VampiricAura", Custom = "Interface\\AddOns\\MiniGames\\Skin\\Connect\\RedArrow"};

function Connect_Clear()
	for y = 1, 7 do
		for i = 1, 7 do
			Connect_ChangeValue(y, i, 1);
		end
	end
end

function Connect_Check(x, y)
	local Button = getglobal("ConnectButton"..x.."_"..y);
	Button:SetChecked("true");
end

function Connect_UnCheck(x, y)
	local Button = getglobal("ConnectButton"..x.."_"..y);
	Button:SetChecked("false");
end

function Connect_ClearSelected()
	for y = 1, 7 do
		local Button = getglobal("ConnectButton".."1_"..y);
		Button:SetChecked("false");
	end
end

function Connect_ClearSelectedAll()
	for y = 1, 7 do
		for i = 1, 7 do
			local Button = getglobal("ConnectButton"..i.."_"..y);
			Button:SetChecked("false");
		end
	end
end

function Connect_ChangeValue(x, y, icon_state)
	local State = getglobal("ConnectButton"..x.."_"..y.."State");
	local Button = getglobal("ConnectButton"..x.."_"..y);
	local IconTexture = getglobal("ConnectButton"..x.."_"..y.."IconTexture");

	if (icon_state == 1) then
		IconTexture:Hide();
		State:SetText("1");
	else
		if (GamesList_UseCustomIcons == 0) then
			IconTexture:SetTexture(Connect_IconPath[icon_state * 1].WoW);
		else
			IconTexture:SetTexture(Connect_IconPath[icon_state * 1].Custom);
		end
		IconTexture:Show();
		State:SetText(icon_state);
	end

	Connect_ClearSelected();
end

function Connect_ButtonState(x, y)
	local State = getglobal("ConnectButton"..x.."_"..y.."State");
	return State:GetText() * 1;
end

function Connect_WinTest(x,y)
	local score_haut = 0;
	local score_diag1 = 0;
	local score_diag2 = 0;
	local score_horiz = 0;
	local result = 0;

	-- Cherche sur la ligne
	for i = 0, 3 do
		score_horiz = 0;
		for j = 0, 3 do
			if ( ( y - i + j > 0 ) and ( y - i + j < 8 ) ) then
				if ( Connect_ButtonState(x, y - i + j) == GamesList_CurrentCaseType ) then
					score_horiz = score_horiz + 1;
				end
			end
		end
		if (score_horiz == 4) then
			for j = 0, 3 do
				Connect_Check(x, y - i + j);
			end
			result = 1;
		end
	end
	-- Cherche de haut en bas
	score_haut = 0;
	for i = 0, 3 do
		if ( x + i < 8 ) then
			if ( Connect_ButtonState(x + i, y) == GamesList_CurrentCaseType ) then
				score_haut = score_haut + 1;
			end
		end
	end
	if (score_haut == 4) then
		for i = 0, 3 do
			Connect_Check(x + i, y);
		end
		result = 1;
	end
	-- Cherche diagonale \
	for i = 0, 3 do
		score_diag1 = 0;
		for j = 0, 3 do
			if ( ( y - i + j > 0 ) and ( y - i + j < 8 ) and ( x - i + j > 0 ) and ( x - i + j < 8 ) ) then
				if ( Connect_ButtonState(x - i + j, y - i + j) == GamesList_CurrentCaseType ) then
					score_diag1 = score_diag1 + 1;
				end
			end
		end
		if (score_diag1 == 4) then
			for j = 0, 3 do
				Connect_Check(x - i + j, y - i + j);
			end
			result = 1;
		end
	end

	-- Cherche diagonale /
	for i = 0, 3 do
		score_diag2 = 0;
		for j = 0, 3 do
			if ( ( y - i + j > 0 ) and ( y - i + j < 8 ) and ( x + i - j > 0 ) and ( x + i - j < 8 ) ) then
				if ( Connect_ButtonState(x + i - j, y - i + j) == GamesList_CurrentCaseType ) then
					score_diag2 = score_diag2 + 1;
				end
			end
		end
		if (score_diag2 == 4) then
			for j = 0, 3 do
				Connect_Check(x + i - j, y - i + j);
			end
		result = 1;
		end
	end
	if (result == 1) then
		for i = 1, 7 do
			Connect_ChangeValue(1, i, 5);
		end
	end

	for i = 2, 7 do
		for y = 1, 7 do
			if (Connect_ButtonState(i, y) == 1) then
				return result;
			end
		end
	end
	return -1;
end

function Connect_SearchCase(col)
	for i = 1, 6 do
		if ( Connect_ButtonState(8 - i, col * 1) == 1 ) then
			return 8 - i;
		end
	end
end

function Connect_UpdateBorders()
	Connect_ClearSelected();
	ConnectNameLeft:SetText(UnitName("player"));
	ConnectNameRight:SetText(GamesList_CurrentVersus);
	ConnectScoreLeft:SetText(GamesList_ScoreLeft);
	ConnectScoreRight:SetText(GamesList_ScoreRight);

	if (GamesList_UseCustomIcons == 0) then
		ConnectButtonLeftIconTexture:SetTexture(Connect_IconPath[GamesList_CurrentCaseType].WoW);
		ConnectButtonRightIconTexture:SetTexture(Connect_IconPath[Connect_Invert(GamesList_CurrentCaseType)].WoW);
	else
		ConnectButtonLeftIconTexture:SetTexture(Connect_IconPath[GamesList_CurrentCaseType].Custom);
		ConnectButtonRightIconTexture:SetTexture(Connect_IconPath[Connect_Invert(GamesList_CurrentCaseType)].Custom);
	end
	ConnectButtonRightIconTexture:Show();
	ConnectButtonLeftIconTexture:Show();

	if (GamesList_CurrentTurn ~= 0) then
		ConnectButtonLeft:SetChecked("true");
		ConnectButtonRight:SetChecked("false");
	else
		ConnectButtonLeft:SetChecked("false");
		ConnectButtonRight:SetChecked("true");
	end
end

function Connect_Invert(inv)
	if (inv == 3) then
		return 2;
	else
		return 3;
	end
end

function Connect_SendInfo(Type, Arg1, Arg2, Arg3)
	GamesList_SendMessage(GamesList_CurrentVersus, 2, Type, Arg1, Arg2, Arg3);
end

function Connect_GetData(Who, Type, Arg1, Arg2, Arg3)
	Type = Type * 1;

	if (Type == 1) then -- Start
		ShowUIPanel(ConnectFrame);
		GamesList_CurrentState = 2;
		GamesList_CurrentCaseType = 2;
		GamesList_CurrentTurn = 1;
		GamesList_CurrentVersus = Who;
		GamesList_SendMessage(nil, 2);
		ShowUIPanel(ConnectFrame);
		Connect_UpdateBorders();

	elseif (Who ~= GamesList_CurrentVersus) then
		return;

	elseif (Type == 2) then -- New Case
		local NextX = Connect_SearchCase(Arg1);
		Connect_ChangeValue(NextX * 1, Arg1 * 1, Connect_Invert(GamesList_CurrentCaseType));
		Connect_ClearSelected();
		Connect_UnCheck(NextX, Arg1 * 1);
		GamesList_CurrentTurn = 1;
		Connect_UpdateBorders();
		if (NextX == 2) then
			Connect_ChangeValue(1, Arg1 * 1, 5);
		end
		GamesList_CurrentCaseType = Connect_Invert(GamesList_CurrentCaseType);
		local WinTest = Connect_WinTest(NextX, Arg1 * 1);
		if (WinTest == 1) then
			ConnectButtonRestart:Enable();
			GamesList_ScoreRight = GamesList_ScoreRight + 1;
		elseif (WinTest == -1) then
			ConnectButtonRestart:Enable();
		end
		GamesList_CurrentCaseType = Connect_Invert(GamesList_CurrentCaseType);

	elseif (Type == 3) then -- Win
		Connect_Clear();
		GamesList_ScoreRight = GamesList_ScoreRight + 1;

	elseif (Type == 4) then -- Draw
		Connect_Clear();

	elseif (Type == 5) then -- Quit
		GamesList_Leave(GamesList_CurrentVersus);
		Connect_Clear();
		HideUIPanel(ConnectFrame);
		GamesList_CurrentVersus = "";
		GamesList_CurrentState = 0;

	elseif (Type == 6) then -- New Game
		GamesList_CurrentTurn = 1;
		Connect_Clear();
		Connect_ClearSelectedAll();
		ConnectButtonRestart:Disable();
		for i = 1, 7 do
			Connect_ChangeValue(1, i, 4);
		end

	end
end

function Connect_Start(Who)
	ShowUIPanel(ConnectFrame);
	GamesList_CurrentState = 2;
	GamesList_CurrentCaseType = 3;
	GamesList_CurrentTurn = 0;
	GamesList_CurrentVersus = Who;
	GamesList_ScoreLeft = 0;
	GamesList_ScoreRight = 0;
	Connect_SendInfo(1);
	Connect_OnLoad();
end

function Connect_Restart_OnClick()
	ConnectButtonRestart:Disable();
	GamesList_CurrentTurn = 0;
	Connect_SendInfo(6);
	Connect_Clear();
	Connect_ClearSelectedAll();
	for i = 1, 7 do
		Connect_ChangeValue(1, i, 4);
	end
	Connect_UpdateBorders();
end

function Connect_OnLoad()
	ConnectTitle:SetText(GamesList_Options[2].Name);
	GamesList_ScoreLeft = 0;
	GamesList_ScoreRight = 0;
	ConnectButtonRestart:Disable();
	Connect_Clear();
	Connect_ClearSelectedAll();
	GamesList_CurrentTurn = 0;
	for i = 1, 7 do
		Connect_ChangeValue(1, i, 4);
	end
	Connect_UpdateBorders();
end

function Connect_OnHide()
	if (GamesList_CurrentVersus ~= "") then
		Connect_Quit_OnClick();
	end
end

function Connect_Quit_OnClick()
	Connect_SendInfo(5);
	GamesList_CurrentVersus = "";
	GamesList_CurrentState = 0;
	HideUIPanel(ConnectFrame);
end

function Connect_OnClick()
	local x = strsub(this:GetID(), 1, 1) * 1;
	local y = strsub(this:GetID(), 2, 2) * 1;

	if ( (GamesList_CurrentTurn == 1) and ( Connect_ButtonState(x, y) == 4) ) then
		GamesList_CurrentTurn = 0;
		local NextX = Connect_SearchCase(y);
		Connect_ChangeValue(NextX, y, GamesList_CurrentCaseType);
		Connect_SendInfo(2, y);
		Connect_ClearSelected();

		this:SetChecked("true");
		PlaySound("gsLoginChangeRealmOK");

		if (NextX == 2) then
			Connect_ChangeValue(1, y, 5);
		end

		local WinTest = Connect_WinTest(NextX, y);
		if (WinTest == -1) then -- Draw
			ConnectButtonRestart:Enable();
			Connect_UpdateBorders();
		elseif (WinTest == 1) then -- Win
			GamesList_ScoreLeft = GamesList_ScoreLeft + 1;
			ConnectButtonRestart:Enable();
			Connect_UpdateBorders();
		end
		Connect_UpdateBorders();
		return;
	else
		if ( this:GetChecked() == 1 ) then
			this:SetChecked("true");
		else
			this:SetChecked("false");
		end
	end
	PlaySound("igCharacterInfoClose");
	Connect_UpdateBorders();
end
