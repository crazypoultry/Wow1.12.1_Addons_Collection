OneRaid.Group = { frames = {} };

function OneRaid.Group:OnLoad()
	
	this:RegisterForDrag("LeftButton");
	
end

function OneRaid.Group:OnEvent()

	if (type(self[event] == "function") and self[event]) then
        self[event](self);
    else
        self:Print("Unhandled event: " .. event, 1, 0, 0);
    end

end

function OneRaid.Group:OnMouseDown()

	local options = OneRaid_Options.Groups[this.name];
	
	local alt, shift, ctrl = IsAltKeyDown(), IsShiftKeyDown(), IsControlKeyDown();
	
	if (arg1 == "LeftButton") then
		if (OneRaid.movePlayer and OneRaid.moveKeys and
		 	OneRaid.moveKeys.alt == alt and OneRaid.moveKeys.shift == shift and OneRaid.moveKeys.ctrl == ctrl) then
			
			local group = nil;
			for i = 1, 8 do
				if (OneRaid_Options.Groups[this.name].filters.groups[i]) then
					group = i;
					break;
				end
			end
			if (group) then
				OneRaid:AddonMessage("MOVE", OneRaid.movePlayer, group);
				OneRaid.movePlayer = nil;
				OneRaid.moveKeys = nil;
			end
		elseif (not options.locked) then
			this:StartMoving();
			
			if (IsShiftKeyDown()) then
				if (not OneRaid_Options.Groups[this.name].tankMonitor and
					not OneRaid_Options.Groups[this.name].buffMonitor and
					not OneRaid_Options.Groups[this.name].debuffMonitor) then
					
					this.dragAll = 1;
					OneRaid.Group:DragAll(1);
					return;
				end
			end
			
		end
	end
	
end

function OneRaid.Group:OnMouseUp()

	if (arg1 == "LeftButton") then
		this:StopMovingOrSizing();
		this.moving = nil;
		OneRaid.Group:SnapWindow();
		OneRaid.Group:UpdatePosition(this);

		if (this.dragAll) then
			if (not OneRaid_Options.Groups[this.name].tankMonitor and
				not OneRaid_Options.Groups[this.name].buffMonitor and
				not OneRaid_Options.Groups[this.name].debuffMonitor) then
			
				this.dragAll = nil;
				OneRaid.Group:DragAll();
				return;
			end
		end
	elseif (arg1 == "RightButton") then
		OneRaid.GroupOptions:EditGroup(this.name);
	end

end

function OneRaid.Group:OnUpdate(elapsed)

	this.elapsed = this.elapsed or 0;
	
	if (this.elapsed >= .3) then
		
		for i = 1, getn(OneRaid.tanks) do
			
			local u = this.frames[OneRaid.tanks[i]][1];
			local t = this.frames[OneRaid.tanks[i]][2];
			local tt = this.frames[OneRaid.tanks[i]][3];
			
			t.unit = u.unit .. "target";
			t.name = UnitName(t.unit);
			tt.unit = u.unit .. "targettarget";
			tt.name = UnitName(tt.unit);
			
			OneRaid.Unit:UpdateTankTarget(t, u.unit, this);
			OneRaid.Unit:UpdateTankTargetTarget(tt, u.unit, this);

		end	
		
		this.elapsed = 0;
	else
		this.elapsed = this.elapsed + elapsed;
	end

end

-----------------

function OneRaid.Group:DragAll(start)

	if (start) then

		local x, y = this:GetLeft(), this:GetTop();

		if (not x or not y) then
			return;
		end

		for k, v in OneRaid.Group.frames do
			if (v ~= this and v:IsVisible() and	(
				not OneRaid_Options.Groups[v.name].tankMonitor and
				not OneRaid_Options.Groups[v.name].buffMonitor and
				not OneRaid_Options.Groups[v.name].debuffMonitor)
				--and this.name == OneRaid_Options.Groups[v.name].docked
				) then
				local oX, oY = v:GetLeft(), v:GetTop();
				if (oX and oY) then
					v:ClearAllPoints();
					v:SetPoint("TOPLEFT", this, "TOPLEFT", oX - x, oY - y);
				end
			end
		end
	else
		for k, v in OneRaid.Group.frames do
			if (v ~= this and v:IsVisible() and	(
				not OneRaid_Options.Groups[v.name].tankMonitor and
				not OneRaid_Options.Groups[v.name].buffMonitor and
				not OneRaid_Options.Groups[v.name].debuffMonitor)
				--and this.name == OneRaid_Options.Groups[v.name].docked
				) then
				local oX, oY = v:GetLeft(), v:GetTop();
				if (oX and oY) then
					v:ClearAllPoints();
					v:SetPoint("TOPLEFT", "UIParent", "BOTTOMLEFT", oX, oY);					
				end				
			end
			OneRaid.Group:UpdatePosition(v);
		end
	end

end

