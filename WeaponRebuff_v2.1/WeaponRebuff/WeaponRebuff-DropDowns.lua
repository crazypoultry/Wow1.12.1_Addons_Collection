--[[ DropDowns -------------------------------------------------------------- ]]
local T = AceLibrary("AceLocale-2.0"):new("WeaponRebuff")
local compost = AceLibrary("Compost-2.0")

function WeaponRebuff:DropDown_Init(slot, source)
	if source == "wr" then
		-- Coming from WeaponRebuff
		newDropdown:Show();
		self:DropDownMenu_ClearButtons();
	elseif source == "twr" then
		-- Coming from TitanWeaponRebuff
	  -- (do nothing)
	else
	  return;
	end
		
	
--	local info -- = compost:Acquire()
	local chargeNames = T:GetTable("chargeNames");
	local spellNames  = T:GetTable("spellNames");
	-- adding charges
	for i=1, table.getn(chargeNames), 1 do
	
		local _,_,count = self:GetBagInfo(chargeNames[i]);
		if ( count > 0 ) then
		
			-- It doens't like RecycleHash here...
			info = compost:AcquireHash(
      	'text'     , count.."x "..chargeNames[i],
        'buff'     , chargeNames[i],
        'invslot'  , slot,
        'bufftype' , 1
			)

			if source == "wr" then
				self:DropDownMenu_AddButton(info);
			elseif source == "twr" then
				TitanDropDownMenu_AddButton(info)
			end
			
			compost:Reclaim(info)
			
		end
	end
	--adding spells
	for i=1, table.getn(spellNames), 1 do
		if ( self:GetSpellId(spellNames[i]) > 0) then
			info = compost:AcquireHash(
				'text',      spellNames[i],
        'buff',      spellNames[i],
				'invslot',   slot,
        'bufftype',  2
      )
			if source == "wr" then
				self:DropDownMenu_AddButton(info);
			elseif source == "twr" then
				TitanDropDownMenu_AddButton(info)
			end
			
			compost:Reclaim(info)
			
		end
	end
	
	
	if source == "wr" then
		self:DropDownMenu_Resize()

		self:ReposFrame_OnScreen(newDropdown)

	end;
end

function WeaponRebuff:ReposFrame_OnScreen(frame)
	local points = {}
	for i=1, frame:GetNumPoints() do
		local p1, pr, p2, x, y = frame:GetPoint(i)
		points[i] = {p1, pr, p2, x, y}	
	end
	
	local width, height = GetScreenWidth(), GetScreenHeight()
	local left, right, top, bottom = frame:GetLeft(), frame:GetRight(), frame:GetTop(), frame:GetBottom()
	local sx, sy, screenBottom = 0, 0, 0

	if left < 0 then 
		sx = sx - left 
	end
	
	if right > width then 
		sx = (sx - right) + width 
	end
	
	if bottom < screenBottom then 
		sy = (sy - bottom) + screenBottom 
	end
	
	if top > height then 
		sy = (sy - top) + height 
	end

	if (width / height) > 2.4 then
		local center = width / 2
		if (left < center) and (right > center) then
			if (center - left) > (right - center) then
				sx = sx - right + center
			else sx = sx - left + center end
		end
	end
	
	frame:ClearAllPoints()
	for i, v in pairs(points) do 
		frame:SetPoint(v[1], v[2], v[3], v[4] + sx, v[5] + sy) 
	end

end


function TitanDropDownMenu_AddButton(info)
  -- *really* need to move this into the Twr plugin
	if info.invslot == 16 then
		info.func = TitanWeaponRebuff_SelectBuff_MainHand;
	elseif info.invslot == 17 then
		info.func = TitanWeaponRebuff_SelectBuff_OffHand;
	end
	
	UIDropDownMenu_AddButton(info, 2);
end

function WeaponRebuff:DropDownMenu_AddButton(info)
	for i=1, 12, 1 do
		local button = getglobal("WeaponRebuffDropdownButton"..i);
		if ( not button:IsVisible() ) then
			button:SetText(info.text);
			button.buff 		= info.buff;
			button.bufftype = info.bufftype;
			button.invslot 	= info.invslot;
			button:Show();
			return;
		end
	end
end

function WeaponRebuff:DropDownMenu_ClearButtons()
	for i=1, 12, 1 do
		local button = getglobal("WeaponRebuffDropdownButton"..i);
		button:Hide();
	end
end

function WeaponRebuff:DropDownMenu_Resize()
	if ( not WeaponRebuffDropdownButton1:IsVisible() ) then
		newDropdown:Hide();
		return
	end

	local width = 0;
	local count = 0;
	for i = 1, 12, 1 do
		local button = getglobal("WeaponRebuffDropdownButton"..i);
		if ( button:IsVisible() ) then
			count = count + 1;
            local iwidth = button:GetTextWidth();
            if (iwidth > width) then
                width = iwidth;
            end
        end
	end
	for i = 1, count, 1 do
		local button = getglobal("WeaponRebuffDropdownButton"..i);
		button:SetWidth(width);
	end
	
	newDropdown:SetWidth(width+20);
	
	local height = 0;
	for i = 1, count, 1 do
		local button = getglobal("WeaponRebuffDropdownButton"..i);
		if ( button:IsVisible() ) then
            local iheight = button:GetHeight();
            height = height + iheight;
        end
	end
	
	newDropdown:SetHeight(height+18);
end

function WeaponRebuff:ShowDropdown(frameName)
	-- this will nix the dropdown after a time if not selected
	wrKillDropdown = self:ScheduleEvent(WeaponRebuff.KillDropdown, 6, self)
	
  newDropdown:ClearAllPoints();
	newDropdown:SetPoint("TOPLEFT", frameName, "TOPRIGHT", 0, 5);
		
	self:DropDown_Init(getglobal(frameName):GetID(), "wr");
end

function WeaponRebuff:KillDropdown()
	newDropdown:Hide();
end	

function WeaponRebuff:DropDownMenu_OnClick(invSlot)
	self:Apply(this.buff, this.bufftype, this.invslot);
	self:SaveVariables();
end
--[[ End DropDowns -------------------------------------------------------------- ]]