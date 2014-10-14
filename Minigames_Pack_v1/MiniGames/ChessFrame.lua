--------------------------------------------------------------------------
-- ChessFrame.lua
--------------------------------------------------------------------------
--[[
MiniGames

	$Id: ChessFrame.lua 3779 2006-07-11 11:19:23Z karlkfi $
	$Rev: 3779 $
	$LastChangedBy: karlkfi $
	$Date: 2006-07-11 06:19:23 -0500 (Tue, 11 Jul 2006) $

]]--

UIPanelWindows["ChessFrame"] = { area = "center",	pushable = 0 };

-- Castle | Knight | Bishop | Queen | King | Bishop | Knight | Castle
-- Pawn   | Pawn   | Pawn   | Pawn  | Pawn | Pawn   | Pawn   | Pawn

Chess_LastPlay1 = "";
Chess_LastPlay2 = "";
Chess_LastPlay3 = "";
Chess_LastPlay4 = "";

Chess_Case_X = 0;
Chess_Case_Y = 0;
Chess_ChessTest = 0;
Chess_IsChess = 0;
Chess_HasMoved = { 0, 0, 0, 0, 0, 0 };
-- Roi H, Roi B, Tour HG, Tour HD, Tour BG, Tour BD

Chess_IconPath = { };
Chess_IconPath[2] = { Wow = "Interface\\Icons\\INV_Misc_Head_Gnome_01", Custom = "Interface\\AddOns\\MiniGames\\Skin\\Chess\\Pawn"};
Chess_IconPath[3] = { Wow = "Interface\\Icons\\Spell_Shadow_AnimateDead", Custom = "Interface\\AddOns\\MiniGames\\Skin\\Chess\\Rook"};
Chess_IconPath[4] = { Wow = "Interface\\Icons\\INV_Misc_Head_Human_02", Custom = "Interface\\AddOns\\MiniGames\\Skin\\Chess\\Queen"};
Chess_IconPath[5] = { Wow = "Interface\\Icons\\INV_Misc_Head_Centaur_01", Custom = "Interface\\AddOns\\MiniGames\\Skin\\Chess\\King"};
Chess_IconPath[6] = { Wow = "Interface\\Icons\\Ability_Druid_SupriseAttack", Custom = "Interface\\AddOns\\MiniGames\\Skin\\Chess\\Bishop"};
Chess_IconPath[7] = { Wow = "Interface\\Icons\\Spell_Nature_UnyeildingStamina", Custom = "Interface\\AddOns\\MiniGames\\Skin\\Chess\\Knight"};

Chess_IconColor = { };
Chess_IconColor[1] = { r = 1.00, g = 0.00, b = 0.00 };
Chess_IconColor[2] = { r = 0.00, g = 1.00, b = 1.00 };

Chess_MoveTemp = { };
Chess_MoveTemp[1] = { x = 0, y = 0, icon_state = 0};
Chess_MoveTemp[2] = { x = 0, y = 0, icon_state = 0};
Chess_MoveTemp[3] = { x = 0, y = 0, icon_state = 0};
Chess_MoveTemp[4] = { x = 0, y = 0, icon_state = 0};


function Chess_Invert(inv)
	if (inv == 1) then
		return 2;
	else
		return 1;
	end
end

function Chess_Clear()
	for y = 1, 8 do
		for i = 1, 8 do
			Chess_ChangeValue(y, i, 1);
		end
	end
end

function Chess_TestChess(team)
	for y = 1, 8 do
		for i = 1, 8 do
			if (Chess_GetTeam(y, i) * 1 == team and Chess_ButtonState(y, i) ~= 1) then
				if (Chess_SearchCaseCanGo(y, i, 1) == 1) then
					-- Yes
					Chess_ClearSelect();
					Chess_ChessTest = 0;
					return 1;
				end
			end
		end
	end
	-- No
	Chess_ClearSelect();
	Chess_ChessTest = 0;
	return 0;
end

function Chess_ChangeColor(x, y, team)
	local Button = getglobal("ChessButton"..x.."_"..y.."IconTexture");
	if (team == 1) then
		Button:SetVertexColor(1,0,0);
	else
		Button:SetVertexColor(0,1,1);
	end
end

function Chess_GetTeam(x, y)
	x = x * 1;
	y = y * 1;
	if (x > 0 and x <= 8 and y > 0 and y <= 8) then
		local Team = getglobal("ChessButton"..x.."_"..y.."Team");
		return Team:GetText() * 1;
	else
		return 0;
	end
end

