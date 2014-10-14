--------------------------------------------------------------------------
-- MinesweeperFrame.lua
--------------------------------------------------------------------------
--[[
MiniGames

	$Id: MinesweeperFrame.lua 3159 2006-03-07 22:34:10Z gryphon $
	$Rev: 3159 $
	$LastChangedBy: gryphon $
	$Date: 2006-03-07 16:34:10 -0600 (Tue, 07 Mar 2006) $

]]--

UIPanelWindows["MinesweeperFrame"] = { area = "center",	pushable = 0 };

MinesweeperColors = { };
MinesweeperColors[1] = { r = 1.00, g = 1.00, b = 0.00 };
MinesweeperColors[2] = { r = 1.00, g = 0.50, b = 0.00 };
MinesweeperColors[3] = { r = 0.00, g = 0.50, b = 0.00 };
MinesweeperColors[4] = { r = 1.00, g = 0.00, b = 1.00 };
MinesweeperColors[5] = { r = 0.50, g = 0.00, b = 0.00 };
MinesweeperColors[6] = { r = 0.00, g = 0.50, b = 0.50 };
MinesweeperColors[7] = { r = 0.00, g = 0.00, b = 0.00 };
MinesweeperColors[8] = { r = 0.51, g = 0.51, b = 0.51 };

function Minesweeper_UncheckAll()
	for y = 1, 16 do
		for i = 1, 16 do
			getglobal("MinesweeperButton"..Minesweeper_ConvertIntToHex(y).."_"..Minesweeper_ConvertIntToHex(i)):SetChecked("false");
		end
	end
end

function Minesweeper_DoStart(str)
	for y = 1, 16 do
		for i = 1, 16 do
			Minesweeper_ChangeValue(y, i, -1);
			Minesweeper_ShowCase(y, i);
		end
	end
	if (str) then
		for i = 1, 51, 1 do
			Minesweeper_ChangeValue(Minesweeper_ConvertHexToInt(strsub(str, 1, 1)) * 1, Minesweeper_ConvertHexToInt(strsub(str, 2, 2)) * 1, -4);
			str = strsub(str, 3, strlen(str));
		end
	else
		str = "";
		local i = 1;
		while (i <= 51) do
			local z = round(math.random(1, 16));
			local y = round(math.random(1, 16));
			if (Minesweeper_ButtonState(y, z) ~= -4) then
				Minesweeper_ChangeValue(y, z, -4);
				i = i + 1;
				str = str..Minesweeper_ConvertIntToHex(y)..Minesweeper_ConvertIntToHex(z);
			end
		end
	end
	for i = 1, 16, 1 do
		for y = 1, 16, 1 do
			if (Minesweeper_ButtonState(i, y) ~= -4) then
				local z = 0;
				if (Minesweeper_ButtonState(i - 1, y - 1) == -4) then z = z + 1; end
				if (Minesweeper_ButtonState(i    , y - 1) == -4) then z = z + 1; end
				if (Minesweeper_ButtonState(i + 1, y - 1) == -4) then z = z + 1; end
				if (Minesweeper_ButtonState(i - 1, y + 1) == -4) then z = z + 1; end
				if (Minesweeper_ButtonState(i    , y + 1) == -4) then z = z + 1; end
				if (Minesweeper_ButtonState(i + 1, y + 1) == -4) then z = z + 1; end
				if (Minesweeper_ButtonState(i - 1, y    ) == -4) then z = z + 1; end
				if (Minesweeper_ButtonState(i + 1, y    ) == -4) then z = z + 1; end

				Minesweeper_ChangeValue(i, y, z);
			end
		end
	end
	return str;
end

function Minesweeper_ConvertIntToHex(int)
	if (int == 10) then
		return "a";
	elseif (int == 11) then
		return "b";
	elseif (int == 12) then
		return "c";
	elseif (int == 13) then
		return "d";
	elseif (int == 14) then
		return "e";
	elseif (int == 15) then
		return "f";
	elseif (int == 16) then
		return "g";
	else
		return int;
	end
end