function OneRaid.Group:SnapWindow()

	local snap = {};

	local snapDistance = 15;
	local left 				= this:GetLeft();
	local right 			= this:GetRight();
	local top 				= this:GetTop();
	local bottom 			= this:GetBottom();
	local centerX, centerY 	= this:GetCenter();
	local height;
	local width;

	for k, v in OneRaid.Group.frames do

		if (v.name) then
			snap[v.name] = {};
			snap[v.name][1] = {};
			snap[v.name][2] = {};
			snap[v.name][3] = {};
	
			if (this ~= v and v:IsVisible()) then
	
				local fLeft 				= v:GetLeft();
				local fRight 				= v:GetRight();
				local fTop 					= v:GetTop();
				local fBottom 				= v:GetBottom();
				local fCenterX, fCenterY 	= v:GetCenter();

		        --Left dock to Right
		        if (abs(left - fRight) <= snapDistance) then
					if (abs(top - fTop) <= snapDistance) then
						snap[v.name][1].distance = abs(left - fRight);
						snap[v.name][1].side = "LRT";
		            end
					if (abs(bottom - fBottom) <= snapDistance) then
						snap[v.name][2].distance = abs(left - fRight);
						snap[v.name][2].side = "LRB";
		            end
		            if (abs(centerY - fCenterY) <= snapDistance) then
		            	snap[v.name][3].distance = abs(left - fRight);
						snap[v.name][3].side = "LRC";
					end
				end
	
		        --Right dock to Left
		        if  (abs(right - fLeft) <= snapDistance) then
		        	if (abs(top - fTop) <= snapDistance) then
		        		snap[v.name][1].distance = abs(right - fLeft);
						snap[v.name][1].side = "RLT";
		        	end
		        	if (abs(bottom - fBottom) <= snapDistance) then
		        		snap[v.name][2].distance = abs(right - fLeft);
						snap[v.name][2].side = "RLB";
		        	end
		        	if (abs(centerY - fCenterY) <= snapDistance) then
		        		snap[v.name][3].distance = abs(right - fLeft);
						snap[v.name][3].side = "RLC";
					end
		        end
	
		        --Top dock to Bottom
		        if (abs(top - fBottom) <= snapDistance) then
		        	if (abs(left - fLeft) <= snapDistance) then
		        		snap[v.name][1].distance = abs(top - fBottom);
						snap[v.name][1].side = "TBL";
		        	end
		        	if (abs(right- fRight) <= snapDistance) then
		        		snap[v.name][2].distance = abs(top - fBottom);
						snap[v.name][2].side = "TBR";
		        	end
		        	if (abs(centerX - fCenterX) <= snapDistance) then
						snap[v.name][3].distance = abs(top - fBottom);
						snap[v.name][3].side = "TBC";
					end
		        end
	
		        --Bottom dock to Top
		        if (abs(bottom - fTop) <= snapDistance) then
		        	if (abs(left - fLeft) <= snapDistance) then
		        		snap[v.name][1].distance = abs(bottom - fTop);
						snap[v.name][1].side = "BTL";
		        	end
		        	if (abs(right- fRight) <= snapDistance) then
		        		snap[v.name][2].distance = abs(bottom - fTop);
						snap[v.name][2].side = "BTR";
					end
					if (abs(centerX - fCenterX) <= snapDistance) then
						snap[v.name][3].distance = abs(bottom - fTop);
						snap[v.name][3].side = "BTC";
					end
		        end
	
		    end
		end
	end

    local distance = snapDistance;
    local nearestFrame = nil;
    local nearestSide = nil;

    for k, v in OneRaid.Group.frames do
    	for i = 1, 3 do
    		if (snap[v.name][i].distance and snap[v.name][i].distance < distance) then
    			nearestFrame = v;
    			nearestSide = i;
    			distance = snap[v.name][i].distance;
    		end
    	end
    end

    if (nearestFrame) then

		local xOffset, yOffset;
		local side = snap[nearestFrame.name][nearestSide].side;
		
		local left 				= nearestFrame:GetLeft();
		local right 			= nearestFrame:GetRight();
		local top 				= nearestFrame:GetTop();
		local bottom 			= nearestFrame:GetBottom();
		local centerX, centerY 	= nearestFrame:GetCenter();
		local width 			= this:GetWidth() - nearestFrame:GetWidth();
		local height 			= this:GetHeight() - nearestFrame:GetHeight();
		
		
		if (side == "LRT") then
			xOffset = right;
			yOffset = top;
		elseif (side == "LRB") then
			xOffset = right;
			yOffset = top + height;
		elseif (side == "RLT") then
			xOffset = left - this:GetWidth();
			yOffset = top;
		elseif (side == "RLB") then
			xOffset = left - this:GetWidth();
			yOffset = top + height;
		elseif (side == "TBL") then
			xOffset = left;
			yOffset = bottom;
		elseif (side == "TBR") then
			xOffset = left - width;
			yOffset = bottom;
		elseif (side == "BTL") then
			xOffset = left;
			yOffset = top + this:GetHeight();
		elseif (side == "BTR") then
			xOffset = left - width;
			yOffset = top + this:GetHeight();
		elseif (side == "BTC") then
			xOffset = centerX - (this:GetWidth() / 2);
			yOffset = top + this:GetHeight();
		elseif (side == "TBC") then
			xOffset = centerX - (this:GetWidth() / 2);
			yOffset = bottom;
		elseif (side == "LRC") then
			xOffset = right;
			yOffset = centerY + (this:GetHeight() / 2);
		elseif (side == "RLC") then
			xOffset = left - this:GetWidth();
			yOffset = centerY + (this:GetHeight() / 2);
		end

		this:ClearAllPoints();
		this:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", xOffset, yOffset);

    end

