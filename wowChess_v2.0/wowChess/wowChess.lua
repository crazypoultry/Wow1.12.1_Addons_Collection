--[[
*******************************************************************
wowChess
Author: Hexarobi

*******************************************************************

Description:
	Play chess with other people inside World of Warcraft.

****************************************************************]]

-- Local variables
	local version = "200"
    	local LastTime = GetTime();
	local LastChatMsg;
	local WoW_ChatFrame_OnEvent;
	-- Various static tables used as lookups elsewhere
	local cols = { "a", "b", "c", "d", "e", "f", "g", "h" };
	local colsNum = { a=1, b=2, c=3, d=4, e=5, f=6, g=7, h=8 };
	local idGrid = {
		"a8", "b8", "c8", "d8", "e8", "f8", "g8", "h8", 
		"a7", "b7", "c7", "d7", "e7", "f7", "g7", "h7", 
		"a6", "b6", "c6", "d6", "e6", "f6", "g6", "h6", 
		"a5", "b5", "c5", "d5", "e5", "f5", "g5", "h5", 
		"a4", "b4", "c4", "d4", "e4", "f4", "g4", "h4", 
		"a3", "b3", "c3", "d3", "e3", "f3", "g3", "h3", 
		"a2", "b2", "c2", "d2", "e2", "f2", "g2", "h2", 
		"a1", "b1", "c1", "d1", "e1", "f1", "g1", "h1"
	};
	local spaceGrid = {
		a8=1,  b8=2,  c8=3,  d8=4,  e8=5,  f8=6,  g8=7,  h8=8, 
		a7=9,  b7=10, c7=11, d7=12, e7=13, f7=14, g7=15, h7=16, 
		a6=17, b6=18, c6=19, d6=20, e6=21, f6=22, g6=23, h6=24,   
		a5=25, b5=26, c5=27, d5=28, e5=29, f5=30, g5=31, h5=32,   
		a4=33, b4=34, c4=35, d4=36, e4=37, f4=38, g4=39, h4=40,   
		a3=41, b3=42, c3=43, d3=44, e3=45, f3=46, g3=47, h3=48,   
		a2=49, b2=50, c2=51, d2=52, e2=53, f2=54, g2=55, h2=56, 
		a1=57, b1=58, c1=59, d1=60, e1=61, f1=62, g1=63, h1=64 		
	}
	local wcBoard;
	local challengedOpp;
	local challenger;
	local whiteCanCastleLeft = 1;
	local whiteCanCastleRight = 1;
	local blackCanCastleLeft = 1;
	local blackCanCastleRight = 1;
	local debugging = 0;
	local blackKing = "";
	local whiteKing = "";
	local lastPawn = "";
	local isRotated = nil;
	local cap, gameOver;
	local whitePortraitShown = nil;
	local blackPortraitShown = nil;
	local wowChess_opponent;
	local wowChess_gameMoveCount;
	local waitingForAck = nil;
	local animate = { frame=0, fromPiece="", toPiece="", oldx=0, oldy=0, to="", from="", move="" };
	local rookanimate = { frame=0, fromPiece="", toPiece="", oldx=0, oldy=0, to="", from=""};
	local lastMove;
	local drawProposed = nil;
	local playClocks = { 0, 0 };
	local clockRunning = nil;
	local lastClockUpdate = 0;
	local timeLimit = 0;
	local timeMoveBonus = 0;

	local wowChess_MoveLog = {};
	local wowChess_MoveLogLength = 0;
	
	local blackJail = { p=0, n=0, b=0, r=0, q=0 };
	local whiteJail = { p=0, n=0, b=0, r=0, q=0 };
	
	--Challenge confirm dialog
	local confirmMode;
	StaticPopupDialogs["WOWCHESS_CHALLENGE"] = {
		text = "%s",
		button1 = "Yes",
		button2 = "No",
		OnAccept = function()
			wowChess_ChallengeYesButton();
		end,
		OnCancel = function()
			wowChess_ChallengeNoButton();
		end,
		sound = "igPlayerInvite",
		timeout = 0,
		whileDead = 1,
		hideOnEscape = 1
	};
	
--Called when its loaded
function wowChess_OnLoad()

	-- Hook ChatFrame_OnEvent so we can examine messages
	WoW_ChatFrame_OnEvent = ChatFrame_OnEvent;
	ChatFrame_OnEvent = wowChess_ChatFrame_OnEvent;
	wowChess_MoveLogSetFont();
	
	-- Used to read incomming tells, and make sure we dont double process
	OurEditBox = wowChess_EditBox;
	LastTime = GetTime();
	if (type(math.randomseed)=="function") then
		math.randomseed(math.random(0,2147483647)+(GetTime()*1000));
	end
	
	--Init data, overwriten by saved vars
	wowChess_scale = 1.0;
	wowChess_SavedGames = {};
	wowChessWinVisible = 0;
	wowChess_pieceUp = 0;
	wowChess_opponent = 0;
	this.TimeSinceLastUpdate = 0;
	this.isFaded = 0;
	wowChess_skinSounds = {};
	wowChess_piecesPath = 'Interface\\\AddOns\\\wowChess\\\Skins\\\warcraft2\\';
	wowChess_ResetBoard();
	wowChess_Totals = { 0, 0, 0 };
	
	-- Setup slash handler
	SLASH_WOWCHESS1 = "/wowchess";
	SLASH_WOWCHESS2 = "/chess";
	SLASH_WOWCHESS3 = "/ch";
	SlashCmdList["WOWCHESS"] = wowChess_SlashHandler;

	-- Register onloaded event and show loaded message
	this:RegisterEvent("ADDON_LOADED");
	ChatFrame1:AddMessage("wowChess Loaded", 1.0, 1.0, 0.0);
end

-- Event Handler
-- this function parses text that is passed into any chat Window
function wowChess_ChatFrame_OnEvent()
		
	-- Let Wow process the chat like it would have if we didn't grab the text
	WoW_ChatFrame_OnEvent(event);
	
	-- Only process if Event and message are not null (can happen with scripts)
	if ((event ~=nil) and (arg1 ~=nil) ) then	
	
		-- Filter out non chat messages (like joining channels ect.)
		-- Only use message if it differs from last, or if it's the same message.. there must be a small time difference
		-- Without this check, the message can be triggers multiple times
		if (event == "CHAT_MSG_WHISPER") and ( (arg1 ~= LastChatMsg) or ((GetTime() - LastTime) > .5) ) then			
			
			-- If message begins with "cm" pass along to the wowChess command handler
			local start,stop,command = string.find(arg1, 'cm (.*)');
			if (start == 1) then
				wowChess_CommandHandler(command, arg2);				
			end
		end

		LastChatMsg = arg1;
	end
end

-- This function parses chess commands from other players
function wowChess_CommandHandler(command, opp)
 	local command, SubCmd = wowChess_GetCmd(command);
	-- These commands only work for your wowChess_opponent
	if (opp == wowChess_opponent) then
	
		--during their turn
		if (mod(wowChess_gameMoveCount,2)==wowChess_isBlack) then
			-- Normal piece moves
			local start,stop,piece,from,cap,to = string.find(command, '([PRNBKQ])([a-h][0-8])([x\-])([a-h][0-8])');
			if ( start==1 and wowChess_ValidateMove(from,to) ) then
				wowChess_SendTell("cm ack");
				animate["move"] = command;
				clockRunning = 1;
				wowChess_MovePiece(from, to);		
				wowChess_SaveGame();
			end
		end
		
		if (command == "resign") then
			if (wowChess_isBlack==1) then
				local winner = "d";
			else
				local winner = "l";
			end
			wowChess_EndGame(winner);
		end
		
		if (command == "draw") then
			confirmMode = "draw";
			--wowChess_msg("confirmmode="..confirmMode);
			local dialog = StaticPopup_Show("WOWCHESS_CHALLENGE", opp.." has offered you a draw. Do you accept?");
			drawProposed = 1;
		end
		
		if (command == "drawaccepted" and drawProposed) then
			drawProposed = nil;
			wowChess_DrawGame();
		end
		
		if (command == "drawdenied" and drawProposed) then
			drawProposed = nil;
		end
		
	end
	
	if (opp == wowChess_opponent) and (command == "ack" and waitingForAck) then
		waitingForAck = nil;
		wowChess_SaveGame();
	end
	
	-- Recieve a challenge, if not already involved in a game.
	if (command == "challenge") then
		local ver, time = wowChess_GetCmd(SubCmd);
		if (ver ~= "v"..version) then
			SendChatMessage(wowChess_STR_VersionMismatch, "WHISPER", nil, opp);
		else
			if (wowChess_opponent == 0) then
				wowChess_Challenged(opp, time);
			else
				SendChatMessage(wowChess_STR_AlreadyPlaying, "WHISPER", nil, opp);
			end
		end
	end

	-- Your challenge has been accepted
	if (command == "challengeaccepted") then
		wowChess_ChallengeAccepted(opp);
	end
	
	-- Your challenge has been denied
	if (command == "challengedenied") then
		challengedOpp = "";
	end

