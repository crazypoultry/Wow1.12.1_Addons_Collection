function TinyClock_ChooseTexture(obj,id,flipX,flipY)
  local idX, idY, x, y, size;
  idX = mod(id,4);
  idY = floor(id/4);
  size = (240/256)/4;
  x = size*idX;
  y = size*idY;
  if (not flipX and not flipY) then
  	obj:SetTexCoord(x,x+size,y,y+size);
  elseif (flipX and not flipY) then
  	obj:SetTexCoord(x+size,x,y,y+size);
  elseif (not flipX and flipY) then
  	obj:SetTexCoord(x,x+size,y+size,y);
  else
  	obj:SetTexCoord(x+size,x,y+size,y);
  end
end

function TinyClock_DrawHand(obj,count)
	local c,x,y;
	c = mod(floor(count),60);
	if (c>=0 and c<=15) then
		TinyClock_ChooseTexture(obj,c,false,false);
	elseif (c>=16 and c<=30) then
		TinyClock_ChooseTexture(obj,30-c,false,true);
	elseif (c>=31 and c<=45) then
		TinyClock_ChooseTexture(obj,c-30,true,true);
	elseif (c>=31 and c<=59) then
		TinyClock_ChooseTexture(obj,60-c,true,false);
	end
end

function TinyClock_Update(arg1)
	TinyClockFrame.Count = TinyClockFrame.Count + arg1;
	if (TinyClockFrame.Count < TinyClockFrame.UpdateRate) then return; end
	TinyClockFrame.Count = 0;
	local now = date("*t");
	TinyClock_DrawHand(TinyClockHourHand,(now["hour"]*5)+(now["min"]/12));
	TinyClock_DrawHand(TinyClockMinuteHand,now["min"]);
	if TinyClockConfig["showSeconds"] then TinyClock_DrawHand(TinyClockSecondHand,now["sec"]); end
end

function TinyClock_UpdateConfig()
	if TinyClockConfig["showSeconds"] then
		TinyClockFrame.UpdateRate = 1;
		TinyClockSecondHand:Show();
	else
		TinyClockFrame.UpdateRate = 5;
		TinyClockSecondHand:Hide();
	end
end

function TinyClock_Cmd(arg)
	local info = ChatTypeInfo["SYSTEM"];
  if (arg == "seconds") then
  	TinyClockConfig["showSeconds"] = not TinyClockConfig["showSeconds"];
  	TinyClock_UpdateConfig();
		DEFAULT_CHAT_FRAME:AddMessage("Seconds are "..(TinyClockConfig["showSeconds"] and "enabled" or "disabled"), info.r, info.g, info.b, info.id);
	else
	  DEFAULT_CHAT_FRAME:AddMessage("tinyClock help:", info.r, info.g, info.b, info.id);
	  DEFAULT_CHAT_FRAME:AddMessage("- '/tinyclock seconds' to toggle second hand", info.r, info.g, info.b, info.id);
	end
end

function TinyClock_Event(event)
	if (event == "VARIABLES_LOADED") then
		TinyClock_UpdateConfig();
	end
end

function TinyClock_Load()
  TinyClockFrame:RegisterEvent("VARIABLES_LOADED");
	if (TinyClockConfig == nil) then
	  TinyClockConfig = {};
	  TinyClockConfig["showSeconds"] = true;
	end
	TinyClock_UpdateConfig();
	TinyClockFrame.UpdateRate = 1;
  TinyClockFrame.Count = 0;
  GameTimeTexture:SetVertexColor(0.3,0.3,0.3);
  TinyClockSecondHand:SetVertexColor(0.4,0.4,0.4);
  TinyClock_Update(TinyClockFrame.UpdateRate);
  SLASH_TINYCLOCK1 = "/tinyclock";
  SlashCmdList["TINYCLOCK"] = TinyClock_Cmd; 
	local info = ChatTypeInfo["SYSTEM"];
  DEFAULT_CHAT_FRAME:AddMessage("Type '/tinyclock help' for help with tinyClock.", info.r, info.g, info.b, info.id);
end