end

function OneRaid.Group:RegisterEvents(frame)

	frame:RegisterEvent("UNIT_HEALTH");
	frame:RegisterEvent("UNIT_HEALTHMAX");
	frame:RegisterEvent("UNIT_AURA");

end

function OneRaid.Group:UnregisterEvents(frame)

	frame:UnregisterEvent("UNIT_HEALTH");
	frame:UnregisterEvent("UNIT_HEALTHMAX");
	frame:UnregisterEvent("UNIT_AURA");

end

function OneRaid.Group:LoadFrames()

	for k, v in OneRaid_Options.Groups do
		if (not getglobal("OneRaid_Group_" .. v.name)) then
			self:CreateFrame(v.name, v.style);
		end
	end

end

function OneRaid.Group:DeactivateFrame(name)

	local f = getglobal("OneRaid_Group_" .. name);
	
	if (not f) then return; end
	
	for k, v in f.frames do
		OneRaid.Unit:DeactivateFrame(v);
	end
	
	self:UnregisterEvents(f);
	
	f.inactive = 1;
	
	f:Hide();

end

function OneRaid.Group:DeactivateTankMonitorFrame(name)

	local f = getglobal("OneRaid_Group_" .. name);
	
	if (not f) then return; end
	
	for k, v in f.frames do
		OneRaid.Unit:DeactivateFrame(v[1]);
		OneRaid.Unit:DeactivateFrame(v[2]);
		OneRaid.Unit:DeactivateFrame(v[3]);
	end
	
	f:SetScript("OnUpdate", nil);
	
	self:UnregisterEvents(f);
	
	f.inactive = 1;
	
	f:Hide();

end

function OneRaid.Group:CreateFrame(name, style)

	if (not OneRaid_Options.UnitStyles[style]) then
		style = "Default";
	end
	
	local f = getglobal("OneRaid_Group_" .. name);
	
	if (not f) then
		f = CreateFrame("Frame", "OneRaid_Group_" .. name, UIParent, "OneRaid_Group_Template");
		tinsert(self.frames, f);
	else
		f.inactive = nil;		
	end
	
	f.name = name;
	f.style = style;
	f.unitBuffs = {};
	f.unitDebuffs = {};
	f.frames = {};
	f.updatedBuffs = nil;
	
	self:LoadFrame(f);
	
	if (OneRaid_Options.Groups[name].tankMonitor) then
		
		local tanks = {};
		for k, v in pairs(OneRaid.tanks) do
			if (OneRaid:GetUnit(v)) then
				tinsert(tanks, v);
			end
		end
		OneRaid.tanks = tanks;
		
		self:CreateTankMonitorFrame(f);
	
	else
		self:RegisterEvents(f);		
		self:Filter(f);			
	end
	
	return f;

end