end

--onClick handler for each board space
function wowChessSquare_OnClick()	
	local id = this:GetID();
	-- Ignore clicks if its not your turn
	if (wowChess_opponent~=0 and mod(wowChess_gameMoveCount,2)~=wowChess_isBlack) and (not waitingForAck) then
		local rwowChess_pieceUp, rid;
		if (isRotated) then
			rwowChess_pieceUp = 65-wowChess_pieceUp;
			rid = 65-id;
		else
			rwowChess_pieceUp = wowChess_pieceUp;
			rid = id;
		end	
		
		-- If no piece has been picked up
		if (wowChess_pieceUp == 0) then
			-- If clicked piece isnt empty
			local texture = getglobal("ChessButton"..id.."Piece"):GetTexture();
			if ( (texture ~= nil) and (texture ~= "") ) then
				-- If the piece is one you control
				local start,stop,piece,color = string.find(texture, wowChess_piecesPath..'wowChess_([prnbkq])([ld])');
				if ((color == "d") and (wowChess_isBlack == 1)) or ((color == "l") and (wowChess_isBlack == 0)) then
					-- Pick up piece and set background color to red
					wowChess_pieceUp = id;
					if (not wowChess_isMuted) then
						wowChess_PlaySoundEffect(piece..color, "up");
					end
					wowChess_HilightValidMoves(id);
					getglobal("ChessButton"..id):SetHighlightTexture("Interface\\AddOns\\wowChess\\Images\\wowChessHilightSquare_blue");
					getglobal("ChessButton"..id):LockHighlight();
				end
			end
		else
			-- If a piece has been picked up already
			-- Make sure handle to piece is good
	
			local texture = getglobal("ChessButton"..wowChess_pieceUp.."Piece"):GetTexture();
			if ((texture ~= nil) and (texture ~= "")) then
				--Check if the piece is allowed to move to the destination
				if (wowChess_ValidateMove(idGrid[rwowChess_pieceUp], idGrid[rid])) then
					--Figure out what piece were moving
					local start,stop,piece,color = string.find(texture, wowChess_piecesPath..'wowChess_([prnbkq])([ld])');
					--Move piece, notify wowChess_opponent to do the same
					wowChess_MovePieceID(rwowChess_pieceUp, rid);	
					waitingForAck = 1;
					local move = string.upper(piece)..idGrid[rwowChess_pieceUp]..cap..idGrid[rid];
					animate["move"] = move;
					clockRunning = 1;
					if (debugging == 1) then
						wowChess_msg("cm "..move);
						wowChess_CommandHandler("ack", wowChess_opponent);
						if (wowChess_isBlack == 1) then
							wowChess_isBlack = 0;
						else
							wowChess_isBlack = 1;
						end
					else
						wowChess_SendTell("cm "..move);
					end
				end
			end
			-- Un-red the picked up spot and reset the pickedup id
			wowChess_ResetHilights();
			wowChess_pieceUp = 0;

		end
	end
end

-- This function will handle move validation, returning nil for a bad move, 1 for a good.
--   Right now it just prevents you from capturing your own pieces.
--   passed as spaces ("a1") not ID's (64)
function wowChess_ValidateMove(from, to)

	local fromSpace = wcBoard[from];
	local toSpace = wcBoard[to];
	local start,stop,fromPiece,fromColor = string.find(fromSpace, '([prnbkq])([ld])');
	local start,stop,toPiece,toColor = string.find(toSpace, '([prnbkq])([ld])');
	
	local start, stop, fromCol, fromRow = string.find(from, '([a-h])([1-8])');
	local start, stop, toCol, toRow = string.find(to, '([a-h])([1-8])');
	

	-- Make sure the piece being moved is owned by the current turn taker
	local turnBlack;
	if (fromColor=="l") then
		turnBlack = 0;
	else
		turnBlack = 1;
	end
	if (mod(wowChess_gameMoveCount,2)==turnBlack) then
		return nil;
	end
	
	--If destination is not empty		
	if (toSpace ~= "") then
		--If destination is occupied by friendly piece, fail
		if (fromColor == toColor) then
			return nil;
		end
	end
	
	--Do castling check
	if (fromPiece == "k") then
		local kingFinish, rookStart, rookFinish = wowChess_canCastle(toCol, toRow, fromColor);
		if (kingFinish ~= nil) then
			if kingFinish=="cantcuzcheck" then
				wowChess_msg(wowChess_STR_CantCastleThruCheck);
				return nil;
			else
				--Do the castling move
				if (fromColor == "l") then
					whiteCanCastleLeft = nil;
					whiteCanCastleRight = nil;
				else
					blackCanCastleLeft = nil;
					blackCanCastleRight = nil;
				end
				local rs, rf;
				if (isRotated) then
					rs = idGrid[65-spaceGrid[rookStart]];
					rf = idGrid[65-spaceGrid[rookFinish]];
				else
					rs = rookStart;
					rf = rookFinish;
				end
				rookanimate["frompiece"] = "ChessButton"..spaceGrid[rs];
				rookanimate["topiece"] = "ChessButton"..spaceGrid[rf];
				rookanimate["frame"] = 1;
				
				rookanimate["to"] = rookFinish;
				rookanimate["from"] = rookStart;
				
				animate["to"] = to;
				animate["from"] = from;
				
				return 1;
			end
		end
	end

	if ( wowChess_ValidatePiece(from, to, 1) ) then
		
		--Pawn promotion
		if (fromPiece == "p") then
			local c, rowBase;
			if (fromColor == "l") then
				c = 1;
				rowBase = 2;
			else
				c = -1;
				rowBase = 7;
			end
			--If pawn is reaching far backrow, promote to Queen
			if (tonumber(toRow)==rowBase+(6*c)) then
				wowChess_msg(wowChess_STR_PawnPromoted);
				wcBoard[from] = "q"..fromColor;
			end
		end

		--Go ahead and do the move and set check flags then undo the move.
		local tempPiece = wcBoard[to];
		wcBoard[to] = wcBoard[from];
		wcBoard[from] = "";
		local whiteInCheck, blackInCheck = wowChess_checkCheck();
		
		local inCheck;
		if (fromColor == "l") then
			inCheck = whiteInCheck;
			oppCheck = blackInCheck;
		else
			inCheck = blackInCheck;
			oppCheck = whiteInCheck;
		end

		wcBoard[from] = wcBoard[to];
		wcBoard[to] = tempPiece;


		if (inCheck) then
			wowChess_msg(wowChess_STR_CantMoveKingInCheck);
			--Undo temp move
			return nil;
		else
			
			--update canCastle flags if its a rook or king moving
			if (fromColor == "l") then
				if (fromPiece == "k") then
					whiteCanCastleLeft = nil;
					whiteCanCastleRight = nil;
				end
				if (fromPiece == "r") then
					if (fromCol=="a" and fromRow=="1") then
						whiteCanCastleLeft = nil;
					elseif (fromCol=="h" and fromRow=="1") then
						whiteCanCastleRight = nil;	
					end		
				end
			else
				if (fromPiece == "k") then
					blackCanCastleLeft = nil;
					blackCanCastleRight = nil;
				end
				if (fromPiece == "r") then
					if (fromCol=="a" and fromRow=="8") then
						blackCanCastleLeft = nil;
					elseif (fromCol=="h" and fromRow=="8") then
						blackCanCastleRight = nil;	
					end		
				end		
			end

			if (wcBoard[to] == "") then
				cap = "-";
			else
				cap = "x";
				if (fromColor == "l") then
					whiteJail[toPiece] = whiteJail[toPiece] + 1;
				else
					blackJail[toPiece] = blackJail[toPiece] + 1;
				end
				wowChess_UpdateJailTotals();
			end
			
			--Swap turn icons and display check if needed.
			getglobal("wowChessPlayerFrameBlackCheck"):Hide();
			getglobal("wowChessPlayerFrameWhiteCheck"):Hide();
			if (mod(wowChess_gameMoveCount,2)==0) then
				--wowChess_msg("Ending blacks turn");
				getglobal("wowChessPlayerFrameBlackTurn"):Hide();
				getglobal("wowChessPlayerFrameWhiteTurn"):Show();
				if (oppCheck) then
					getglobal("wowChessPlayerFrameWhiteCheck"):Show();
				end
			else
				--wowChess_msg("Ending whites turn");
				getglobal("wowChessPlayerFrameBlackTurn"):Show();
				getglobal("wowChessPlayerFrameWhiteTurn"):Hide();
				if (oppCheck) then
					getglobal("wowChessPlayerFrameBlackCheck"):Show();
				end		
			end
			
			--Set lastPawn if its moving into a valid target for en passant
			lastPawn = "";
			if (fromPiece == "p") then
				if (fromColor == "l") then
					if (fromRow == "2") then
						lastPawn = to;
					end
				else
					if (fromRow == "7") then
						lastPawn = to;
					end
				end
			end
			
			--Actually make the move and return true
			animate["to"] = to;
			animate["from"] = from;
			return 1;
		end
	else
		return nil;
	end
end