function Chess_ChangeTeam(x, y, team)
	local Texture = getglobal("ChessButton"..x.."_"..y.."IconTexture");
	local Team = getglobal("ChessButton"..x.."_"..y.."Team");
	if (not team) then return; end
	Texture:SetVertexColor(Chess_IconColor[team * 1].r, Chess_IconColor[team * 1].g, Chess_IconColor[team * 1].b);
	Team:SetText(team);
end

function Chess_ClearSelect()
	for y = 1, 8 do
		for i = 1, 8 do
			Chess_UnCheck(y, i);
		end
	end
end

function Chess_Check(x, y)
	if (Chess_ChessTest == 1) then
			if (Chess_ButtonState(x, y) == 5) then
				Chess_IsChess = 1;
			end
		return;
	end
	local Button = getglobal("ChessButton"..x.."_"..y);
	Button:SetChecked("true");
end

function Chess_IsChecked(x, y)
	local Button = getglobal("ChessButton"..x.."_"..y);
	if (Button:GetChecked() == 1) then
		return false;
	end
	return true;
end

function Chess_UnCheck(x, y)
	local Button = getglobal("ChessButton"..x.."_"..y);
	Button:SetChecked("false");
end

function Chess_ChangeValue(x, y, icon_state, team)
	local State = getglobal("ChessButton"..x.."_"..y.."State");
	local Button = getglobal("ChessButton"..x.."_"..y);
	local IconTexture = getglobal("ChessButton"..x.."_"..y.."IconTexture");
	if (icon_state ~= 1) then Chess_ChangeTeam(x, y, team); end

	if (icon_state * 1 == 1) then
		IconTexture:Hide();
		State:SetText("1");
	else
		if (GamesList_UseCustomIcons == 0) then
			IconTexture:SetTexture(Chess_IconPath[icon_state * 1].Wow);
		else
			IconTexture:SetTexture(Chess_IconPath[icon_state * 1].Custom);
		end
		IconTexture:Show();
		State:SetText(icon_state);
	end
end

function Chess_ButtonState(x, y)
	x = x * 1;
	y = y * 1;
	if (x > 0 and x <= 8 and y > 0 and y <= 8) then
		local State = getglobal("ChessButton"..x.."_"..y.."State");
		return State:GetText() * 1;
	else
		return 0;
	end
end

function Chess_Invert(inv)
	if (inv == 2) then
		return 1;
	else
		return 2;
	end
end

function Chess_UpdateBorders()
	ChessNameLeft:SetText(UnitName("player"));
	ChessNameRight:SetText(GamesList_CurrentVersus);

	if (GamesList_UseCustomIcons == 0) then
		ChessButtonLeftIconTexture:SetTexture(Chess_IconPath[Sea.math.round(math.random(2, 7))].Wow);
		ChessButtonRightIconTexture:SetTexture(Chess_IconPath[Sea.math.round(math.random(2, 7))].Wow);
	else
		ChessButtonLeftIconTexture:SetTexture(Chess_IconPath[Sea.math.round(math.random(2, 7))].Custom);
		ChessButtonRightIconTexture:SetTexture(Chess_IconPath[Sea.math.round(math.random(2, 7))].Custom);
	end
	ChessButtonLeftIconTexture:Show();
	ChessButtonRightIconTexture:Show();

	ChessButtonLeftIconTexture:SetVertexColor(Chess_IconColor[GamesList_CurrentCaseType].r, Chess_IconColor[GamesList_CurrentCaseType].g, Chess_IconColor[GamesList_CurrentCaseType].b);
	ChessButtonRightIconTexture:SetVertexColor(Chess_IconColor[Chess_Invert(GamesList_CurrentCaseType)].r, Chess_IconColor[Chess_Invert(GamesList_CurrentCaseType)].g, Chess_IconColor[Chess_Invert(GamesList_CurrentCaseType)].b);

	if (GamesList_CurrentTurn ~= 0) then
		ChessButtonLeft:SetChecked("true");
		ChessButtonRight:SetChecked("false");
	else
		ChessButtonLeft:SetChecked("false");
		ChessButtonRight:SetChecked("true");
	end
end

function Chess_Start(Who)
	ShowUIPanel(ChessFrame);
	GamesList_CurrentState = 2;
	GamesList_CurrentCaseType = 1;
	GamesList_CurrentTurn = 0;
	GamesList_CurrentVersus = Who;
	Chess_SendInfo(1);
	Chess_OnLoad();
end

function Chess_SendInfo(Type, Arg1, Arg2, Arg3)
	GamesList_SendMessage(GamesList_CurrentVersus, 4, Type, Arg1, Arg2, Arg3);
end