function OneRaid.Group:CreateTankMonitorFrame(f)

	local style = OneRaid_Options.UnitStyles[f.style];
	local options = OneRaid_Options.Groups[f.name];
	
	f.targets = {};
	f.units = {};
	
	for i = 1, getn(OneRaid.tanks) do
		local unit = OneRaid:GetUnit(OneRaid.tanks[i]);
		local target = unit .. "target";
		local targettarget = target .. "target";
		local hide2, hide3;
		
		tinsert(f.units, unit);
		
		if (not UnitExists(target)) then target = unit; hide2 = 1; end
		if (not UnitExists(targettarget)) then targettarget = unit; hide3 = 1; end
		
		u 	= OneRaid.Unit:CreateFrame(unit, f, f.style);
		t 	= OneRaid.Unit:CreateFrame(target, f, f.style, 1);
		tt 	= OneRaid.Unit:CreateFrame(targettarget, f, f.style, 2);
		
		if (style.backgroundType == 7 and UnitName(unit) == OneRaid.mainAssist) then
			u:SetBackdropColor(style.maColor.r, style.maColor.g, style.maColor.b, style.maColor.a);
		end
		
		t.warned = nil;
		tt.warned = nil;
		tt.tanked = nil;
		
		if (hide2) then t:Hide(); end
		if (hide3 or not style.showTargetsTarget) then tt:Hide(); end
		
		u:ClearAllPoints();
		t:ClearAllPoints();
		tt:ClearAllPoints();
		
		if (OneRaid_Options.Groups[f.name].horizontal) then
		
			if (i == 1) then
				u:SetPoint("TOPLEFT", f, "TOPLEFT", 0, -14);				
			else
				u:SetPoint("TOPLEFT", f.frames[OneRaid.tanks[i - 1]][1], "TOPRIGHT", 0, 0);
			end
			
			t:SetPoint("TOPLEFT", u, "BOTTOMLEFT", 0, 0);
			tt:SetPoint("TOPLEFT", t, "BOTTOMLEFT", 0, 0);
			
		else
		
			if (i == 1) then
				u:SetPoint("TOPLEFT", f, "TOPLEFT", 0, -14);				
			else
				u:SetPoint("TOPLEFT", f.frames[OneRaid.tanks[i - 1]][1], "BOTTOMLEFT", 0, 0);
			end
			
			t:SetPoint("TOPLEFT", u, "TOPRIGHT", 0, 0);
			tt:SetPoint("TOPLEFT", t, "TOPRIGHT", 0, 0);
		
		end		
		f.frames[OneRaid.tanks[i]] = { u, t, tt };
	end
	
	local size = 2;
	if (style.showTargetsTarget) then
		size = 3;
	end
	
	if (OneRaid_Options.Groups[f.name].horizontal) then
		f:SetHeight(14 + style.frame.height * size);
		f:SetWidth(style.frame.width * getn(OneRaid.tanks));
	else
		f:SetHeight(14 + (style.frame.height * getn(OneRaid.tanks)));
		f:SetWidth(style.frame.width * size);
	end
	
	f.count = getn(OneRaid.tanks);

	self:UpdateFrame(f, 1);
	
	f:SetScript("OnUpdate", function() self:OnUpdate(arg1); end);

end

function OneRaid.Group:Filter(f)

	f.units = {};
	f.unitNames = {};
	f.unitGroup = {};
	
	if (GetNumRaidMembers() > 0) then
		OneRaid.Group:FilterRaid(f);
	elseif (GetNumPartyMembers() > 0) then
		OneRaid.Group:FilterParty(f);
	--else
		--OneRaid.Group:FilterSelf(f);
	end
	
	if (not f.updatedBuffs and (OneRaid_Options.Groups[f.name].buffMonitor or OneRaid_Options.Groups[f.name].debuffMonitor)) then
		for k, v in f.units do
			self:UpdateBuffs(f, v);
		end
		f.updatedBuffs = 1;
	end
	
	self:SortFrame(f);
	
end

function OneRaid.Group:FilterRaid(f)
	
	local filters = OneRaid_Options.Groups[f.name].filters;
	
	--If in raid and filters match..
	for i = 1, GetNumRaidMembers() do
		local name, rank, group, level, class, fileName, zone, online = GetRaidRosterInfo(i);
		
		local add = nil;
		if (filters.classes[class]) then
			add = 1;
		elseif (filters.groups[group]) then
			add = 1;
		elseif (filters.players[name]) then
			add = 1;
		elseif (filters.groups.party and UnitInParty("raid" .. i)) then
			add = 1;
		elseif (filters.groups.party and UnitIsUnit("raid" .. i, "player")) then
			add = 1;
		elseif (filters.groups.guild and (GetGuildInfo("player") and (GetGuildInfo("player") == GetGuildInfo("raid" .. i)))) then
			add = 1;
		end
				
		if (add) then
			f.unitNames[UnitName("raid" .. i)] = 1;
			f.unitGroup[UnitName("raid" .. i)] = group;
			tinsert(f.units, "raid" .. i);
		end
	end

end


function OneRaid.Group:FilterParty(f)

	local filters = OneRaid_Options.Groups[f.name].filters;
	
	local add = nil;
	if (filters.classes[UnitClass("player")]) then
		add = 1;
	elseif (filters.groups.party) then
		add = 1;
	elseif (filters.players[UnitName("player")]) then
		add = 1;
	elseif (filters.groups.guild and GetGuildInfo("player")) then
		add = 1;
	end
	
	if (add) then
		f.unitNames[UnitName("player")] = 1;
		f.unitGroup[UnitName("player")] = 1;
		tinsert(f.units, "player");
	end
	
	--If in party and filters match..
	for i = 1, GetNumPartyMembers() do			
		local add = nil;
		if (filters.classes[UnitClass("party" .. i)]) then
			add = 1;
		elseif (filters.groups.party) then
			add = 1;
		elseif (filters.players[UnitName("party" .. i)]) then
			add = 1;
		elseif (filters.groups.guild and (GetGuildInfo("player") and (GetGuildInfo("player") == GetGuildInfo("party" .. i)))) then
			add = 1;
		end
		
		if (add) then
			f.unitNames[UnitName("party" .. i)] = 1;
			f.unitGroup[UnitName("party" .. i)] = 1;
			tinsert(f.units, "party" .. i);
		end
	end	

end
		