function wowChess_ValidatePieceCheck(from, to, doMove, fromColor)	
	local start,stop,toPiece,toColor = string.find(wcBoard[to], '([prnbkq])([ld])');

	wowChess_msg("from="..from.." to="..to);

	--Go ahead and do the move and set check flags then undo the move.
	local tempPiece = wcBoard[to];
	wcBoard[to] = wcBoard[from];
	wcBoard[from] = "";
	local whiteInCheck, blackInCheck = wowChess_checkCheck();

	local inCheck;
	if (fromColor == "l") then
		inCheck = whiteInCheck;
	else
		inCheck = blackInCheck;
	end
	
	wcBoard[from] = wcBoard[to];
	wcBoard[to] = tempPiece;
			
	if (inCheck) then
		return nil;
	else
		return 1;
	end
end

function wowChess_ValidatePiece(from, to, doMove)
	local fromSpace = wcBoard[from];
	local toSpace = wcBoard[to];
	
	local start,stop,fromPiece,fromColor = string.find(fromSpace, '([prnbkq])([ld])');
	local start,stop,toPiece,toColor = string.find(toSpace, '([prnbkq])([ld])');
	
	local start, stop, fromCol, fromRow = string.find(from, '([a-h])([1-8])');
	local start, stop, toCol, toRow = string.find(to, '([a-h])([1-8])');

	if (fromColor == toColor) then
		return nil;
	end	
	
	--Convert a-h to 1-8
	fromCol = colsNum[fromCol];
	toCol = colsNum[toCol];
	
	--Convert strings to nums
	fromRow = tonumber(fromRow);
	toRow = tonumber(toRow);
	
	--Pawn
	if (fromPiece == "p") then
		local c;
		local rowBase;
		
		--Set direction of travel and baserow depending on color of piece moving
		if (fromColor == "l") then
			c = 1;
			rowBase = 2;
			oppColor = "d";
		else
			c = -1;
			rowBase = 7;
			oppColor = "l";
		end
		
		-- Allow pawn to move one space ahead if space is free
		if (toRow==fromRow+(1*c) and toCol==fromCol and toSpace == "") then
			return 1;
		end
		-- Allow pawn to move 2 spaces if first move by pawn, and both spaces are empty
		if (fromRow==rowBase and toRow==fromRow+(2*c) and toCol==fromCol and toSpace == "" and wcBoard[cols[fromCol]..(fromRow+(1*c))]=="") then
			return 1;
		end
		
		-- Allow pawn to take a piece in the forward diagonal
		if ( toRow==fromRow+c and (toCol==fromCol-1 or toCol==fromCol+1) and toSpace~="") then
			return 1;
		end
		
		--Allow En Passant captures as well
		local start, stop, pawnCol, pawnRow = string.find(lastPawn, '([a-h])([1-8])');
		if (start==1) then
			pawnCol = colsNum[pawnCol];
			if ( (toRow==fromRow+c and toCol==pawnCol) and tonumber(pawnRow)==fromRow and (toCol==fromCol-1 or toCol==fromCol+1) ) then
				
				if (doMove) then
					wcBoard[lastPawn] = "";
				end
				return 1;
			end
		end
		
		-- Else
		return nil;
	end

	--Knight
	if (fromPiece == "n") then
		if ( (toRow==fromRow-2 or toRow==fromRow+2) and (toCol==fromCol+1 or toCol==fromCol-1) ) or 
		   ( (toRow==fromRow-1 or toRow==fromRow+1) and (toCol==fromCol+2 or toCol==fromCol-2) ) then
			return 1;
		else
			return nil;
		end
	end
	
	--Rook
	if (fromPiece == "r") then
		return wowChess_StraightCheck(fromCol, fromRow, toCol, toRow);

	end
	
	--Bishop
	if (fromPiece == "b") then
		return wowChess_DiagonalCheck(fromCol, fromRow, toCol, toRow)
	end
	
	--Queen
	if (fromPiece == "q") then
		if (wowChess_StraightCheck(fromCol, fromRow, toCol, toRow)) then
			return 1;
		else
			return wowChess_DiagonalCheck(fromCol, fromRow, toCol, toRow);
		end
	end
	
	--King
	if (fromPiece == "k") then
		if (toRow==fromRow or toRow==fromRow-1 or toRow==fromRow+1) and
		   (toCol==fromCol or toCol==fromCol-1 or toCol==fromCol+1) then
			return 1;
		else
			local kingFinish, rookStart, rookFinish = wowChess_canCastle(cols[toCol], tostring(toRow), fromColor);
			if (kingFinish ~= nil) then
				if (kingFinish == "cantcuzcheck") then
					return nil;
				else
					return 1;
				end
			else
				return nil;
			end
		end
	end
	
	wowChess_msg("Error: no piece handled. from="..from.." to="..to);
	return nil;
end

function wowChess_UpdateJailTotals()
	getglobal("wowChessJailWhitePawnCount"):SetText(whiteJail["p"]);
	getglobal("wowChessJailWhiteKnightCount"):SetText(whiteJail["n"]);
	getglobal("wowChessJailWhiteBishopCount"):SetText(whiteJail["b"]);
	getglobal("wowChessJailWhiteRookCount"):SetText(whiteJail["r"]);
	getglobal("wowChessJailWhiteQueenCount"):SetText(whiteJail["q"]);
	getglobal("wowChessJailBlackPawnCount"):SetText(blackJail["p"]);
	getglobal("wowChessJailBlackKnightCount"):SetText(blackJail["n"]);
	getglobal("wowChessJailBlackBishopCount"):SetText(blackJail["b"]);
	getglobal("wowChessJailBlackRookCount"):SetText(blackJail["r"]);
	getglobal("wowChessJailBlackQueenCount"):SetText(blackJail["q"]);
end

function wowChess_ShowPortraits()
	if (wowChess_opponent~=0) then
		if (whitePortraitShown==nil or blackPortraitShown==nil) then
			local opponentUnit = nil;
			if (portraitShown == nil) then
				--Find opponent
				if (wowChess_opponent==UnitName("target")) then
					opponentUnit = "target";
				end
				for i=1,4 do
					if (wowChess_opponent==UnitName("party"..i)) then
						opponentUnit = "party"..i
					end
				end
				for i=1,40 do
					if (wowChess_opponent==UnitName("raid"..i)) then
						opponentUnit = "raid"..i
					end
				end
			end
			if (wowChess_isBlack==1) then
				playerBlack = UnitName("player");
				playerWhite = wowChess_opponent;
				blackUnit = "player";
				whiteUnit = opponentUnit;
			else
				playerWhite = UnitName("player");
				playerBlack = wowChess_opponent;
				blackUnit = opponentUnit;
				whiteUnit = "player";
			end
			getglobal("wowChessPlayerFrameWhiteName"):SetText(playerWhite);
			getglobal("wowChessPlayerFrameBlackName"):SetText(playerBlack);
			if (whiteUnit ~= nil) then
				SetPortraitTexture(getglobal("wowChessPlayerFrameWhitePortrait"), whiteUnit);
				whitePortraitShown = 1;
			end
			if (blackUnit ~= nil) then
				SetPortraitTexture(getglobal("wowChessPlayerFrameBlackPortrait"), blackUnit);
				blackPortraitShown = 1;
			end
		end
	else
		--No opponent, clear portraits and names
		getglobal("wowChessPlayerFrameWhiteName"):SetText("");
		getglobal("wowChessPlayerFrameBlackName"):SetText("");
		SetPortraitTexture(getglobal("wowChessPlayerFrameWhitePortrait"), "");
		SetPortraitTexture(getglobal("wowChessPlayerFrameBlackPortrait"), "");
	end
end

--Does valid move highlighting
function wowChess_HilightValidMoves(fromid)
	if (isRotated) then
		rfromid = 65-fromid;
	else
		rfromid = fromid;
	end
	local fromSpace = idGrid[rfromid];
	local start,stop,fromPiece,fromColor = string.find(wcBoard[fromSpace], '([prnbkq])([ld])');

 	--Loop thru entire grid
 	for y=1,8 do
 		for x=1,8 do
                        local id = 8*(x-1)+y;
                        if (isRotated) then
                        	rid = 65-id;
                        else
			        rid = id;
                        end
                        local space = getglobal("ChessButton"..id);
                        local spvalid = getglobal("ChessButton"..id.."Valid");
			if ( wowChess_ValidatePiece(idGrid[rfromid], idGrid[rid], nil) ) then
					
					
					local toSpace = idGrid[rid];
					
					--Go ahead and do the move and set check flags then undo the move.
					local tempPiece = wcBoard[toSpace];
					wcBoard[toSpace] = wcBoard[fromSpace];
					wcBoard[fromSpace] = "";

					--wowChess_msg("tempMoveMade in validpiececheck a8="..wcBoard["a8"].." e8="..wcBoard["e8"]);
					local whiteInCheck, blackInCheck = wowChess_checkCheck();

					local inCheck;
					--wowChess_msg("fromColor="..fromColor);
					if (fromColor=="l") then
						inCheck = whiteInCheck;
					else
						inCheck = blackInCheck;
					end

					wcBoard[fromSpace] = wcBoard[toSpace];
					wcBoard[toSpace] = tempPiece;
					
				if (not inCheck) then
					space:SetHighlightTexture("Interface\\AddOns\\wowChess\\Images\\wowChessHilightSquare_green", "ADD");
					spvalid:SetTexture("Interface\\AddOns\\wowChess\\Images\\wowChessHilightSquare_green", "BLEND");
				end
					
			elseif ( fromid == id ) then
				space:SetHighlightTexture("Interface\\AddOns\\wowChess\\Images\\wowChessHilightSquare_blue", "ADD");
				spvalid:SetTexture("Interface\\AddOns\\wowChess\\Images\\wowChessHilightSquare_blue", "BLEND");
			
			else
				space:SetHighlightTexture("Interface\\AddOns\\wowChess\\Images\\wowChessHilightSquare_red", "ADD");
			end
 		end
	end					