function Minesweeper_ConvertHexToInt(hex)
	if (hex == "a") then
		return 10;
	elseif (hex == "b") then
		return 11;
	elseif (hex == "c") then
		return 12;
	elseif (hex == "d") then
		return 13;
	elseif (hex == "e") then
		return 14;
	elseif (hex == "f") then
		return 15;
	elseif (hex == "g") then
		return 16;
	else
		return hex;
	end
end

function Minesweeper_ButtonClick(x, y)
	if (Minesweeper_ButtonState(x, y) == 0) then
		Minesweeper_ShowCase(x, y);
		if (Minesweeper_ButtonState(x - 1, y - 1) ~= 0) then Minesweeper_ShowCase(x - 1, y - 1); else Minesweeper_ButtonClick(x - 1, y - 1); end
		if (Minesweeper_ButtonState(x    , y - 1) ~= 0) then Minesweeper_ShowCase(x    , y - 1); else Minesweeper_ButtonClick(x    , y - 1); end
		if (Minesweeper_ButtonState(x + 1, y - 1) ~= 0) then Minesweeper_ShowCase(x + 1, y - 1); else Minesweeper_ButtonClick(x + 1, y - 1); end
		if (Minesweeper_ButtonState(x - 1, y + 1) ~= 0) then Minesweeper_ShowCase(x - 1, y + 1); else Minesweeper_ButtonClick(x - 1, y + 1); end
		if (Minesweeper_ButtonState(x    , y + 1) ~= 0) then Minesweeper_ShowCase(x    , y + 1); else Minesweeper_ButtonClick(x    , y + 1); end
		if (Minesweeper_ButtonState(x + 1, y + 1) ~= 0) then Minesweeper_ShowCase(x + 1, y + 1); else Minesweeper_ButtonClick(x + 1, y + 1); end
		if (Minesweeper_ButtonState(x - 1, y    ) ~= 0) then Minesweeper_ShowCase(x - 1, y    ); else Minesweeper_ButtonClick(x - 1, y    ); end
		if (Minesweeper_ButtonState(x + 1, y    ) ~= 0) then Minesweeper_ShowCase(x + 1, y    ); else Minesweeper_ButtonClick(x + 1, y    ); end
	else
		Minesweeper_ShowCase(x, y);
	end
end

function Minesweeper_IsVisible(x, y)
	if (x < 1 or x > 16 or y < 1 or y > 16) then return; end

	x = Minesweeper_ConvertIntToHex(x);
	y = Minesweeper_ConvertIntToHex(y);

	return getglobal("MinesweeperButton"..y.."_"..x):IsVisible();
end

function Minesweeper_ShowCase(x, y)
	if (x < 1 or x > 16 or y < 1 or y > 16) then return; end

	local icon_state = Minesweeper_ButtonState(x, y);

	x = Minesweeper_ConvertIntToHex(x);
	y = Minesweeper_ConvertIntToHex(y);

	local State = getglobal("MinesweeperButton"..y.."_"..x.."State");
	local Number = getglobal("MinesweeperButton"..y.."_"..x.."Number");
	local XX = getglobal("MinesweeperButton"..y.."_"..x.."XX");
	local Button = getglobal("MinesweeperButton"..y.."_"..x);
	local Discovered = getglobal("MinesweeperButton"..y.."_"..x.."Discovered");
	local IconTexture = getglobal("MinesweeperButton"..y.."_"..x.."IconTexture");


	Discovered:SetText("1");

	if (GamesList_UseCustomIcons == 1) then
		Number:Hide();
		XX:Hide();
		Button:Show();
		IconTexture:Show();
		if (icon_state == -4) then
			if (GamesList_CurrentTurn == 1) then
				IconTexture:SetTexture("Interface\\AddOns\\MiniGames\\Skin\\Minesweeper\\RB");
			else
				IconTexture:SetTexture("Interface\\AddOns\\MiniGames\\Skin\\Minesweeper\\BB");
			end

		elseif (icon_state == -1) then
			IconTexture:SetTexture("Interface\\AddOns\\MiniGames\\Skin\\Minesweeper\\0");

		elseif (icon_state == 0) then
			IconTexture:SetTexture("Interface\\AddOns\\MiniGames\\Skin\\Minesweeper\\_0");
			State:SetText("-5");

		elseif (icon_state > 0) then
			IconTexture:SetTexture("Interface\\AddOns\\MiniGames\\Skin\\Minesweeper\\"..icon_state);
		end
	else
		if (icon_state == -4) then
			Button:Show();
			Number:Hide();
			IconTexture:Hide();
			Number:Hide();
			XX:Show();
			if (GamesList_CurrentTurn == 1) then
				XX:SetTextColor(1.00, 0.00, 0.00);
			else
				XX:SetTextColor(0.00, 0.00, 1.00);
			end

		elseif (icon_state == -1) then
			Button:Show();
			Number:Hide();
			XX:Hide();
			IconTexture:Hide();

		elseif (icon_state == 0) then
			Button:Hide();
			XX:Hide();
			State:SetText("-5");

		elseif (icon_state > 0) then
			IconTexture:Hide();
			XX:Hide();
			Button:Show();
			Number:Show();
			Number:SetText(icon_state);
			Number:SetTextColor(MinesweeperColors[icon_state].r, MinesweeperColors[icon_state].g, MinesweeperColors[icon_state].b);
		end
	end