function OneRaid.Group:FilterSelf(f)

	local filters = OneRaid_Options.Groups[f.name].filters;
	
	--If player filters match..
	local add = nil;
	if (filters.classes[UnitClass("player")]) then
		add = 1;
	elseif (filters.groups.party) then
		add = 1;
	elseif (filters.players[UnitName("player")]) then
		add = 1;
	elseif (filters.groups.guild and GetGuildInfo("player")) then
		add = 1;
	end
	
	if (add) then
		f.unitNames[UnitName("player")] = 1;
		tinsert(f.units, "player");
	end

end

function OneRaid.Group:SortFrame(f)

	--Sort frame.	
	if (not f) then return; end	
	
	local options = OneRaid_Options.Groups[f.name];
	
	f.hide = {};
	local count = 0;
	local limitCount = 0;
		
	for k, v in f.units do
		local hide = nil;
		if (options.filters.dead.only and not UnitIsDeadOrGhost(v)) then
			hide = 1;
		elseif (options.filters.dead.hide and UnitIsDeadOrGhost(v)) then
			hide = 1;
		elseif (options.filters.offline.only and UnitIsConnected(v)) then
			hide = 1;
		elseif (options.filters.offline.hide and not UnitIsConnected(v)) then
			hide = 1;
		elseif (options.filters.health.min and (UnitHealth(v) / UnitHealthMax(v)) * 100 < options.filters.health.min) then
			hide = 1;
		elseif (options.filters.health.max and (UnitHealth(v) / UnitHealthMax(v)) * 100 > options.filters.health.max) then
			hide = 1;
		elseif (options.buffMonitor and not f.unitBuffs[UnitName(v)]) then
			hide = 1;
		elseif (options.debuffMonitor and not f.unitDebuffs[UnitName(v)]) then
			hide = 1;
		elseif (options.limit and limitCount >= tonumber(options.limit)) then
			hide = 1;
		else
			limitCount = limitCount + 1;
		end
				
		if (hide) then
			f.hide[UnitName(v)] = 1;
			count = count + 1;
		end
			
	end
	
	local i, j, index, unit1, unit2;
	
	if (options.sorting.alpha) then
	
		for i = 2, getn(f.units) do
			
			index = f.units[i];
			j = i;
			
			while (j > 1) do
				if (options.sorting.dead and UnitIsDead(f.units[j - 1])) then
					unit1 = "zzzzzzzzza";
				elseif (options.sorting.dead and UnitIsGhost(f.units[j - 1])) then
					unit1 = "zzzzzzzzzd";
				elseif (options.sorting.offline and not UnitIsConnected(f.units[j - 1])) then
					unit1 = "zzzzzzzzzc";
				else
					unit1 = UnitName(f.units[j - 1]);
				end
				
				if (options.sorting.dead and UnitIsDead(index)) then
					unit2 = "zzzzzzzzza";
				elseif (options.sorting.dead and UnitIsGhost(index)) then
					unit2 = "zzzzzzzzzb";
				elseif (options.sorting.offline and not UnitIsConnected(index)) then
					unit2 = "zzzzzzzzzc";
				else
					unit2 = UnitName(index);
				end
				
				if (options.sorting.reverse) then
					if (unit1 >= unit2) then break; end
				else
					if (unit1 <= unit2) then break; end
				end
				
				f.units[j] = f.units[j - 1];
				j = j - 1;
			end
			
			f.units[j] = index;
			
		end
		
	elseif (options.sorting.class) then
		
		for i = 2, getn(f.units) do
			
			index = f.units[i];
			j = i;
			
			while (j > 1) do
				unit1 = 0;
				unit2 = 0;
				if (options.sorting.dead and UnitIsDead(f.units[j - 1])) then
					unit1 = 1000;
				elseif (options.sorting.dead and UnitIsGhost(f.units[j - 1])) then
					unit1 = 1001;
				elseif (options.sorting.offline and not UnitIsConnected(f.units[j - 1])) then
					unit1 = 1002;
				else
					unit1 = OneRaid.classSort[UnitClass(f.units[j - 1])];
				end
				
				if (options.sorting.dead and UnitIsDead(index)) then
					unit2 = 1000;
				elseif (options.sorting.dead and UnitIsGhost(index)) then
					unit2 = 1001;
				elseif (options.sorting.offline and not UnitIsConnected(index)) then
					unit2 = 1002;
				else
					unit2 = OneRaid.classSort[UnitClass(index)];
				end
				
				unit1 = unit1 or 0;
				unit2 = unit2 or 0;

				if (options.sorting.reverse) then
					if (unit1 >= unit2) then break; end
				else
					if (unit1 <= unit2) then break; end
				end
				
				f.units[j] = f.units[j - 1];
				j = j - 1;
			end
			
			f.units[j] = index;
			
		end
		
	elseif (options.sorting.group) then
	
		for i = 2, getn(f.units) do
			
			index = f.units[i];
			j = i;
			
			while (j > 1) do
				unit1 = 0;
				unit2 = 0;
				if (options.sorting.dead and UnitIsDead(f.units[j - 1])) then
					unit1 = 1000;
				elseif (options.sorting.dead and UnitIsGhost(f.units[j - 1])) then
					unit1 = 1001;
				elseif (options.sorting.offline and not UnitIsConnected(f.units[j - 1])) then
					unit1 = 1002;
				else
					unit1 = f.unitGroup[UnitName(f.units[j - 1])];
				end
				
				if (options.sorting.dead and UnitIsDead(index)) then
					unit2 = 1000;
				elseif (options.sorting.dead and UnitIsGhost(index)) then
					unit2 = 1001;
				elseif (options.sorting.offline and not UnitIsConnected(index)) then
					unit2 = 1002;
				else
					unit2 = f.unitGroup[UnitName(index)];
				end
				
				unit1 = unit1 or 0;
				unit2 = unit2 or 0;
				
				if (options.sorting.reverse) then
					if (unit1 >= unit2) then break; end
				else
					if (unit1 <= unit2) then break; end
				end
				
				f.units[j] = f.units[j - 1];
				j = j - 1;
			end
			
			f.units[j] = index;
			
		end
		
	elseif (options.sorting.health) then
	
		for i = 2, getn(f.units) do
			
			index = f.units[i];
			j = i;
			
			while (j > 1) do
				if (options.sorting.dead and UnitIsDead(f.units[j - 1])) then
					unit1 = 1000;
				elseif (options.sorting.dead and UnitIsGhost(f.units[j - 1])) then
					unit1 = 1001;
				elseif (options.sorting.offline and not UnitIsConnected(f.units[j - 1])) then
					unit1 = 1002;
				else
					local cur, max = UnitHealth(f.units[j - 1]), UnitHealthMax(f.units[j - 1]);
					if (max == 1) then max = cur; end
					unit1 = (cur / max) * 100;
				end
				
				if (options.sorting.dead and UnitIsDead(index)) then
					unit2 = 1000;
				elseif (options.sorting.dead and UnitIsGhost(index)) then
					unit2 = 1001;
				elseif (options.sorting.offline and not UnitIsConnected(index)) then
					unit2 = 1002;
				else
					local cur, max = UnitHealth(index), UnitHealthMax(index);
					if (max == 1) then max = cur; end
					unit2 = (cur / max) * 100;
				end
				
				if (options.sorting.reverse) then
					if (unit1 >= unit2) then break; end
				else
					if (unit1 <= unit2) then break; end
				end
				
				f.units[j] = f.units[j - 1];
				j = j - 1;
			end
			
			f.units[j] = index;
			
		end
		
	elseif (options.sorting.dead or options.sorting.offline) then
	
		for i = 2, getn(f.units) do
			
			index = f.units[i];
			j = i;
			
			while (j > 1) do
				if (options.sorting.dead and UnitIsDead(f.units[j - 1])) then
					unit1 = 1000;
				elseif (options.sorting.dead and UnitIsGhost(f.units[j - 1])) then
					unit1 = 1001;
				elseif (options.sorting.offline and not UnitIsConnected(f.units[j - 1])) then
					unit1 = 1002;
				else
					unit1 = 1;
				end
				
				if (options.sorting.dead and UnitIsDead(index)) then
					unit2 = 1000;
				elseif (options.sorting.dead and UnitIsGhost(index)) then
					unit2 = 1001;
				elseif (options.sorting.offline and not UnitIsConnected(index)) then
					unit2 = 1002;
				else
					unit2 = 1;
				end
				
				if (options.sorting.reverse) then
					if (unit1 >= unit2) then break; end
				else
					if (unit1 <= unit2) then break; end
				end
				
				f.units[j] = f.units[j - 1];
				j = j - 1;
			end
			
			f.units[j] = index;
			
		end

	end

	f.count = getn(f.units) - count;
	
	self:UpdateFrame(f);
	