end

--Resets highlights
function wowChess_ResetHilights()
 	--Loop thru entire grid
 	for y=1,8 do
 		for x=1,8 do
                        local id = 8*(x-1)+y;
                        local space = getglobal("ChessButton"..id);
                        local spvalid = getglobal("ChessButton"..id.."Valid");
                        space:UnlockHighlight();
			space:SetHighlightTexture("Interface\\AddOns\\wowChess\\Images\\wowChessHilightSquare_blue", "ADD");
			spvalid:SetTexture("", "ADD");

 		end
	end					
end

function wowChess_HilightLast()
	wowChess_ResetLast();
	if (lastMove[1]~=nil and lastMove[1]~="") then
		local frompiece = lastMove[1];
		local topiece = lastMove[2]; 
		if (isRotated) then
			frompiece = 65-tonumber(frompiece);
			topiece = 65-tonumber(topiece);	
		end
		local fromvalid = getglobal("ChessButton"..frompiece.."Last");
		local tovalid = getglobal("ChessButton"..topiece.."Last");
		fromvalid:SetTexture("Interface\\AddOns\\wowChess\\Images\\wowChessHilightSquare_yellow", "BLEND");
		tovalid:SetTexture("Interface\\AddOns\\wowChess\\Images\\wowChessHilightSquare_yellow", "BLEND");			
	end
end

function wowChess_ResetLast()
 	--Loop thru entire grid
 	for y=1,8 do
 		for x=1,8 do
                        local id = 8*(x-1)+y;
                        local splast = getglobal("ChessButton"..id.."Last");
                        splast:SetTexture("", "ADD");

 		end
	end					
end

function wowChess_UpdateIcons()
		
		local whiteInCheck, blackInCheck = wowChess_checkCheck();
		
		--Swap turn icons and display check if needed.
		getglobal("wowChessPlayerFrameBlackCheck"):Hide();
		getglobal("wowChessPlayerFrameWhiteCheck"):Hide();
		if (mod(wowChess_gameMoveCount,2)==1) then
			--wowChess_msg("Ending blacks turn");
			getglobal("wowChessPlayerFrameBlackTurn"):Hide();
			getglobal("wowChessPlayerFrameWhiteTurn"):Show();
			if (whiteCheck) then
				getglobal("wowChessPlayerFrameWhiteCheck"):Show();
			end
		else
			--wowChess_msg("Ending whites turn");
			getglobal("wowChessPlayerFrameBlackTurn"):Show();
			getglobal("wowChessPlayerFrameWhiteTurn"):Hide();
			if (blackCheck) then
				getglobal("wowChessPlayerFrameBlackCheck"):Show();
			end		
		end
end

--Plays sound effects
function wowChess_PlaySoundEffect(piece, direction)
	local soundLocation = wowChess_piecesPath..'Sounds\\wowChess_'..piece..'_'..direction;
	local numSounds = wowChess_skinSounds[soundLocation];
	if (numSounds == nil) then
		numSounds = 8;
		for n=numSounds,1,-1 do
			if ( PlaySoundFile(soundLocation..n..'.wav') ) then
				wowChess_skinSounds[soundLocation] = n;
				return;
			end
		end
	else
		local num = math.random(1, numSounds);
		PlaySoundFile(soundLocation..num..'.wav');
	end
	
end

--returns toKing, fromCastle, toCastle, or cantcuzcheck
function wowChess_canCastle(toCol, toRow, fromColor)
	local rowBase;
	if (fromColor == "l") then
		rowBase = "1";
	else
		rowBase = "8";
	end
	--Check for castling
	if ( (toCol=="c" or toCol=="g") and toRow==rowBase ) then
		if (wowChess_canCastleHasntMoved(toCol, rowBase)) then
			local realBoard = {};
			wowChess_tcopy(realBoard, wcBoard);

			local moveList;
			if (toCol == "c") then
				moveList = { "e", "d", "c" };
			elseif (toCol == "g") then
				moveList = { "e", "f", "g" };
			end

			for index=2,4 do
				--wowChess_msg("checking check for "..fromColor.." king to "..moveList[index-1]..rowBase);
				local whiteInCheck, blackInCheck = wowChess_checkCheck();
				local inCheck;
				if (fromColor == "l") then
					inCheck = whiteInCheck;
				else
					inCheck = blackInCheck;
				end
				if (inCheck) then
					wowChess_tcopy(wcBoard, realBoard);
					return "cantcuzcheck", "";
				end
				if (index~=4) then
					wcBoard[moveList[index]..rowBase] = wcBoard[moveList[index-1]..rowBase];
					wcBoard[moveList[index-1]..rowBase] = "";
				end
			end
			wowChess_tcopy(wcBoard, realBoard);
			--Castling approved
			if (toCol == "c") then
				return "c"..rowBase, "a"..rowBase, "d"..rowBase;
			elseif (toCol == "g") then
				return "g"..rowBase, "h"..rowBase, "f"..rowBase;
			end
		end			
	end
	return nil;
end

--Return true if the king+castle has not moved this game
function wowChess_canCastleHasntMoved(col, row)
	if (col=="c" and wcBoard["b"..row]=="" and wcBoard["c"..row]=="" and wcBoard["d"..row]=="") then
		--Queen's side
		if (row == "1") then
			return whiteCanCastleLeft;
		else
			return blackCanCastleLeft;
		end
	elseif (col == "g" and wcBoard["f"..row]=="" and wcBoard["g"..row]=="") then
		--King's side
		if (row == "1") then
			return whiteCanCastleRight;
		else
			return blackCanCastleRight;
		end
	end
	
end

--check if move puts opponent into a stalemate
function wowChess_checkStalemate(fromColor)
	local oppColor;
	if (fromColor == "l") then
		oppColor = "d";
	else
		oppColor = "l";
	end
	
	--Loop thru entire grid
	for x=1,8 do
		for y=1,8 do
			local fromSpace = cols[x]..(9-y);
			local start,stop,ifromPiece,ifromColor = string.find(wcBoard[fromSpace], '([prnbkq])([ld])');
			
			--For each space occupied by opp piece
			if (start==1 and oppColor==ifromColor) then
				
				--Try to move it to every spot on board, if any move returns valid, no stalemate
				for inx=1,8 do
					for iny=1,8 do
						local toSpace = cols[inx]..(9-iny);

						if ( wowChess_ValidatePiece(fromSpace, toSpace, nil) ) then
				
							--Go ahead and do the move and set check flags then undo the move.
							local tempPiece = wcBoard[toSpace];
							wcBoard[toSpace] = wcBoard[fromSpace];
							wcBoard[fromSpace] = "";
							
							local whiteInCheck, blackInCheck = wowChess_checkCheck();

							local inCheck;
							if (oppColor=="l") then
								inCheck = whiteInCheck;
							else
								inCheck = blackInCheck;
							end

							wcBoard[fromSpace] = wcBoard[toSpace];
							wcBoard[toSpace] = tempPiece;
							
							if (not inCheck) then
								--Nostalemate
								return;
							end


						end
					end
				end
			end
					
		end
	end
	--Nostalemate never occured, so stalemate has occured.
	wowChess_DrawGame();
end


--Loop thru every opponent move possible to determine if check is removed
function wowChess_checkCheckmate(fromColor)
	local oppColor;
	if (fromColor == "l") then
		oppColor = "d";
	else
		oppColor = "l";
	end
	local canMove = nil;
	--Loop thru entire grid
	for x=1,8 do
		for y=1,8 do
			local fromSpace = cols[x]..(9-y);
			local start,stop,ifromPiece,ifromColor = string.find(wcBoard[fromSpace], '([prnbkq])([ld])');
			
			--For each space occupied by opp piece
			if (start==1 and oppColor==ifromColor) then
				
				--Try to move it to every spot on board and see if check is removed
				for inx=1,8 do
					for iny=1,8 do
						local toSpace = cols[inx]..(9-iny);
						local start,stop,itoPiece,itoColor = string.find(wcBoard[toSpace], '([prnbkq])([ld])');
						if ( wowChess_ValidatePiece(fromSpace, toSpace, nil) ) then
							--Go ahead and do the move and set check flags then undo the move.
							local tempPiece = wcBoard[toSpace];
							wcBoard[toSpace] = wcBoard[fromSpace];
							wcBoard[fromSpace] = "";
							local whiteInCheck, blackInCheck = wowChess_checkCheck();

							local inCheck;
							if (oppColor == "l") then
								inCheck = whiteInCheck;
							else
								inCheck = blackInCheck;
							end
							
							--IF check has been removed, set canMove flag
							if (not inCheck) then
								canMove = 1;
							end
							
							--Undo temp move
							wcBoard[fromSpace] = wcBoard[toSpace];
							wcBoard[toSpace] = tempPiece;

						end
					end
				end
			end
					
		end
	end
	--If no move is possible, game is over
	if (canMove==nil) then
		wowChess_EndGame(fromColor);
	end
