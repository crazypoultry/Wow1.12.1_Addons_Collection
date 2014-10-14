
	CALC_INIT_RESULT = "0."
	CALC_SUM_AMT = "0";
	CALC_DISPLAY_DECIMAL = 0;
	CALC_DISPLAY_RESULT = 0;
	CALC_DISPLAY_PREVNUM = 0;
	CALC_DISPLAY_PREVSUM = 0;
	CALC_DISPLAY_MEMORY = 0;
	CALC_DISPLAY_OP = "";
	CALC_DISPLAY_PREV_OP = "";
	CALC_LAST_OP = "";

	function Calculator_OnLoad()
		-- DEFAULT_CHAT_FRAME:AddMessage("OnLoad");
		this:RegisterEvent("VARIABLES_LOADED");
		Calculator_ResultFrame:SetBackdropBorderColor(0.6, 0.6, 0.6);
		Calculator_ResultFrame:SetBackdropColor(0, 0, 0, 0);
		Calculator_MemoryFrame:SetBackdropBorderColor(0.6, 0.6, 0.6);
		Calculator_MemoryFrame:SetBackdropColor(0, 0, 0, 0);
	end

	function Calculator_OnEvent(event)
		-- DEFAULT_CHAT_FRAME:AddMessage("OnEvent - " .. event);
		if (event == "VARIABLES_LOADED") then
			Calculator_Init();
		end
	end

	function Calculator_StartDrag()
		-- DEFAULT_CHAT_FRAME:AddMessage("Start Drag");
		if (((not this.isLocked) or (this.isLocked == 0)) and (arg1 == "LeftButton")) then
			this:StartMoving();
			this.isMoving = true;
		end
	end

	function Calculator_StopDrag()
		-- DEFAULT_CHAT_FRAME:AddMessage("Stop Drag");
		if (this.isMoving) then
			this:StopMovingOrSizing();
			this.isMoving = false;
		end
	end

	function Calculator_Init()
		-- DEFAULT_CHAT_FRAME:AddMessage("Init");
		tinsert(UISpecialFrames,"Calculator_Frame"); -- ESC Close Frame
		SlashCmdList["CALCULATOR"] = Calculator_Cmd; -- Slash Command
		SLASH_CALCULATOR1 = "/calculator";
		SLASH_CALCULATOR2 = "/calc";
	end

	function Calculator_Cmd(cmd)
		-- DEFAULT_CHAT_FRAME:AddMessage("Cmd - " .. cmd);
		Calculator_Toggle();
	end

	function Calculator_Toggle()
		-- DEFAULT_CHAT_FRAME:AddMessage("Toggle");
		if (Calculator_Frame:IsVisible()) then
			Calculator_Frame:Hide();
		else
			Calculator_Frame:Show();
		end
	end

	function Calculator_AddDigit(digit)
		-- DEFAULT_CHAT_FRAME:AddMessage("Add Digit - " .. digit);
	 	if (CALC_DISPLAY_RESULT == 1) then
	 		CALC_DISPLAY_PREVNUM = 0;
	 		CALC_DISPLAY_PREVSUM = 0;
	 		CALC_SUM_AMT = "0";
	 	elseif (CALC_DISPLAY_RESULT == 2) then
	 		CALC_SUM_AMT = "0";
	 	end
	 	CALC_DISPLAY_RESULT = 0;
	 	if (digit == ".") and (CALC_DISPLAY_DECIMAL == 1) then
	 		return;
		end
	 	if (digit == ".") and (CALC_DISPLAY_DECIMAL == 0) then
	 		CALC_DISPLAY_DECIMAL = 1;
	 	end
	 	if (CALC_SUM_AMT == "0") and (digit == "0") then
	 		return;
	 	elseif (CALC_SUM_AMT == "0") and (digit ~= ".") then
	 		CALC_SUM_AMT = digit;
	 	else
	 		CALC_SUM_AMT = CALC_SUM_AMT..""..digit;
		end
	 	if (CALC_DISPLAY_DECIMAL == 0) then
	 		Calculator_ResultText:SetText(CALC_SUM_AMT..".");
		else
	 		Calculator_ResultText:SetText(CALC_SUM_AMT);
	 	end
	end

	function Calculator_ToggleSign()
		CALC_SUM_AMT = tostring(0 - tonumber(CALC_SUM_AMT));
		if (CALC_DISPLAY_DECIMAL == 0) then
			Calculator_ResultText:SetText(CALC_SUM_AMT..".");
		else
			Calculator_ResultText:SetText(CALC_SUM_AMT);
		end
	end

	function Calculator_RemoveDigit()
		if (CALC_DISPLAY_RESULT == 1) then
			CALC_SUM_AMT = "0";
		end
		CALC_DISPLAY_RESULT = 0;
		if (CALC_SUM_AMT == "0") then
			return;
		else
			len = strlen(CALC_SUM_AMT)-1;
			dig = strsub(CALC_SUM_AMT,len+1);
			if (len < 0) then
				len = 0;
			end
			display = strsub(CALC_SUM_AMT,0,len);

			if (dig == ".") and (CALC_DISPLAY_DECIMAL == 1) then
				CALC_DISPLAY_DECIMAL = 0;
			end
			CALC_SUM_AMT = display
			if (strlen(CALC_SUM_AMT) < 1) then
				CALC_SUM_AMT = "0";
			end
			if (CALC_DISPLAY_DECIMAL == 0) then
				Calculator_ResultText:SetText(CALC_SUM_AMT..".");
			else
				Calculator_ResultText:SetText(CALC_SUM_AMT);
			end
		end
	end

	function Calculator_SetOperation(op)
		if (CALC_DISPLAY_OP == "") or ((op ~= "=") and (CALC_DISPLAY_RESULT == 1)) then
			CALC_DISPLAY_RESULT = 0;
			CALC_DISPLAY_PREVNUM = 0;
			CALC_DISPLAY_PREVSUM = tonumber(CALC_SUM_AMT);
			CALC_DISPLAY_OP = op;
			CALC_DISPLAY_DECIMAL = 0;
			CALC_SUM_AMT = "0";
			if (CALC_DISPLAY_DECIMAL == 0) then
				Calculator_ResultText:SetText(CALC_SUM_AMT..".");
			else
				Calculator_ResultText:SetText(CALC_SUM_AMT);
			end
		else
			if (CALC_DISPLAY_PREVNUM ~= 0) and (op == "=") then
				num = tonumber(CALC_DISPLAY_PREVNUM);
			else
	  		num = tonumber(CALC_SUM_AMT);
	     	end
			if (CALC_DISPLAY_OP == "+") then
				CALC_DISPLAY_PREVSUM = CALC_DISPLAY_PREVSUM + num;
			elseif (CALC_DISPLAY_OP == "-") then
				CALC_DISPLAY_PREVSUM = CALC_DISPLAY_PREVSUM - num;
			elseif (CALC_DISPLAY_OP == "*") then
				CALC_DISPLAY_PREVSUM = CALC_DISPLAY_PREVSUM * num;
			elseif (CALC_DISPLAY_OP == "/") then
				CALC_DISPLAY_PREVSUM = CALC_DISPLAY_PREVSUM / num;
			else
				CALC_DISPLAY_PREVSUM = num;
			end
			if (op ~= "=") then
				CALC_DISPLAY_OP = op;
				CALC_DISPLAY_PREVNUM = 0;
				CALC_DISPLAY_RESULT = 2;
			else
				CALC_DISPLAY_PREVNUM = num;
				CALC_DISPLAY_RESULT = 1;
			end
			if (math.floor(CALC_DISPLAY_PREVSUM) ~= CALC_DISPLAY_PREVSUM) then
				CALC_DISPLAY_DECIMAL = 1;
			else
				CALC_DISPLAY_DECIMAL = 0;
			end
			CALC_SUM_AMT = tostring(CALC_DISPLAY_PREVSUM)
			if (CALC_DISPLAY_DECIMAL == 0) then
				Calculator_ResultText:SetText(CALC_SUM_AMT..".");
			else
				Calculator_ResultText:SetText(CALC_SUM_AMT);
			end
		end
	end

	function Calculator_SetOperation2(op)
		num = tonumber(CALC_SUM_AMT);
		if (op == "frac") then
			num = 1/num;
		elseif (op == "sqrt") then
			num = math.sqrt(num);
		elseif (op == "pct") then
			num = num/100;
		end
		if (math.floor(num) ~= num) then
			CALC_DISPLAY_DECIMAL = 1;
		else
			CALC_DISPLAY_DECIMAL = 0;
		end
		CALC_DISPLAY_PREVSUM = num;
		CALC_DISPLAY_PREVNUM = 0;
		CALC_SUM_AMT = tostring(num);
		if (CALC_DISPLAY_DECIMAL == 0) then
			Calculator_ResultText:SetText(CALC_SUM_AMT..".");
		else
			Calculator_ResultText:SetText(CALC_SUM_AMT);
		end
		CALC_DISPLAY_RESULT = 1;
	end

	function Calculator_CE()
		CALC_SUM_AMT = "0";
		CALC_DISPLAY_DECIMAL = 0;
		if (CALC_DISPLAY_DECIMAL == 0) then
			Calculator_ResultText:SetText(CALC_SUM_AMT..".");
		else
			Calculator_ResultText:SetText(CALC_SUM_AMT);
		end
	end

	function Calculator_C()
		CALC_SUM_AMT = "0";
		CALC_DISPLAY_DECIMAL = 0;
		CALC_DISPLAY_OP = "";
		CALC_DISPLAY_PREVSUM = 0;
		CALC_DISPLAY_PREVNUM = 0;
		CALC_DISPLAY_RESULT = 0;
		if (CALC_DISPLAY_DECIMAL == 0) then
			Calculator_ResultText:SetText(CALC_SUM_AMT..".");
		else
			Calculator_ResultText:SetText(CALC_SUM_AMT);
		end
	end

	function Calculator_MS()
	   	Calculator_MemoryText:SetText("M");
		CALC_DISPLAY_MEMORY = tonumber(CALC_SUM_AMT);
		CALC_SUM_AMT = "0";
		CALC_DISPLAY_DECIMAL = 0;
		if (CALC_DISPLAY_DECIMAL == 0) then
			Calculator_ResultText:SetText(CALC_SUM_AMT..".");
		else
			Calculator_ResultText:SetText(CALC_SUM_AMT);
		end
	end

	function Calculator_MA()
	   	Calculator_MemoryText:SetText("M");
	   	CALC_DISPLAY_MEMORY = CALC_DISPLAY_MEMORY + tonumber(CALC_SUM_AMT);
		CALC_SUM_AMT = "0";
		CALC_DISPLAY_DECIMAL = 0;
		if (CALC_DISPLAY_DECIMAL == 0) then
			Calculator_ResultText:SetText(CALC_SUM_AMT..".");
		else
			Calculator_ResultText:SetText(CALC_SUM_AMT);
		end
	end

	function Calculator_MR()
		if (math.floor(CALC_DISPLAY_MEMORY) ~= CALC_DISPLAY_MEMORY) then
			CALC_DISPLAY_DECIMAL = 1;
		else
			CALC_DISPLAY_DECIMAL = 0;
		end
		CALC_SUM_AMT = tostring(CALC_DISPLAY_MEMORY);
		if (CALC_DISPLAY_DECIMAL == 0) then
			Calculator_ResultText:SetText(CALC_SUM_AMT..".");
		else
			Calculator_ResultText:SetText(CALC_SUM_AMT);
		end
	end

	function Calculator_MC()
		Calculator_MemoryText:SetText(" ");
		CALC_DISPLAY_MEMORY=0;
	end