end

function OneRaid.Group:UpdateBuffs(f, u)

	if (OneRaid_Options.Groups[f.name].buffMonitor) then
	
		local buffs = {};
		f.unitBuffs[UnitName(u)] = nil;
		
		for k, v in OneRaid_Options.buffs do
			if (v.buffMonitor and not v[UnitClass(u)]) then
				buffs[v.name] = v;
				if (v.groupName) then
					buffs[v.groupName] = v;
				end
			end
		end
		
		local currentBuff = 1;
		
		while (UnitBuff(u, currentBuff)) do
			
			OneRaid_GroupBuff_TooltipTextLeft1:SetText(nil);
			OneRaid_GroupBuff_Tooltip:SetUnitBuff(u, currentBuff);
			
			local buff = OneRaid_GroupBuff_TooltipTextLeft1:GetText();
			
			if (buffs[buff]) then
				local group = buffs[buff].groupName;
				local single = buffs[buff].name;
						
				if (group) then buffs[group] = nil; end
				if (single) then buffs[single] = nil; end
			
			end
			
			currentBuff = currentBuff + 1;
		
		end
		
		local found = nil;
		for k, v in buffs do
			found = 1;
		end
		
		if (found) then
			f.unitBuffs[UnitName(u)] = buffs;
		end
		
	elseif (OneRaid_Options.Groups[f.name].debuffMonitor) then
	
		local debuffs = {};
		f.unitDebuffs[UnitName(u)] = nil;
		
		for k, v in OneRaid_Options.debuffs do
			if (v.debuffMonitor and not v[UnitClass(u)]) then
				debuffs[v.name] = v;
			end
		end
		 
		local currentDebuff = 1;
		
		while (UnitDebuff(u, currentDebuff)) do
			
			OneRaid_GroupBuff_TooltipTextLeft1:SetText(nil);
			OneRaid_GroupBuff_Tooltip:SetUnitDebuff(u, currentDebuff);
			
			local debuff = OneRaid_GroupBuff_TooltipTextLeft1:GetText();
			local texture, stack, debuffType = UnitDebuff(u, currentDebuff);
			
			debuffType = (debuffType) or "Uncurable";
			
			if (debuffs[debuff] or debuffs[debuffType]) then
				f.unitDebuffs[UnitName(u)] = 1;
				break;
			end
			
			currentDebuff = currentDebuff + 1;
		
		end
		
	end
		