end

-- Sets whiteInCheck and blackInCheck flags
function wowChess_checkCheck()
	local whiteInCheck = nil;
	local blackInCheck = nil;
	local blackKing = "";
	local whiteKing = "";

	--Loop thru entire grid
	for x=1,8 do
		for y=1,8 do
			local sp = wcBoard[cols[x]..(9-y)];
			local start,stop,iPiece,iColor = string.find(sp, '([prnbkq])([ld])');
			if (start==1 and iPiece=="k") then
				if (iColor=="l") then
					whiteKing = cols[x]..(9-y);
				else
					blackKing = cols[x]..(9-y);
				end
			end
		end
	end
	
	--Loop thru entire grid
	for x=1,8 do
		for y=1,8 do
			local sp = wcBoard[cols[x]..(9-y)];
			local start,stop,fromPiece,fromColor = string.find(sp, '([prnbkq])([ld])');
			if (start==1) then
				
				if (fromColor=="l") then 
					if ( (not blackInCheck) and wowChess_ValidatePiece(cols[x]..(9-y), blackKing, nil) ) then
						blackInCheck = 1;
					end
				else
					if ( (not whiteInCheck) and wowChess_ValidatePiece(cols[x]..(9-y), whiteKing, nil) ) then
						whiteInCheck = 1;
					end
				end
			end
		end
	end
	return whiteInCheck, blackInCheck;
end

--Checks if move is valid on diagonal
function wowChess_DiagonalCheck(fromCol, fromRow, toCol, toRow)
	local xDiff = toCol-fromCol;
	local yDiff = toRow-fromRow;
	local xc, yc;
	if (xDiff > 0) then
		xc = -1;
	else
		xc = 1;
	end
	if (yDiff > 0) then
		yc = -1;
	else
		yc = 1;
	end
	if abs(xDiff) == abs(yDiff) then
		for offset=1,abs(xDiff)-1 do
			sp = cols[toCol+(offset*xc)]..toRow+(offset*yc);
			if (wcBoard[sp] ~= "") then
				return nil;
			end
		end
		return 1;
	else
		return nil;
	end
end

--Checks if move is valid on straight horiz and vert lines
function wowChess_StraightCheck(fromCol, fromRow, toCol, toRow)
	local xDiff = toCol-fromCol;
	local yDiff = toRow-fromRow;
	local max, c, maxDir;
	if (fromCol==toCol or fromRow==toRow) then
	
		if ( abs(xDiff) > abs(yDiff) ) then
			max = xDiff;
			maxDir = "x";
		else
			max = yDiff;
			maxDir = "y";
		end
		if (max > 0) then
			c = -1;
		else
			c = 1;
		end

		for offset=1,abs(max)-1 do			
			if (maxDir == "y") then
				sp = cols[toCol]..toRow+(offset*c);
			else
				sp = cols[toCol+(offset*c)]..toRow;	
			
			end
			if (wcBoard[sp] ~= "") then
				return nil;
			end
		end
		return 1;
	else
		return nil;
	end
end

--Moves a piece from space to space (from "a1" to "b3")
function wowChess_MovePiece(from, to)
	wowChess_MovePieceID(spaceGrid[from], spaceGrid[to]);
end

local oldTexture;
--Moves a piece from spaceID to spaceID (from 45 to 32)
function wowChess_MovePieceID(from, to)
	if (isRotated) then
		from = 65-from;
		to = 65-to;
	end
	animate["frompiece"] = from;
	animate["topiece"] = to;
	animate["frame"] = 1;
end

--You have been challenged, show confirm dialog
function wowChess_Challenged(opp, time)
	if (challenger=="") then
		local start,stop,totalTime,moveBonus = string.find(time, '([0-9]+)/([0-9]+)');
		if (start==1) then
			timeLimit = tonumber(totalTime)*60;
			timeMoveBonus = tonumber(moveBonus);
		else
			time = "untimed";
			timeLimit = 0;
			timeMoveBonus = 0;
		end

		confirmMode = "challenge";
		challenger = opp;
		local dialog = StaticPopup_Show("WOWCHESS_CHALLENGE", opp.." has challenged you to a "..time.." game of Chess. Do you accept?");
	end
end

--You have accepted a challenge
function wowChess_ChallengeYesButton()
	if (confirmMode=="challenge") then
		wowChess_opponent = challenger;
		wowChess_isBlack = 1;
		wowChess_SendTell("cm challengeaccepted");
		wowChess_StartGame();
	elseif (confirmMode=="draw") then
		wowChess_SendTell("cm drawaccepted");
		wowChess_DrawGame();
	end
	confirmMode = "";
end

function wowChess_ChallengeNoButton()
	if (confirmMode=="challenge") then
		SendChatMessage("cm challengedenied", "WHISPER", nil, challenger);
		challenger = "";
	elseif (confirmMode=="draw") then
		wowChess_SendTell("cm drawdenied");
	end
	confirmMode = "";
end

--You are challenging an wowChess_opponent
function wowChess_Challenge(opp, time)
	
	local start,stop,totalTime,moveBonus = string.find(time, '([0-9]+)/([0-9]+)');
	if (start==1) then
		timeLimit = tonumber(totalTime)*60;
		timeMoveBonus = tonumber(moveBonus);
	else
		time = "";
		timeLimit = 0;
		timeMoveBonus = 0;
	end
	
	if (wowChess_opponent == 0) then
		challengedOpp = opp;
		SendChatMessage("cm challenge v"..version.." "..time, "WHISPER", nil, opp);
	else
		wowChess_msg(wowChess_STR_CantChallengePlaying);
	end
end

--The wowChess_opponent has accepted your challenge
function wowChess_ChallengeAccepted(opp)
	if (string.lower(opp) == string.lower(challengedOpp)) then
		wowChess_opponent = opp;
		wowChess_isBlack = 0;
		wowChess_StartGame();
	end
end

function wowChess_CopySavedGame(fromPlayer, toPlayer) 
	if (wowChess_SavedGames[string.lower(fromPlayer)]~=nil) then
		wowChess_msg(wowChess_STR_CopyingPlayer1..wowChess_Capitalize(string.lower(fromPlayer))..wowChess_STR_CopyingPlayer1..wowChess_Capitalize(string.lower(toPlayer)));
		
		local savedGame = wowChess_SavedGames[string.lower(fromPlayer)];
		local newGame = {
			savedGame[1], savedGame[2], savedGame[3], 
			savedGame[4], savedGame[5], savedGame[6],
			savedGame[7], savedGame[8], savedGame[9],
			savedGame[10], savedGame[11]
		}
		--wowChess_tcopy(newGame, savedGame);
		newGame[9] = wowChess_Capitalize(string.lower(toPlayer));
		wowChess_SavedGames[string.lower(toPlayer)] = newGame;
	else
		wowChess_msg(wowChess_STR_NoSavedData..fromPlayer);
	end
end

function wowChess_SaveGame()
	if (wowChess_opponent) then
		wowChess_gameMoveCount = wowChess_gameMoveCount + 1;
		local newBlackJail = {};
		local newWhiteJail = {};
		wowChess_tcopy(newBlackJail, blackJail);
		wowChess_tcopy(newWhiteJail, whiteJail);
		local newMoveLog = {};
		wowChess_tcopy(newMoveLog, wowChess_MoveLog);
		
		local newPlayClocks = { 0, 0 };
		wowChess_tcopy(newPlayClocks, playClocks);
		
		local savedGame = {
			whiteCanCastleLeft,
			whiteCanCastleRight,
			blackCanCastleLeft,
			blackCanCastleRight,
			wowChess_pieceUp,
			wcBoard,
			wowChess_gameMoveCount,
			wowChess_isBlack,
			wowChess_opponent,
			newWhiteJail,
			newBlackJail,
			wowChess_MoveLogLength,
			newMoveLog,
			lastMove,
			newPlayClocks,
			timeLimit,
			timeMoveBonus;

		}
		wowChess_SavedGames[string.lower(wowChess_opponent)] = savedGame;
		--wowChess_msg("Game against "..wowChess_opponent.." has been saved.");
	else
		--wowChess_msg("You cant save unless your playing a game");
	end
end