end

function Minesweeper_ChangeValue(x, y, icon_state, hide)
	if (x < 1 or x > 16 or y < 1 or y > 16) then return; end

	x = Minesweeper_ConvertIntToHex(x);
	y = Minesweeper_ConvertIntToHex(y);

	local State = getglobal("MinesweeperButton"..y.."_"..x.."State");
	local Discovered = getglobal("MinesweeperButton"..y.."_"..x.."Discovered");

	Discovered:SetText("0");
	State:SetText(icon_state);
end

function Minesweeper_ButtonState(x, y)
	if (x < 1 or x > 16 or y < 1 or y > 16) then return; end

	x = Minesweeper_ConvertIntToHex(x);
	y = Minesweeper_ConvertIntToHex(y);

	local State = getglobal("MinesweeperButton"..y.."_"..x.."State");
	return State:GetText() * 1;
end

function Minesweeper_UpdateBorders()
	MinesweeperNameLeft:SetText(UnitName("player"));
	MinesweeperNameRight:SetText(GamesList_CurrentVersus);
	MinesweeperScoreLeft:SetText(GamesList_ScoreLeft);
	MinesweeperScoreRight:SetText(GamesList_ScoreRight);
	MinesweeperScoreMiddle:SetText(51 - GamesList_ScoreRight - GamesList_ScoreLeft);

	if (GamesList_UseCustomIcons == 1) then
		MinesweeperButtonLeftXX:Hide();
		MinesweeperButtonRightXX:Hide();
		MinesweeperButtonLeftIconTexture:SetTexture("Interface\\AddOns\\MiniGames\\Skin\\Minesweeper\\RB");
		MinesweeperButtonRightIconTexture:SetTexture("Interface\\AddOns\\MiniGames\\Skin\\Minesweeper\\BB");
		MinesweeperButtonLeftIconTexture:Show();
		MinesweeperButtonRightIconTexture:Show();
	else
		MinesweeperButtonLeftXX:Show();
		MinesweeperButtonRightXX:Show();
		MinesweeperButtonLeftXX:SetVertexColor(1.00, 0.00, 0.00);
		MinesweeperButtonRightXX:SetVertexColor(0.00, 0.00, 1.00);
	end

	if (GamesList_CurrentTurn ~= 0) then
		MinesweeperButtonLeft:SetChecked("true");
		MinesweeperButtonRight:SetChecked("false");
	else
		MinesweeperButtonLeft:SetChecked("false");
		MinesweeperButtonRight:SetChecked("true");
	end
	Minesweeper_UncheckAll();
end

function Minesweeper_SendInfo(Type, Arg1, Arg2, Arg3)
	GamesList_SendMessage(GamesList_CurrentVersus, 5, Type, Arg1, Arg2, Arg3);
end