end

function OneRaid.Group:UpdateFrame(f, updateOnly)
	
	local style = OneRaid_Options.UnitStyles[f.style];
	local options = OneRaid_Options.Groups[f.name];
	
	local hidden = {};
	local unitFrames = {};
	local row, col = 1, 1;
	
	if (not options.tankMonitor) then

		for k, v in pairs(f.frames) do
			if (f.unitNames[v.name]) then
				unitFrames[v.name] = v
			else
				OneRaid.Unit:DeactivateFrame(v);
			end
		end
	
		f.frames = {};
		
		for k, v in f.units do
			 
			local uF = unitFrames[UnitName(v)];
			
			if (not uF) then
				uF = OneRaid.Unit:CreateFrame(v, f, f.style);
			end
			
			uF.unit = v;
			
			if (f.hide[UnitName(v)]) then
				uF:ClearAllPoints();
				uF:Hide();
				tinsert(hidden, uF);
			else
				local anchor = nil;
				
				local point, relative = nil, nil;
				if (options.horizontal) then
				
					point = "LEFT";
					relative = "RIGHT";
	
					if (options.grid) then
						if (col > options.grid) then
							point = "TOP";
							relative = "BOTTOM";						
							row = row + 1;
							col = 1;						
						end
						if (col > 1) then
							anchor = f.frames[((row - 1) * options.grid + col) - 1];
						else
							anchor = f.frames[((row - 1) * options.grid + col) - options.grid];
						end
						col = col + 1;
					else					
						anchor = f.frames[col - 1];
						col = col + 1;
					end	
				
				else
	
					point = "TOP";
					relative = "BOTTOM";
	
					if (options.grid) then	
						if (row > options.grid) then
							point = "LEFT";
							relative = "RIGHT";						
							col = col + 1;
							row = 1;						
						end
						if (row > 1) then
							anchor = f.frames[((col - 1) * options.grid + row) - 1];
						else
							anchor = f.frames[((col - 1) * options.grid + row) - options.grid];
						end
						row = row + 1;
					else					
						anchor = f.frames[row - 1];
						row = row + 1;
					end
								
				end
				
				if (anchor == uF) then
					OneRaid:Timer(.1, self, "SortFrame", f);
					return;
				end
				
				if (not anchor) then
					uF:ClearAllPoints();
					uF:SetPoint("TOPLEFT", f, "TOPLEFT", 0, -14);
				else
					uF:ClearAllPoints();
					uF:SetPoint(point, anchor, relative, 0, 0);
				end
	
				uF:Show();
				tinsert(f.frames, uF);
			end
	
		end
		
		for k, v in hidden do
			tinsert(f.frames, v);
		end
		
		if (options.horizontal) then
			if (f.count == 0) then
				col = 1;
				row = 0;
			else
				if (row > 1) then
					col = options.grid;
				else
					col = col - 1;
				end
			end
		else
			if (col > 1) then
				row = options.grid;
			else
				row = row - 1;
			end
			
		end
		
		f:SetHeight(14 + (style.frame.height * row));
		f:SetWidth(style.frame.width * col);
		
	else
				
		if (not updateOnly) then
			self:DeactivateTankMonitorFrame(f.name);
			self:CreateTankMonitorFrame(f);
			return;
		end
	
	end
	
	local title = getglobal(f:GetName() .. "_Title");
	local header = getglobal(f:GetName() .. "_Header_Background");

	if (options.titleSize) then
		title:SetText(f.count .." " .. f.name);
	else
		title:SetText(f.name);
	end
	
	options.titleTextColor = options.titleTextColor or { r = 1, g = 1, b = 1, a = .75 };
	options.titleBgColor = options.titleBgColor or { r = 1, g = 1, b = 1, a = .75 };
	options.bgColor = options.bgColor or { r = 0, g = 0, b = 0, a = .75 };
	
	if (options.titleTextUseClassColor) then
		if (f.count > 0) then
			local cc = RAID_CLASS_COLORS[string.upper(UnitClass(f.units[1]))];
			title:SetTextColor(cc.r, cc.g, cc.b);
		else
			title:SetTextColor(options.titleTextColor.r, options.titleTextColor.g, options.titleTextColor.b);
		end
	else
		title:SetTextColor(options.titleTextColor.r, options.titleTextColor.g, options.titleTextColor.b);
	end
	
	if (options.titleBgUseClassColor) then
		if (f.count > 0) then
			local cc = RAID_CLASS_COLORS[string.upper(UnitClass(f.units[1]))];
			header:SetVertexColor(cc.r, cc.g, cc.b, 1);
		else
			header:SetVertexColor(options.titleBgColor.r, options.titleBgColor.g, options.titleBgColor.b, 1);
		end
	else
		header:SetVertexColor(options.titleBgColor.r, options.titleBgColor.g, options.titleBgColor.b, 1);
	end
	
	if (options.bgUseClassColor) then
		if (f.count > 0) then
			local cc = RAID_CLASS_COLORS[string.upper(UnitClass(f.units[1]))];
			f:SetBackdropColor(cc.r, cc.g, cc.b, options.bgColor.a);
		else
			f:SetBackdropColor(options.bgColor.r, options.bgColor.g, options.bgColor.b, options.bgColor.a);
		end
	else
		f:SetBackdropColor(options.bgColor.r, options.bgColor.g, options.bgColor.b, options.bgColor.a);
	end
	
	local hide = nil;
	
	if (options.hide) then
		hide = 1;
	end
	
	if (options.hideWhenEmpty and f.count == 0) then
		hide = 1;
	end
	
	if (options.hideWhenNotInRaid and GetNumRaidMembers() == 0) then
		hide = 1;
	end
	
	if (options.hideWhenInRaid and GetNumRaidMembers() > 0) then
		hide = 1;
	end
	
	if (OneRaid_Options.showAllGroupWindows) then
		hide = nil;
	end
	
	if (hide) then
		if (f:IsVisible()) then
			f:Hide();
		end
	else
		if (not f:IsVisible()) then
			f:Show();
		end
	end
	