function wowChess_RestoreGame(opp)
	local savedGame = wowChess_SavedGames[string.lower(opp)];
	if (savedGame~=nil) then
		whiteCanCastleLeft = savedGame[1];
		whiteCanCastleRight = savedGame[2];
		blackCanCastleLeft = savedGame[3];
		blackCanCastleRight = savedGame[4];
		wowChess_pieceUp = savedGame[5];
		wcBoard = savedGame[6];
		wowChess_gameMoveCount = savedGame[7];
		wowChess_isBlack = savedGame[8];
		wowChess_opponent = savedGame[9];
		whiteJail = savedGame[10];
		blackJail = savedGame[11];
		wowChess_MoveLogLength = savedGame[12];
		wowChess_MoveLog = savedGame[13];
		lastMove = savedGame[14];
		playClocks = savedGame[15];
		timeLimit = savedGame[16];
		timeMoveBonus = savedGame[17];
		
		lastClockUpdate = GetTime();
		wowChess_UpdateIcons();
		wowChess_UpdateJailTotals();
		wowChess_UpdateBoard();
		wowChess_ResetHilights();
		wowChess_msg(wowChess_STR_GameRestored1..wowChess_opponent..wowChess_STR_GameRestored2);
	else
		wowChess_msg(wowChess_STR_NoSavedData..opp);
	end
end

--Sets spaceid to piece
function wowChess_SetSpace(spaceid, piece)
	if (piece ~= "") then
		piece = wowChess_piecesPath..'wowChess_'..piece;
	end
	space = getglobal("ChessButton"..spaceid.."Piece");
	space:SetTexture(piece);
end

--Redraw the board textures
function wowChess_UpdateBoard()	
	wowChess_ShowPortraits();
	if (wcBoard["h8"]~=nil) then
		--Loop thru entire grid
		for y=1,8 do
			for x=1,8 do
				local piece;
				if (isRotated) then
					piece = cols[9-x]..(y);
				else
					piece = cols[x]..(9-y);
				end
				--    piece = wcBoard["a8"]
				piece = wcBoard[piece];
				--       SetSpace(1, "rd")
				wowChess_SetSpace((y-1)*8+x,piece);
			end
		end
	end
end

function wowChess_drawSpaces()
 	--Loop thru entire grid
 	for y=1,8 do
 		for x=1,8 do
                        local id = 8*(x-1)+y;
			if ( mod(y+x,2)==1 ) then
				getglobal("ChessButton"..id.."Background"):SetTexture(wowChess_piecesPath.."wowChess_td");
			    --getglobal("ChessButton"..id.."Background"):SetVertexColor(0.5,0.9,0.5,0.5);
			else
				getglobal("ChessButton"..id.."Background"):SetTexture(wowChess_piecesPath.."wowChess_tl");
			   -- getglobal("ChessButton"..id.."Background"):SetVertexColor(0.9,0.9,0.9,0.5);

			end
 		end
	end
	
	getglobal("wowChessJailBlackPawn"):SetTexture(wowChess_piecesPath.."wowChess_pl");
	getglobal("wowChessJailBlackKnight"):SetTexture(wowChess_piecesPath.."wowChess_nl");
	getglobal("wowChessJailBlackBishop"):SetTexture(wowChess_piecesPath.."wowChess_bl");
	getglobal("wowChessJailBlackRook"):SetTexture(wowChess_piecesPath.."wowChess_rl");
	getglobal("wowChessJailBlackQueen"):SetTexture(wowChess_piecesPath.."wowChess_ql");
	
	getglobal("wowChessJailWhitePawn"):SetTexture(wowChess_piecesPath.."wowChess_pd");
	getglobal("wowChessJailWhiteKnight"):SetTexture(wowChess_piecesPath.."wowChess_nd");
	getglobal("wowChessJailWhiteBishop"):SetTexture(wowChess_piecesPath.."wowChess_bd");
	getglobal("wowChessJailWhiteRook"):SetTexture(wowChess_piecesPath.."wowChess_rd");
	getglobal("wowChessJailWhiteQueen"):SetTexture(wowChess_piecesPath.."wowChess_qd");
	
	wowChess_UpdateJailTotals();

	--Draw row labels
	for i=1, 8 do
		local f = getglobal("RowLabel"..i);
		if (isRotated) then
			f:SetText(i);
		else
			f:SetText(9-i);
		end
	end
	--Draw col labels 30, 6
	local cols = { "A", "B", "C", "D", "E", "F", "G", "H" };
	for i=1, 8 do
		local f = getglobal("ColLabel"..i);
		if (isRotated) then
			f:SetText(cols[9-i]);
		else
			f:SetText(cols[i]);
		end
	end
end

--Clears board and opponent
function wowChess_ResetBoard()
	challenger = "";
	challengedOpp = "";
	blackJail = { p=0, n=0, b=0, r=0, q=0 };
	whiteJail = { p=0, n=0, b=0, r=0, q=0 };
	wowChess_opponent = 0;
	wowChess_gameMoveCount = 0;
	wcBoard = {
		a8="",   b8="",   c8="",   d8="",   e8="",   f8="",   g8="",   h8="",   
		a7="",   b7="",   c7="",   d7="",   e7="",   f7="",   g7="",   h7="",   
		a6="",   b6="",   c6="",   d6="",   e6="",   f6="",   g6="",   h6="",   
		a5="",   b5="",   c5="",   d5="",   e5="",   f5="",   g5="",   h5="",   
		a4="",   b4="",   c4="",   d4="",   e4="",   f4="",   g4="",   h4="",   
		a3="",   b3="",   c3="",   d3="",   e3="",   f3="",   g3="",   h3="", 
		a2="",   b2="",   c2="",   d2="",   e2="",   f2="",   g2="",   h2="",   
		a1="",   b1="",   c1="",   d1="",   e1="",   f1="",   g1="",   h1="",     
	}
	wowChess_UpdateBoard();
	wowChess_ResetLast();
	wowChess_UpdateJailTotals();
	wowChess_ShowPortraits();
end

--Init a new game
function wowChess_StartGame()
	whitePortraitShown = nil;
	blackPortraitShown = nil;
	wowChess_ShowPortraits();
	wowChess_MoveLogLength = 0;
	wowChess_MoveLog = {};
	wowChessMoveLogScrollBar_Update();
	playClocks = { 0, 0 };
	wowChess_SetClock("wowChessWhiteClock", playClocks[1]);
	wowChess_SetClock("wowChessBlackClock", playClocks[2]);
	clockRunning = nil;
	timerCounter = 0;
	lastMove = { "", "" };
	waitingForAck = nil;
	wowChess_gameMoveCount = 0;
	drawProposed = 0;
	whiteCanCastleLeft = 1;
	whiteCanCastleRight = 1;
	blackCanCastleLeft = 1;
	blackCanCastleRight = 1;
	blackJail = { p=0, n=0, b=0, r=0, q=0 };
	whiteJail = { p=0, n=0, b=0, r=0, q=0 };
	gameOver = nil;
	wcBoard = {

		a8="rd", b8="nd", c8="bd", d8="qd", e8="kd", f8="bd", g8="nd", h8="rd", 
		a7="pd", b7="pd", c7="pd", d7="pd", e7="pd", f7="pd", g7="pd", h7="pd", 

		a6="",   b6="",   c6="",   d6="",   e6="",   f6="",   g6="",   h6="",   
		a5="",   b5="",   c5="",   d5="",   e5="",   f5="",   g5="",   h5="",   
		a4="",   b4="",   c4="",   d4="",   e4="",   f4="",   g4="",   h4="",   
		a3="",   b3="",   c3="",   d3="",   e3="",   f3="",   g3="",   h3="",   

		a2="pl", b2="pl", c2="pl", d2="pl", e2="pl", f2="pl", g2="pl", h2="pl", 
		a1="rl", b1="nl", c1="bl", d1="ql", e1="kl", f1="bl", g1="nl", h1="rl" 

	}
	wowChess_SaveGame();
	wowChess_ResetLast();
	wowChess_UpdateBoard();
	wowChessWinVisible = 1
	wowChess:Show()
	getglobal("wowChessPlayerFrameWhiteTurn"):Show();
	if (wowChess_isBlack == 0) then
		wowChess_msg(wowChess_STR_WhiteOpening);
	else	
		wowChess_msg(wowChess_STR_BlackOpening);
	end
	challenger = "";
	challengedOpp = "";
end

function wowChess_DrawGame()
	wowChess_msg(wowChess_STR_GameoverDraw);
	wowChess_SavedGames[string.lower(wowChess_opponent)] = nil;
	wowChess_opponent = 0;
	
	wowChess_Totals[2] = wowChess_Totals[2] + 1;
end

function wowChess_EndGame(winColor)
	clockRunning = nil;
	local winner, loser;
	if (winColor == "l") then
		winner = wowChess_STR_White;
		loser = wowChess_STR_Black;
		if (wowChess_isBlack==1) then
			wowChess_Totals[3] = wowChess_Totals[3] + 1;
		else
			wowChess_Totals[1] = wowChess_Totals[1] + 1;
		end
	else
		winner = wowChess_STR_Black;
		loser = wowChess_STR_White;
		if (wowChess_isBlack==1) then
			wowChess_Totals[1] = wowChess_Totals[1] + 1;
		else
			wowChess_Totals[3] = wowChess_Totals[3] + 1;	
		end
	end
	wowChess_msg(wowChess_STR_GameOver1..winner..wowChess_STR_GameOver2..loser..".");
	wowChess_SavedGames[string.lower(wowChess_opponent)] = nil;
	wowChess_opponent = 0;