function Minesweeper_GetData(Who, Type, Arg1, Arg2, Arg3)
	Type = Type * 1;

	if (Type == 1) then -- Start
		ShowUIPanel(MinesweeperFrame);
		GamesList_CurrentState = 2;
		GamesList_CurrentCaseType = 2;
		GamesList_CurrentTurn = 1;
		GamesList_CurrentVersus = Who;
		GamesList_SendMessage(nil, 2);
		MinesweeperButtonRestart:Disable();
		ShowUIPanel(MinesweeperFrame);
		Minesweeper_DoStart(Arg1);
		Minesweeper_UpdateBorders();

	elseif (Who ~= GamesList_CurrentVersus) then
		return;

	elseif (Type == 2) then -- Case
		Minesweeper_ButtonClick(Arg1 * 1, Arg2 * 1);
		GamesList_CurrentTurn = Arg3 * 1;
		if (Arg3 * 1 == 0) then
			GamesList_ScoreRight = GamesList_ScoreRight + 1;
			if (GamesList_ScoreRight == 26) then
				message(format(OTHELLO_VSWIN,GamesList_CurrentVersus));
				MinesweeperButtonRestart:Enable();
			end
		end
		Minesweeper_UpdateBorders();
		getglobal("MinesweeperButton"..Minesweeper_ConvertIntToHex(Arg2 * 1).."_"..Minesweeper_ConvertIntToHex(Arg1 * 1)):SetChecked("true");

	elseif (Type == 3) then -- Leave
		GamesList_Leave(GamesList_CurrentVersus);
		GamesList_CurrentVersus = "";
		HideUIPanel(MinesweeperFrame);
		GamesList_CurrentState = 0;

	end
end

function Minesweeper_Start(Who)
	ShowUIPanel(MinesweeperFrame);
	GamesList_CurrentState = 2;
	GamesList_CurrentTurn = 0;
	GamesList_CurrentVersus = Who;
	Minesweeper_SendInfo(1, Minesweeper_DoStart());
	Minesweeper_OnLoad();
end

function Minesweeper_OnLoad()
	MinesweeperTitle:SetText(GamesList_Options[5].Name);
	MinesweeperButtonRestart:Disable();
	GamesList_ScoreLeft = 0;
	GamesList_ScoreRight = 0;
	Minesweeper_UpdateBorders();
end

function Minesweeper_Restart_OnClick()
	GamesList_CurrentTurn = 0;
	Minesweeper_SendInfo(1, Minesweeper_DoStart());
	MinesweeperButtonRestart:Disable();
	GamesList_ScoreLeft = 0;
	GamesList_ScoreRight = 0;
	Minesweeper_UpdateBorders();
end

function Minesweeper_OnHide()
	if (GamesList_CurrentVersus ~= "") then
		Minesweeper_Quit_OnClick();
	end
end

function Minesweeper_Quit_OnClick()
	Minesweeper_SendInfo(3);
	GamesList_CurrentVersus = "";
	GamesList_CurrentState = 0;
	HideUIPanel(MinesweeperFrame);
end

function Minesweeper_OnClick()
	local x = Minesweeper_ConvertHexToInt(strsub(this:GetName(), strlen(this:GetName()), strlen(this:GetName()))) * 1;
	local y = Minesweeper_ConvertHexToInt(strsub(strsub(this:GetName(), strlen(this:GetName()) - 2, strlen(this:GetName()) - 2), 1, 1)) * 1;

	local Discovered = getglobal("MinesweeperButton"..Minesweeper_ConvertIntToHex(y).."_"..Minesweeper_ConvertIntToHex(x).."Discovered");

	if ((Discovered:GetText() == "0") and (GamesList_CurrentTurn == 1)) then
		Minesweeper_ButtonClick(x, y);

		if (Minesweeper_ButtonState(x, y) == -4) then
			GamesList_CurrentTurn = 1;
			GamesList_ScoreLeft = GamesList_ScoreLeft + 1;
			Minesweeper_SendInfo(2, x, y, 0);
			if (GamesList_ScoreLeft == 26) then
				message(OTHELLO_YOUWIN);
				MinesweeperButtonRestart:Enable();
			end
		else
			GamesList_CurrentTurn = 0;
			Minesweeper_SendInfo(2, x, y, 1);
		end
	end

	this:SetChecked(0);
	PlaySound("igCharacterInfoClose");
	Minesweeper_UpdateBorders();
end