end

function OneRaid.Group:LoadFrame(f)
	
	local options = OneRaid_Options.Groups[f.name];
	
	f:SetBackdropBorderColor(0, 0, 0, 0);
	
	if (not options.position) then
		f:SetPoint("CENTER", 0, 0);
	else	
		if (options.backwards) then
			f:ClearAllPoints();
			f:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMLEFT", options.position.right, options.position.bottom);
		else
			f:ClearAllPoints();
			f:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", options.position.left, options.position.top);
		end
	end

	f:SetScale(options.scale);
	f:SetFrameLevel(0);
	
end

	
function OneRaid.Group:UpdatePosition(f)

	local options = OneRaid_Options.Groups[f.name];
	
	options.position = (options.position) or {};		
	options.position.left   = f:GetLeft();
	options.position.right  = f:GetRight();
	options.position.top    = f:GetTop();
	options.position.bottom = f:GetBottom();
	
	if (options.backwards) then
		f:ClearAllPoints();
		f:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMLEFT", options.position.right, options.position.bottom);
	else
		f:ClearAllPoints();
		f:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", options.position.left, options.position.top);
	end

end




------------------

function OneRaid.Group:UNIT_HEALTH()

	if (OneRaid_Options.Groups[this.name].hide or
		not this.unitNames[UnitName(arg1)]) then
			
		return; 
	
	end

	if (OneRaid_Options.Groups[this.name].sorting.health) then
		self:SortFrame(this);
	elseif ((OneRaid_Options.Groups[this.name].sorting.dead or OneRaid_Options.Groups[this.name].filters.dead.hide) and UnitIsDeadOrGhost(arg1)) then
		self:SortFrame(this);
	elseif (OneRaid_Options.Groups[this.name].filters.dead.only and not UnitIsDeadOrGhost(arg1)) then
		self:SortFrame(this);
	end

end

function OneRaid.Group:UNIT_HEALTHMAX()

	if (OneRaid_Options.Groups[this.name].hide or
		not this.unitNames[UnitName(arg1)]) then
			
		return; 
	
	end

	if (OneRaid_Options.Groups[this.name].sorting.health) then
		self:SortFrame(this);	
	end

end

function OneRaid.Group:UNIT_AURA()

	if (OneRaid_Options.Groups[this.name].hide or
		not this.unitNames[UnitName(arg1)]) then
		
		return;
		
	end
		
	if (OneRaid_Options.Groups[this.name].buffMonitor or
		OneRaid_Options.Groups[this.name].debuffMonitor) then
	
		self:UpdateBuffs(this, arg1);
		self:SortFrame(this);
		
	end
	
end	