function Chess_GetData(Who, Type, Arg1, Arg2, Arg3, Arg4)
	Type = Type * 1;

	if (Type == 1) then -- Start
		GamesList_CurrentState = 2;
		GamesList_CurrentTurn = 1;
		GamesList_CurrentCaseType = 2;
		GamesList_CurrentVersus = Who;
		GamesList_SendMessage(nil, 2);
		ShowUIPanel(ChessFrame);
		Chess_UpdateBorders();

	elseif (Who ~= GamesList_CurrentVersus) then
		return;

	elseif (Type == 2) then -- ChangeCase
		Chess_ChangeValue(Arg1, Arg2, Arg3, Chess_Invert(GamesList_CurrentCaseType));
		Chess_ClearSelect();
		Chess_UpdateBorders();

	elseif (Type == 3) then -- My turn
		GamesList_CurrentTurn = 1;
		Chess_ClearSelect();
		Chess_UpdateBorders();

	elseif (Type == 5) then -- Quit
		GamesList_Leave(GamesList_CurrentVersus);
		GamesList_CurrentState = 0;
		GamesList_CurrentVersus = "";
		HideUIPanel(ChessFrame);

	elseif (Type == 6) then -- New Game
		Chess_OnLoad();
		GamesList_CurrentTurn = 1;

	end
end

function Chess_Quit_OnClick()
	Chess_SendInfo(5);
	GamesList_CurrentState = 0;
	GamesList_CurrentTurn = 0;
	GamesList_CurrentVersus = "";
	HideUIPanel(ChessFrame);
end

function Chess_OnHide()
	if (GamesList_CurrentVersus ~= "") then
		Chess_Quit_OnClick();
	end
end

function Chess_OnLoad()
	Chess_HasMoved = { 0, 0, 0, 0, 0, 0 };
	Chess_Clear();
	Chess_ClearSelect();
	Chess_UpdateBorders();
	for i = 1, 8 do
		Chess_ChangeValue(2, i, 2, 1);
		Chess_ChangeValue(7, i, 2, 2);
	end

	Chess_ChangeValue(1, 1, 3, 1);
	Chess_ChangeValue(1, 2, 7, 1);
	Chess_ChangeValue(1, 3, 6, 1);
	Chess_ChangeValue(1, 4, 4, 1);
	Chess_ChangeValue(1, 5, 5, 1);
	Chess_ChangeValue(1, 6, 6, 1);
	Chess_ChangeValue(1, 7, 7, 1);
	Chess_ChangeValue(1, 8, 3, 1);

	Chess_ChangeValue(8, 1, 3, 2);
	Chess_ChangeValue(8, 2, 7, 2);
	Chess_ChangeValue(8, 3, 6, 2);
	Chess_ChangeValue(8, 4, 4, 2);
	Chess_ChangeValue(8, 5, 5, 2);
	Chess_ChangeValue(8, 6, 6, 2);
	Chess_ChangeValue(8, 7, 7, 2);
	Chess_ChangeValue(8, 8, 3, 2);
end

