-- Functions specific to the individual totem timers
--
--

local Dragging = 0;

function TotemTimer_OnUpdate(arg1)
	if( this.element ) then
		local data = TTActiveTotems[this.element];
		if ( data and data.active ) then
			if ( data.duration < 0 ) then
				TotemTimers_TotemDeath(data.totem);
			else
				data.duration = data.duration - arg1;
				getglobal(this:GetName().."Time"):SetText(TotemTimer_FormatTime(data.duration));
				if( TTData.Totems[data.totem] ) then
					if( data.warningTime ) then
						if ( data.duration <= data.warningTime ) then
							data.warningTime = nil;
							TotemTimers_TotemWarn(data.totem);
						end
					end
				end
				if( data.duration <= 60 ) then
					getglobal(this:GetName().."Time"):SetTextColor(1.0,1.0,1.0);
				else
					getglobal(this:GetName().."Time"):SetTextColor(1.0,.8,0);
				end
				if( data.duration <= TTData.flash ) then
					data.flashTime = data.flashTime - arg1;
					if ( data.flashTime < 0 ) then
						if ( data.flashState == 1 ) then
							data.flashState = 0;
							data.flashTime = BUFF_FLASH_TIME_OFF;
						else
							data.flashState = 1;
							data.flashTime = BUFF_FLASH_TIME_ON;
						end
					end
					if ( data.flashState == 1 ) then
						totemAlphaValue = (BUFF_FLASH_TIME_ON - data.flashTime) / BUFF_FLASH_TIME_ON;
						totemAlphaValue = totemAlphaValue * (1 - BUFF_MIN_ALPHA) + BUFF_MIN_ALPHA
					else
						totemAlphaValue = data.flashTime / BUFF_FLASH_TIME_ON;
						totemAlphaValue = (data.flashTime * (1 - BUFF_MIN_ALPHA)) + BUFF_MIN_ALPHA;
						getglobal(this:GetName().."Icon"):SetAlpha(data.flashTime / BUFF_FLASH_TIME_ON);
					end
					getglobal(this:GetName().."Icon"):SetAlpha(totemAlphaValue);
				end
			end
		end
	end
end

function TotemTimer_ReCast()
	if( TTData.lock == 1 ) then
		local data = TTActiveTotems[this.element];
		--DEFAULT_CHAT_FRAME:AddMessage(TTActiveTotems[this.element]);
		--DEFAULT_CHAT_FRAME:AddMessage(data);
		if( data ) then
			if( data["action"] ) then
				UseAction(data["action"], data["number"], data["target"]);
			elseif( data["spell"] ) then
				CastSpell(data["spell"], data["book"]);
			elseif ( data["Slot_Id"] ) then
				--DEFAULT_CHAT_FRAME:AddMessage(data["Slot_Id"])
				UseInventoryItem( data["Slot_Id"] );
			end
		end
	end
end

function TotemTimer_OnDragStart()
	if( TTData.lock ~= 1 ) then
		TotemTimersFrame:StartMoving();
	end
end

function TotemTimer_OnDragStop()
	TotemTimersFrame:StopMovingOrSizing();
end

function TotemTimer_OnEnter()
	local data = TTActiveTotems[this.element];
	if( data ) then
		if ( this:GetCenter() < UIParent:GetCenter() ) then
			GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
		else
			GameTooltip:SetOwner(this, "ANCHOR_LEFT");
		end
		if( data["action"] ) then
			GameTooltip:SetAction(data["action"]);
		elseif( data["spell"] ) then
			GameTooltip:SetSpell(data["spell"], data["book"]);
		elseif( data["Slot_Id"] ) then
			GameTooltip:SetInventoryItem("player", data["Slot_Id"]);
		end
	end
end

function TotemTimer_OnLoad()
	this:RegisterForClicks("LeftButtonUp","RightButtonUp");
end

-- Functions ripped from TotemTimer
function TotemTimer_FormatTime(seconds)
  local d, h, m, s;
  local text;

 	if( TTData[TT_TIME] == TT_BLIZZARD ) then
		if(seconds <= 0) then
			text = "";
		elseif(seconds < 60) then
			d, h, m, s = ChatFrame_TimeBreakDown(seconds);
			text = format("%d s", s);
		elseif(seconds < 3600) then
			d, h, m, s = ChatFrame_TimeBreakDown(seconds);
			text = format("%d m", m);
		else
			text = "1 hr+";
		end
	else
		if(seconds <= 0) then
			text = "";
		elseif(seconds < 3600) then
			d, h, m, s = ChatFrame_TimeBreakDown(seconds);
			text = format("%02d:%02d", m, s);
		else
			text = "1 hr+";
		end
	end

  return text;
end