end

function wowChess_OfferDraw()
	if (wowChess_opponent~=0) then
		drawProposed = 1;
		wowChess_SendTell("cm draw");
	end
end

--Sends cmd as chat to the sticky channel
function wowChess_SendTell(msg)
	if (wowChess_opponent ~= 0) then
		if (debugging == 1) then
			wowChess_msg("msg: "..msg);	
		else
			SendChatMessage(msg, "WHISPER", nil, wowChess_opponent);
		end	
	end
end

--SlashHandler
function wowChess_SlashHandler(msg)
 	local cmd, SubCmd = wowChess_GetCmd(msg);
	if (cmd == "board") then
		wowChess_ToggleBoard();
		
	elseif (cmd == "start") then 
		wowChess_SetupBoard();
		
	elseif (cmd == "join") then
		wowChess_msg(wowChess_STR_JoiningChannel);
		JoinChannelByName("wowChess", nil, ChatFrame1:GetID());
		
	elseif (cmd == "challenge") then
		local player, time = wowChess_GetCmd(SubCmd);
		wowChess_Challenge(player, time);
		
	elseif (cmd == "draw") then
		wowChess_OfferDraw();
		
	elseif (cmd == "resign") then
		wowChess_SendTell("cm resign");
		local winner;
		if (wowChess_isBlack==1) then
			winner = "l";
		else
			winner = "d";
		end
		wowChess_EndGame(winner);
	elseif (cmd == "record") then
		wowChess_DisplayRecord();		
	elseif (cmd == "skin") then
		
		local oldPiecesPath = wowChess_piecesPath;
		wowChess_piecesPath = 'Interface\\\AddOns\\\wowChess\\\Skins\\'..SubCmd..'\\';
		
		if (getglobal("ChessButton1Background"):SetTexture(wowChess_piecesPath.."wowChess_td")) then
			wowChess_skinSounds = {};
			wowChess_UpdateBoard();
			wowChess_drawSpaces();
		else
			wowChess_piecesPath = oldPiecesPath;
			wowChess_msg(wowChess_STR_SkinNotFound..SubCmd);
		end
		
	elseif (cmd == "load") then
		wowChess_RestoreGame(SubCmd);
		
	elseif (cmd == "copy") then
		if (SubCmd~=nil and SubCmd~="") then
			local from, to = wowChess_GetCmd(SubCmd);
			wowChess_CopySavedGame(from, to);
		end
		
	elseif (cmd == "mute") then
		wowChess_ToggleMute();
		
	elseif (cmd == "scale") then
		wowChess_msg(wowChess_STR_SetScale..SubCmd);
		wowChess_SetScale(SubCmd);
		
	elseif (cmd == "rotate") then
		wowChess_RotateBoard();
		
	elseif (cmd == "debug") then
		debugging = 1;
		
	elseif (cmd == "reset") then
		wowChess_ResetBoard();
		
	else
		wowChess_displayHelp();
	end
end

function wowChess_DisplayRecord()
	wowChess_msg(wowChess_STR_TotalWDL..wowChess_Totals[1].."/"..wowChess_Totals[2].."/"..wowChess_Totals[3]);
end

function wowChess_RotateBoard()
	--Toggle isRotated value
	if (isRotated) then
		isRotated = nil;
	else
		isRotated = 1;
	end
	
	--If its newly rotated then
	if (isRotated) then
		wowChessBarBlack:ClearAllPoints();
		wowChessBarBlack:SetPoint("BOTTOM", "wowChess");
		wowChessBarWhite:ClearAllPoints();
		wowChessBarWhite:SetPoint("TOP", "wowChess");
	else
		wowChessBarBlack:ClearAllPoints();
		wowChessBarBlack:SetPoint("TOP", "wowChess");
		wowChessBarWhite:ClearAllPoints();
		wowChessBarWhite:SetPoint("BOTTOM", "wowChess");
	
	end
	wowChess_HilightLast();
	wowChess_ResetHilights();
	wowChess_UpdateBoard();
	wowChess_drawSpaces();
end

function wowChess_ToggleMute()
	if (wowChess_isMuted) then
		wowChess_msg(wowChess_STR_Unmuted);
		wowChess_isMuted = nil;
	else
		wowChess_msg(wowChess_STR_Muted);
		wowChess_isMuted = 1;
	end
end

function wowChess_SetScale(scale)
	if (type(tonumber(scale))=="number") then
		wowChess:SetScale(scale);
		wowChess_scale = scale;
	end
end

function wowChess_ToggleBoard()
	   if (wowChessWinVisible == 1) then
		wowChessWinVisible = 0;
		wowChess:Hide();
	   else
		wowChessWinVisible = 1;
		wowChess:Show();
	   end
end

function wowChess_TogglePlayerBars(parent)

	if (wowChessBarWhite:IsVisible()) then
		--Hide
		wowChessBarWhite:Hide();
		wowChessBarBlack:Hide();
		getglobal("PlayerBarToggleBlackArrow"):SetTexture("Interface\\AddOns\\wowChess\\Images\\wowChessArrowRight");
		getglobal("PlayerBarToggleWhiteArrow"):SetTexture("Interface\\AddOns\\wowChess\\Images\\wowChessArrowRight");
		wowChess:SetHeight(348);
	else
		--Show
		wowChessBarWhite:Show();
		wowChessBarBlack:Show();
		getglobal("PlayerBarToggleBlackArrow"):SetTexture("Interface\\AddOns\\wowChess\\Images\\wowChessArrowUp");
		getglobal("PlayerBarToggleWhiteArrow"):SetTexture("Interface\\AddOns\\wowChess\\Images\\wowChessArrowDown");
		wowChess:SetHeight(452);
	end


end


-- handles joining channel and fading
function wowChess_OnUpdate(elapsed)
	wowChess.TimeSinceLastUpdate = wowChess.TimeSinceLastUpdate + elapsed; 	
	if (wowChess.TimeSinceLastUpdate > 0.01) then
		
		if (not waitingForAck) then
		
			if (animate["frame"] ~= 0) then
	
				local tp = getglobal("ChessButton"..animate["topiece"].."Piece");
				local fp = getglobal("ChessButton"..animate["frompiece"].."Piece");

				if (animate["frame"]==1) then
					wowChess_PlaySoundEffect(wcBoard[animate["from"]], "down");	
					local oldx, oldy = fp:GetCenter();
					animate["oldx"] = oldx;
					animate["oldy"] = oldy;	
					wowChess_ResetLast();
				end

				local tox, toy = tp:GetCenter();
				local newx = ((tox - animate["oldx"]) / 15)*(animate["frame"]);
				local newy = ((toy - animate["oldy"]) / 15)*(animate["frame"]);
				fp:ClearAllPoints();
				fp:SetPoint("CENTER", "ChessButton"..animate["frompiece"], "CENTER", newx, newy);
				animate["frame"] = animate["frame"] + 1;
				if (animate["frame"]==16) then
					animate["frame"] = 0;
					fp:ClearAllPoints();
					fp:SetPoint("CENTER", "ChessButton"..animate["frompiece"], "CENTER", 0, 0);
					tp:SetTexture(fp:GetTexture());
					fp:SetTexture("");

					local start,stop,fromPiece,fromColor = string.find(wcBoard[animate["from"]], '([prnbkq])([ld])');
					wcBoard[animate["to"]] = wcBoard[animate["from"]];
					wcBoard[animate["from"]] = "";
					
					wowChess_AddMoveToLog(animate["move"]);

					--Add time to clock for move
					if (wowChess_isBlack==0) then
						playClocks[2] = playClocks[2] - timeMoveBonus;
					else
						playClocks[1] = playClocks[1] - timeMoveBonus;					
					end
					
					wowChess_SetClock("wowChessWhiteClock", playClocks[1]);
					wowChess_SetClock("wowChessBlackClock", playClocks[2]);
			
					lastMove = { "", "" };
					if (isRotated) then
						lastMove = { 65-tonumber(animate["frompiece"]), 65-tonumber(animate["topiece"]) }
					else
						lastMove = { animate["frompiece"], animate["topiece"] }
					end

					wowChess_HilightLast();
					wowChess_UpdateBoard();

					local whiteInCheck, blackInCheck = wowChess_checkCheck();
					
					local oppCheck, oppColor;
					if (fromColor == "l") then
						oppCheck = blackInCheck;
						oppColor = "d";
					else
						oppCheck = whiteInCheck;
						oppColor = "l";
					end

					--If this puts opponent in check, see if its checkmate, else check for stalemate
					if (oppCheck) then
						wowChess_checkCheckmate(fromColor);
					else
						wowChess_checkStalemate(fromColor);
					end
				end
			end
		
			--Do the animation for a rook if castling
			if (rookanimate["frame"] ~= 0) then
					
				local tp = getglobal(rookanimate["topiece"].."Piece");
				local fp = getglobal(rookanimate["frompiece"].."Piece");

				if (rookanimate["frame"]==1) then
				
					wcBoard[rookanimate["to"]] = wcBoard[rookanimate["from"]];
					wcBoard[rookanimate["from"]] = "";
					
					local oldx, oldy = fp:GetCenter();
					rookanimate["oldx"] = oldx;
					rookanimate["oldy"] = oldy;
				end

				local tox, toy = tp:GetCenter();
				local newx = ((tox - rookanimate["oldx"]) / 15)*(rookanimate["frame"]);
				local newy = ((toy - rookanimate["oldy"]) / 15)*(rookanimate["frame"]);
				fp:ClearAllPoints();
				fp:SetPoint("CENTER", rookanimate["frompiece"], "CENTER", newx, newy);
				rookanimate["frame"] = rookanimate["frame"] + 1;
				if (rookanimate["frame"]==16) then
					rookanimate["frame"] = 0;
					fp:ClearAllPoints();
					fp:SetPoint("CENTER", rookanimate["frompiece"], "CENTER", 0, 0);
					tp:SetTexture(fp:GetTexture());
					fp:SetTexture("");
					wowChess_UpdateBoard();
				end
			end
		end
		
		if (MouseIsOver(wowChess) or MouseIsOver(wowChessSideBar) or MouseIsOver(wowChessTitleBar)) then
			if (wowChess.isFaded == 1) then
				UIFrameFadeRemoveFrame(wowChess);
				UIFrameFlashRemoveFrame(wowChess);
				UIFrameFadeIn(wowChess, 0.2, 0.25, 1);
				wowChess.isFaded = 0;
			end
		else
			if (wowChess.isFaded == 0) then
				UIFrameFadeRemoveFrame(wowChess);
				UIFrameFlashRemoveFrame(wowChess);
				UIFrameFadeOut(wowChess, 0.2, 1, 0.25);
				wowChess.isFaded = 1;
			end
		end
		
		wowChess_UpdateClocks();
		
		wowChess.TimeSinceLastUpdate = 0;
	end