function ChessFrame_OnClick()
	if (this:GetID() == 0) then
		Chess_UpdateBorders();
		return;
	end
	local x = strsub(this:GetID(), 1, 1);
	local y = strsub(this:GetID(), 2, 2);

	if ( GamesList_CurrentTurn == 0 ) then this:SetChecked("false"); return; end

	if ( Chess_IsChecked(x, y) == true ) then
		Chess_LastPlay1 = "";
		Chess_LastPlay2 = "";
		Chess_LastPlay3 = "";
		Chess_LastPlay4 = "";
		Chess_MoveTemp[1].x = 0; Chess_MoveTemp[1].y = 0; Chess_MoveTemp[1].icon_state = 0;
		Chess_MoveTemp[2].x = 0; Chess_MoveTemp[2].y = 0; Chess_MoveTemp[2].icon_state = 0;
		Chess_MoveTemp[3].x = 0; Chess_MoveTemp[3].y = 0; Chess_MoveTemp[3].icon_state = 0;
		Chess_MoveTemp[4].x = 0; Chess_MoveTemp[4].y = 0; Chess_MoveTemp[4].icon_state = 0;

		if ( (x == "1") and (y == "1") ) then
			Chess_HasMoved[3] = 1;
		elseif ( (x == "1") and (y == "8") ) then
			Chess_HasMoved[4] = 1;
		elseif ( (x == "8") and (y == "1") ) then
			Chess_HasMoved[5] = 1;
		elseif ( (x == "8") and (y == "8") ) then
			Chess_HasMoved[6] = 1;
		elseif ( (x == "1") and (y == "5") ) then
			Chess_HasMoved[1] = 1;
		elseif ( (x == "8") and (y == "5") ) then
			Chess_HasMoved[2] = 1;
		end
		if ( ( Chess_GetTeam(Chess_Case_X, Chess_Case_Y) == Chess_GetTeam(x, y) ) and (Chess_ButtonState(x, y) ~= 1 ) ) then
			if (y == "1") then
				Chess_LastPlay3 = "Chess_ChangeValue("..Chess_Case_X..", 3, "..Chess_ButtonState(Chess_Case_X, 3)..", "..Chess_GetTeam(Chess_Case_X, 3)..");";
				Chess_ChangeValue(Chess_Case_X, 3, 5, Chess_GetTeam(Chess_Case_X, Chess_Case_Y));
				Chess_MoveTemp[3].x = Chess_Case_X; Chess_MoveTemp[3].y = 3; Chess_MoveTemp[3].icon_state = 5;

				Chess_LastPlay4 = "Chess_ChangeValue("..Chess_Case_X..", 4, "..Chess_ButtonState(Chess_Case_X, 3)..", "..Chess_GetTeam(Chess_Case_X, 4)..");";
				Chess_ChangeValue(Chess_Case_X, 4, 3, Chess_GetTeam(Chess_Case_X, Chess_Case_Y));
				Chess_MoveTemp[4].x = Chess_Case_X; Chess_MoveTemp[4].y = 4; Chess_MoveTemp[4].icon_state = 3;
			end
			if (y == "8") then
				Chess_LastPlay3 = "Chess_ChangeValue("..Chess_Case_X..", 7, "..Chess_ButtonState(Chess_Case_X, 7)..", "..Chess_GetTeam(Chess_Case_X, 7)..");";
				Chess_ChangeValue(Chess_Case_X, 7, 5, Chess_GetTeam(Chess_Case_X, Chess_Case_Y));
				Chess_MoveTemp[3].x = Chess_Case_X; Chess_MoveTemp[3].y = 7; Chess_MoveTemp[3].icon_state = 5;

				Chess_LastPlay4 = "Chess_ChangeValue("..Chess_Case_X..", 6, "..Chess_ButtonState(Chess_Case_X, 6)..", "..Chess_GetTeam(Chess_Case_X, 6)..");";
				Chess_ChangeValue(Chess_Case_X, 6, 3, Chess_GetTeam(Chess_Case_X, Chess_Case_Y));
				Chess_MoveTemp[4].x = Chess_Case_X; Chess_MoveTemp[4].y = 6; Chess_MoveTemp[4].icon_state = 3;
			end
			Chess_LastPlay2 = "Chess_ChangeValue("..x..", "..y..", "..Chess_ButtonState(x, y)..", "..Chess_GetTeam(x, y)..");";
			Chess_ChangeValue(x, y, 1);
			Chess_MoveTemp[2].x = x; Chess_MoveTemp[2].y = y; Chess_MoveTemp[2].icon_state = 1;
		else
			Chess_LastPlay2 = "Chess_ChangeValue("..x..", "..y..", "..Chess_ButtonState(x, y)..", ".. Chess_GetTeam(x, y)..");";
			Chess_MoveTemp[2].x = x; Chess_MoveTemp[2].y = y; Chess_MoveTemp[2].icon_state = Chess_ButtonState(Chess_Case_X, Chess_Case_Y);
			Chess_ChangeValue(x, y, Chess_ButtonState(Chess_Case_X, Chess_Case_Y), Chess_GetTeam(Chess_Case_X, Chess_Case_Y));

			if (Chess_ButtonState(Chess_Case_X, Chess_Case_Y) == 2) then
				if ( ( (x == "1") and (Chess_GetTeam(Chess_Case_X, Chess_Case_Y) == 2) ) or ( (x == "8") and (Chess_GetTeam(Chess_Case_X, Chess_Case_Y) == 1) ) ) then
					Chess_LastPlay2 = "Chess_ChangeValue("..x..", "..y..", 4, "..Chess_GetTeam(Chess_Case_X, Chess_Case_Y)..");";
					Chess_ChangeValue(x, y, 4, Chess_GetTeam(Chess_Case_X, Chess_Case_Y));
					Chess_MoveTemp[2].x = x; Chess_MoveTemp[2].y = y; Chess_MoveTemp[2].icon_state = 4;
				end
			end
		end
		Chess_LastPlay1 = "Chess_ChangeValue("..Chess_Case_X..", "..Chess_Case_Y..", "..Chess_ButtonState(Chess_Case_X, Chess_Case_Y)..", ".. Chess_GetTeam(Chess_Case_X, Chess_Case_Y)..");";
		Chess_ChangeValue(Chess_Case_X, Chess_Case_Y, 1);
		Chess_MoveTemp[1].x = Chess_Case_X; Chess_MoveTemp[1].y = Chess_Case_Y; Chess_MoveTemp[1].icon_state = 1;

		Chess_ClearSelect();
		if (Chess_TestChess(Chess_Invert(GamesList_CurrentCaseType)) == 1) then
			if (strlen(Chess_LastPlay1) > 0) then RunScript(Chess_LastPlay1) end
			if (strlen(Chess_LastPlay2) > 0) then RunScript(Chess_LastPlay2) end
			if (strlen(Chess_LastPlay3) > 0) then RunScript(Chess_LastPlay3) end
			if (strlen(Chess_LastPlay4) > 0) then RunScript(Chess_LastPlay4) end
			Print("You are in chess, choose an other move !");
			return;
		end

		for i = 1, 4, 1 do
			if (Chess_MoveTemp[i].x ~= 0) then
				Chess_SendInfo(2, Chess_MoveTemp[i].x, Chess_MoveTemp[i].y, Chess_MoveTemp[i].icon_state)
			end
		end
		Chess_SendInfo(3);

		GamesList_CurrentTurn = 0;
		Chess_UpdateBorders();
	elseif ( ( Chess_ButtonState(x, y) ~= 1 ) and ( Chess_GetTeam(x, y) == GamesList_CurrentCaseType ) ) then
		Chess_ClearSelect();
		IsChess = Chess_TestChess(Chess_Invert(GamesList_CurrentCaseType));
		Chess_SearchCaseCanGo(x, y);
		Chess_Case_X = x * 1;
		Chess_Case_Y = y * 1;
	end

	this:SetChecked("false");
	PlaySound("gsLoginChangeRealmOK");
end

function Chess_SearchCaseCanGo(x, y, ChessTest)
	if (ChessTest == 1) then
		Chess_IsChess = 0;
		Chess_ChessTest = 1;
	end
	if (Chess_ButtonState(x, y) == 2) then -- Pions
		if (Chess_GetTeam(x,y) == 1) then -- Team Haut
			if (x ~= "8") then
				if (Chess_ButtonState(x + 1, y) == 1) then
					Chess_Check(x + 1, y); -- Avancer de 1
					if ( (x == "2") and (Chess_ButtonState(x + 2, y) == 1) ) then
						Chess_Check(x + 2, y); -- Avancer de 2
					end
				end
			end
			if ( (y ~= "1") and (x ~= "8") ) then -- Test si on peut à gauche
				if ( ( Chess_ButtonState(x + 1, y - 1) ~= 1) and (Chess_GetTeam(x + 1, y - 1) ~= Chess_GetTeam(x, y) ) ) then
					Chess_Check(x + 1, y - 1); -- Bas à Gauche
				end
			end
			if ( (y ~= "8") and (x ~= "8") ) then -- Test si on peut à droite
				if ( ( Chess_ButtonState(x + 1, y + 1) ~= 1) and (Chess_GetTeam(x + 1, y + 1) ~= Chess_GetTeam(x, y) ) ) then
					Chess_Check(x + 1, y + 1); -- Bas à Droite
				end
			end
			return;
		else -- Team Bas
			if (x ~= "1") then
				if (Chess_ButtonState(x - 1, y) == 1)  then
					Chess_Check(x - 1, y); -- Avancer de 1
					if ( (x == "7") and (Chess_ButtonState(x - 2, y) == 1) ) then
						Chess_Check(x - 2, y); -- Avancer de 2
					end
				end
			end
			if ( (y ~= "1") and (x ~= "1") ) then -- Test si on peut à droite
				if ( ( Chess_ButtonState(x - 1, y - 1) ~= 1) and (Chess_GetTeam(x - 1, y - 1) ~= Chess_GetTeam(x, y) ) ) then
					Chess_Check(x - 1, y - 1); -- Haut à Gauche
				end
			end
			if ( (y ~= "8") and (x ~= "1") ) then -- Test si on peut à droite
				if ( ( Chess_ButtonState(x - 1, y + 1) ~= 1) and (Chess_GetTeam(x - 1, y + 1) ~= Chess_GetTeam(x, y) ) ) then
					Chess_Check(x - 1, y + 1); -- Haut à Droite
				end
			end
			return;
		end
	end

	if (Chess_ButtonState(x,y) == 3) then -- Tours
		for i = x + 1, 8 do
			if (Chess_ButtonState(i, y) == 1) then
				Chess_Check(i, y);
			elseif (Chess_GetTeam(i, y) ~= Chess_GetTeam(x, y) ) then
				Chess_Check(i, y);
				break;
			else
				break;
			end
		end
		for i = 1 - x, -1 do
			if (Chess_ButtonState(0-i, y) == 1) then
				Chess_Check(0-i, y);
			elseif (Chess_GetTeam(0-i, y) ~= Chess_GetTeam(x, y) ) then
				Chess_Check(0-i, y);
				break;
			else
				break;
			end
		end
		for i = y + 1, 8 do
			if (Chess_ButtonState(x, i) == 1) then
				Chess_Check(x, i);
			elseif (Chess_GetTeam(x, i) ~= Chess_GetTeam(x, y) ) then
				Chess_Check(x, i);
				break;
			else
				break;
			end
		end
		for i = 1 - y, -1 do
			if (Chess_ButtonState(x, 0-i) == 1) then
				Chess_Check(x, 0-i);
			elseif (Chess_GetTeam(x, 0-i) ~= Chess_GetTeam(x, y) ) then
				Chess_Check(x, 0-i);
				break;
			else
				break;
			end
		end
	end

	if (Chess_ButtonState(x,y) == 6) then -- Fous
		for i = 1, 8 do -- Diagonale bas droite \
			if ( (x + i < 9) and (y + i < 9) ) then
				if (Chess_ButtonState(x + i, y + i) == 1) then
					Chess_Check(x + i, y + i);
				elseif (Chess_GetTeam(x + i, y + i) ~= Chess_GetTeam(x, y) ) then
					Chess_Check(x + i, y + i);
					break;
				else
					break;
				end
			end
		end
		for i = 1, 8 do -- Diagonale haut gauche
			if ( (x - i > 0) and (y - i > 0) ) then
				if (Chess_ButtonState(x - i, y - i) == 1) then
					Chess_Check(x - i, y - i);
				elseif (Chess_GetTeam(x - i, y - i) ~= Chess_GetTeam(x, y) ) then
					Chess_Check(x - i, y - i);
					break;
				else
					break;
				end
			end
		end
		for i = 1, 8 do -- Diagonale haut droite
			if ( (x - i > 0) and (y + i < 9) ) then
				if (Chess_ButtonState(x - i, y + i) == 1) then
					Chess_Check(x - i, y + i);
				elseif (Chess_GetTeam(x - i, y + i) ~= Chess_GetTeam(x, y) ) then
					Chess_Check(x - i, y + i);
					break;
				else
					break;
				end
			end
		end
		for i = 1, 8 do -- Diagonale haut droite
			if ( (x + i < 9) and (y - i > 0) ) then
				if (Chess_ButtonState(x + i, y - i) == 1) then
					Chess_Check(x + i, y - i);
				elseif (Chess_GetTeam(x + i, y - i) ~= Chess_GetTeam(x, y) ) then
					Chess_Check(x + i, y - i);
					break;
				else
					break;
				end
			end
		end
	end

	if (Chess_ButtonState(x,y) == 4) then -- Reine
		for i = 1, 8 do -- Diagonale bas droite \
			if ( (x + i < 9) and (y + i < 9) ) then
				if (Chess_ButtonState(x + i, y + i) == 1) then
					Chess_Check(x + i, y + i);
				elseif (Chess_GetTeam(x + i, y + i) ~= Chess_GetTeam(x, y) ) then
					Chess_Check(x + i, y + i);
					break;
				else
					break;
				end
			end
		end
		for i = 1, 8 do -- Diagonale haut gauche
			if ( (x - i > 0) and (y - i > 0) ) then
				if (Chess_ButtonState(x - i, y - i) == 1) then
					Chess_Check(x - i, y - i);
				elseif (Chess_GetTeam(x - i, y - i) ~= Chess_GetTeam(x, y) ) then
					Chess_Check(x - i, y - i);
					break;
				else
					break;
				end
			end
		end
		for i = 1, 8 do -- Diagonale haut droite
			if ( (x - i > 0) and (y + i < 9) ) then
				if (Chess_ButtonState(x - i, y + i) == 1) then
					Chess_Check(x - i, y + i);
				elseif (Chess_GetTeam(x - i, y + i) ~= Chess_GetTeam(x, y) ) then
					Chess_Check(x - i, y + i);
					break;
				else
					break;
				end
			end
		end
		for i = 1, 8 do -- Diagonale haut droite
			if ( (x + i < 9) and (y - i > 0) ) then
				if (Chess_ButtonState(x + i, y - i) == 1) then
					Chess_Check(x + i, y - i);
				elseif (Chess_GetTeam(x + i, y - i) ~= Chess_GetTeam(x, y) ) then
					Chess_Check(x + i, y - i);
					break;
				else
					break;
				end
			end
		end
		for i = x + 1, 8 do -- Haut
			if (Chess_ButtonState(i, y) == 1) then
				Chess_Check(i, y);
			elseif (Chess_GetTeam(i, y) ~= Chess_GetTeam(x, y) ) then
				Chess_Check(i, y);
				break;
			else
				break;
			end
		end
		for i = 1 - x, -1 do -- Bas ?
			if (Chess_ButtonState(0-i, y) == 1) then
				Chess_Check(0-i, y);
			elseif (Chess_GetTeam(0-i, y) ~= Chess_GetTeam(x, y) ) then
				Chess_Check(0-i, y);
				break;
			else
				break;
			end
		end
		for i = y + 1, 8 do -- Droite
			if (Chess_ButtonState(x, i) == 1) then
				Chess_Check(x, i);
			elseif (Chess_GetTeam(x, i) ~= Chess_GetTeam(x, y) ) then
				Chess_Check(x, i);
				break;
			else
				break;
			end
		end
		for i = 1 - y, -1 do -- Gauche
			if (Chess_ButtonState(x, 0-i) == 1) then
				Chess_Check(x, 0-i);
			elseif (Chess_GetTeam(x, 0-i) ~= Chess_GetTeam(x, y) ) then
				Chess_Check(x, 0-i);
				break;
			else
				break;
			end
		end
	end

	if (Chess_ButtonState(x,y) == 5) then -- Roi
		if ( (y ~= "1") and (x ~= "1") ) then
			if ( ( Chess_ButtonState(x - 1, y - 1) == 1) or (Chess_GetTeam(x - 1, y - 1) ~= Chess_GetTeam(x, y) ) ) then
				Chess_Check(x - 1, y - 1); -- Haut à Gauche
			end
		end
		if ( (y ~= "8") and (x ~= "1") ) then
			if ( ( Chess_ButtonState(x - 1, y + 1) == 1) or (Chess_GetTeam(x - 1, y + 1) ~= Chess_GetTeam(x, y) ) ) then
				Chess_Check(x - 1, y + 1); -- Haut à Droite
			end
		end
		if ( (y ~= "1") and (x ~= "8") ) then
			if ( ( Chess_ButtonState(x + 1, y - 1) == 1) or (Chess_GetTeam(x + 1, y - 1) ~= Chess_GetTeam(x, y) ) ) then
				Chess_Check(x + 1, y - 1); -- Bas à Gauche
			end
		end
		if ( (y ~= "8") and (x ~= "8") ) then
			if ( ( Chess_ButtonState(x + 1, y + 1) == 1) or (Chess_GetTeam(x + 1, y + 1) ~= Chess_GetTeam(x, y) ) ) then
				Chess_Check(x + 1, y + 1); -- Bas à Droite
			end
		end
		if (x ~= "8") then -- Test si on peut en bas
			if ( (Chess_ButtonState(x + 1, y) == 1) or (Chess_GetTeam(x + 1, y) ~= Chess_GetTeam(x, y) ) ) then
				Chess_Check(x + 1, y); -- Avancer de 1
			end
		end
		if (x ~= "1") then -- Test si on peut en haut
			if ( (Chess_ButtonState(x - 1, y) == 1) or (Chess_GetTeam(x - 1, y) ~= Chess_GetTeam(x, y) ) ) then
				Chess_Check(x - 1, y); -- Avancer de 1
			end
		end
		if (y ~= "8") then -- ~~>
			if ( (Chess_ButtonState(x, y + 1) == 1) or (Chess_GetTeam(x, y + 1) ~= Chess_GetTeam(x, y) ) ) then
				Chess_Check(x, y + 1);
			end
		end
		if (y ~= "1") then -- <~~
			if ( (Chess_ButtonState(x, y - 1) == 1) or (Chess_GetTeam(x, y - 1) ~= Chess_GetTeam(x, y) ) ) then
				Chess_Check(x, y - 1);
			end
		end
		if (Chess_IsChess == 0) then
			if ( ( x == "1" ) and ( y == "5" ) and ( Chess_HasMoved[1] == 0 ) ) then
				if ( ( Chess_HasMoved[3] == 0 ) and (Chess_ButtonState(1,2) == 1) and (Chess_ButtonState(1,3) == 1) and (Chess_ButtonState(1,4) == 1) ) then
					Chess_Check(1, 1);
				end
				if ( ( Chess_HasMoved[4] == 0 ) and (Chess_ButtonState(1,6) == 1) and (Chess_ButtonState(1,7) == 1) ) then
					Chess_Check(1, 8);
				end
			end
			if ( ( x == "8" ) and ( y == "5" ) and ( Chess_HasMoved[2] == 0 ) ) then
				if ( ( Chess_HasMoved[5] == 0 ) and (Chess_ButtonState(8,2) == 1) and (Chess_ButtonState(8,3) == 1) and (Chess_ButtonState(8,4) == 1) ) then
					Chess_Check(8, 1);
				end
				if ( ( Chess_HasMoved[6] == 0 ) and (Chess_ButtonState(8,6) == 1) and (Chess_ButtonState(8,7) == 1) ) then
					Chess_Check(8, 8);
				end
			end
		end
	end

	if (Chess_ButtonState(x,y) == 7) then -- Cavalier
		local xx = 0;
		local yy = 0;

		xx = -2;
		yy = -1;
		if ( (yy + y * 1 > 0) and (yy + y * 1 < 9) and (xx + x * 1 > 0) and (xx + x * 1 < 9) ) then
			if ( ( Chess_ButtonState(x + xx, y + yy) == 1) or (Chess_GetTeam(x + xx, y + yy) ~= Chess_GetTeam(x, y) ) ) then
				Chess_Check(x + xx, y + yy);
			end
		end
		xx = -1;
		yy = -2;
		if ( (yy + y * 1 > 0) and (yy + y * 1 < 9) and (xx + x * 1 > 0) and (xx + x * 1 < 9) ) then
			if ( ( Chess_ButtonState(x + xx, y + yy) == 1) or (Chess_GetTeam(x + xx, y + yy) ~= Chess_GetTeam(x, y) ) ) then
				Chess_Check(x + xx, y + yy);
			end
		end
		xx = 1;
		yy = -2;
		if ( (yy + y * 1 > 0) and (yy + y * 1 < 9) and (xx + x * 1 > 0) and (xx + x * 1 < 9) ) then
			if ( ( Chess_ButtonState(x + xx, y + yy) == 1) or (Chess_GetTeam(x + xx, y + yy) ~= Chess_GetTeam(x, y) ) ) then
				Chess_Check(x + xx, y + yy);
			end
		end
		xx = 2;
		yy = -1;
		if ( (yy + y * 1 > 0) and (yy + y * 1 < 9) and (xx + x * 1 > 0) and (xx + x * 1 < 9) ) then
			if ( ( Chess_ButtonState(x + xx, y + yy) == 1) or (Chess_GetTeam(x + xx, y + yy) ~= Chess_GetTeam(x, y) ) ) then
				Chess_Check(x + xx, y + yy);
			end
		end
		xx = 2;
		yy = 1;
		if ( (yy + y * 1 > 0) and (yy + y * 1 < 9) and (xx + x * 1 > 0) and (xx + x * 1 < 9) ) then
			if ( ( Chess_ButtonState(x + xx, y + yy) == 1) or (Chess_GetTeam(x + xx, y + yy) ~= Chess_GetTeam(x, y) ) ) then
				Chess_Check(x + xx, y + yy);
			end
		end
		xx = 1;
		yy = 2;
		if ( (yy + y * 1 > 0) and (yy + y * 1 < 9) and (xx + x * 1 > 0) and (xx + x * 1 < 9) ) then
			if ( ( Chess_ButtonState(x + xx, y + yy) == 1) or (Chess_GetTeam(x + xx, y + yy) ~= Chess_GetTeam(x, y) ) ) then
				Chess_Check(x + xx, y + yy);
			end
		end
		xx = -1;
		yy = 2;
		if ( (yy + y * 1 > 0) and (yy + y * 1 < 9) and (xx + x * 1 > 0) and (xx + x * 1 < 9) ) then
			if ( ( Chess_ButtonState(x + xx, y + yy) == 1) or (Chess_GetTeam(x + xx, y + yy) ~= Chess_GetTeam(x, y) ) ) then
				Chess_Check(x + xx, y + yy);
			end
		end
		xx = -2;
		yy = 1;
		if ( (yy + y * 1 > 0) and (yy + y * 1 < 9) and (xx + x * 1 > 0) and (xx + x * 1 < 9) ) then
			if ( ( Chess_ButtonState(x + xx, y + yy) == 1) or (Chess_GetTeam(x + xx, y + yy) ~= Chess_GetTeam(x, y) ) ) then
				Chess_Check(x + xx, y + yy);
			end
		end
	end
	if (ChessTest == 1) then
		Chess_ChessTest = 0;
		if (Chess_IsChess == 1) then
			return 1;
		else
			return 0;
		end
	end
end