end

function wowChess_UpdateClocks()
	if ( clockRunning and ((GetTime()-lastClockUpdate) > 1) ) then
		if (mod(wowChess_gameMoveCount,2)==0) then
			playClocks[2] = playClocks[2] + 1;
		else
			playClocks[1] = playClocks[1] + 1;
		end

		wowChess_SetClock("wowChessWhiteClock", playClocks[1]);
		wowChess_SetClock("wowChessBlackClock", playClocks[2]);
		
		lastClockUpdate = GetTime();
	end
end

function wowChess_SetClock(clockText, secondsPlayed)
	
	local neg = "";
	if (secondsPlayed > timeLimit) then
		if (timeLimit~=0) then
		--Game time has expired
			secondsPlayed = abs(timeLimit - secondsPlayed);
			neg = "-";
		end
	else
		--Game time hasnt expired
		secondsPlayed = abs(timeLimit - secondsPlayed);
	end

	local minutesPlayed = 0;
	while (secondsPlayed >= 60) do
		secondsPlayed = secondsPlayed - 60;
		minutesPlayed = minutesPlayed + 1;
	end

	if (secondsPlayed < 10) then
		secondsPlayed = "0"..secondsPlayed;
	end
	getglobal(clockText):SetText(neg..minutesPlayed..":"..secondsPlayed);
end

function wowChess_ToggleMoveLog()
	if (wowChessSideBar:IsVisible()) then
		wowChessSideBar:Hide();
		MoveLogToggleArrow:SetTexCoord(0,1 , 0,1);
	else
		wowChessSideBar:Show();
		MoveLogToggleArrow:SetTexCoord(1,0 , 0,1);
	end
end

function wowChessMoveLogScrollBar_Update()
	local line; -- 1 through 5 of our window to scroll
	local maxlist = 20; --Max number of entries to display at a time
	local lineplusoffset; -- an index into our data calculated from the scroll offset
	FauxScrollFrame_Update(wowChessMoveLogScrollBar,wowChess_MoveLogLength,maxlist,16);
	for line=1,maxlist do
		lineplusoffset = line + FauxScrollFrame_GetOffset(wowChessMoveLogScrollBar);
		if (lineplusoffset <= wowChess_MoveLogLength) then
			local sname = wowChess_MoveLog[lineplusoffset];
			getglobal("wowChessMoveLogEntry"..line.."_Text"):SetText(sname);
			getglobal("wowChessMoveLogEntry"..line):Show();
		else
			getglobal("wowChessMoveLogEntry"..line):Hide();
		end
	end
end

function wowChess_MoveLogSetFont()
	local font = "Interface\\AddOns\\wowChess\\Images\\VeraMono.ttf";
	for i=1,20 do
		getglobal("wowChessMoveLogEntry"..i.."_Text"):SetFont(font, 12, "");
	end
end

function wowChess_AddMoveToLog(move)
	local overTenSpace = " ";
	if (mod(wowChess_gameMoveCount,2)==0) then
		--White's turn	
		wowChess_MoveLogLength = wowChess_MoveLogLength + 1;
		if (wowChess_MoveLogLength > 9) then
			overTenSpace = "";
		end
		wowChess_MoveLog[wowChess_MoveLogLength] = wowChess_MoveLogLength..". "..overTenSpace..move.."  ";
	else
		--Black's turn
		wowChess_MoveLog[wowChess_MoveLogLength] = wowChess_MoveLog[wowChess_MoveLogLength]..move;
	end
	wowChessMoveLogScrollBar_Update();
end

--Called after the addon has loaded and restored saved vars
function wowChess_OnEvent()
	if ((event == "ADDON_LOADED") and (arg1 == "wowChess")) then
		wowChess_SetScale(wowChess_scale);
		wowChess_drawSpaces();
		if (wowChessWinVisible == 1) then
			wowChess:Show()
			wowChessMoveLogScrollBar_Update();
		else
			wowChess:Hide()
		end
	end
end

--From wowwiki HOWTO by Tigerheart
 function wowChess_GetCmd(msg)
 	if msg then
 		local a,b,c=strfind(msg, "(%S+)"); --contiguous string of non-space characters
 		if a then
 			return c, strsub(msg, b+2);
 		else	
 			return "";
 		end
 	end
 end
 function wowChess_GetArgument(msg)
 	if msg then
 		local a,b=strfind(msg, "=");
 		if a then
 			return strsub(msg,1,a-1), strsub(msg, b+1);
 		else	
 			return "";
 		end
 	end
 end

--from telltrack
function wowChess_Capitalize(text)
	if (not text) then
		return;
	end
	if( string.find(text, "^[a-zA-Z].*") ) then
		text = strupper(strsub(text,1,1))..strlower(strsub(text,2));
	else
		text = strupper(strsub(text,1,2))..strlower(strsub(text,3));
	end
	return text;
end

--Copies a table
function wowChess_tcopy(to, from)
   for k,v in pairs(from) do
     if(type(v)=="table") then
       to[k] = {}
       wowChess_tcopy(to[k], v);
     else
       to[k] = v;
     end
   end
 end

function wowChess_msg(msg)
	ChatFrame1:AddMessage(msg, 1.0, 1.0, 0.0);
end 
 
-- The below functions are for debugging

function wowChess_DBPrintBoard()
	local msg = "";
	for y=0,7 do
		for x=1,8 do
			local i = x+(8*y);
			local sp = idGrid[i];
			local piece = wcBoard[sp];
			if (piece == "") then
				piece = "    ";
			end
			msg = msg..sp.."="..piece.."    ";
		end
		wowChess_msg(msg);
		msg = "";
	end
end

function wowChess_Debug(command, player)
	wowChess_CommandHandler(command, player);
end

--[[
function wcsetup()
	blackCanCastleRight = nil;
	blackCanCastleLeft = nil;
	wcBoard = {
		a8="",   b8="",   c8="",   d8="",   e8="",   f8="",   g8="kd",   h8="",   
		a7="",   b7="",   c7="",   d7="rl",   e7="",   f7="",   g7="",   h7="",   
		a6="",   b6="",   c6="",   d6="",   e6="",   f6="",   g6="",   h6="",   
		a5="",   b5="",   c5="",   d5="",   e5="",   f5="ql",   g5="",   h5="",   
		a4="",   b4="",   c4="",   d4="",   e4="",   f4="",   g4="",   h4="",   
		a3="",   b3="kl",   c3="",   d3="",   e3="",   f3="",   g3="",   h3="", 
		a2="",   b2="",   c2="",   d2="",   e2="",   f2="",   g2="",   h2="",   
		a1="",   b1="",   c1="",   d1="",   e1="",   f1="",   g1="",   h1="",  	
	}
	wowChess_UpdateBoard();
end

function wcm(str)
	wowChess_Debug(str,"Smitty");
end

--]]--