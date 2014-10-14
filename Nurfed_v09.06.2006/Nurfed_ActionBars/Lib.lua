
if (not Nurfed_ActionBars) then

	local utility = Nurfed_Utility:New();
	local framelib = Nurfed_Frames:New();

	Nurfed_ActionBars = {};

	Nurfed_ActionBars.buttons = {};
	Nurfed_ActionBars.ignore = {
		ROGUE = {
			[1] = 73,
			[2] = 84,
			form1 = { 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84 },
		},
		WARRIOR = {
			[1] = 73,
			[2] = 108,
			form1 = { 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84 },
			form2 = { 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96 },
			form3 = { 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108 },
		},
		DRUID = {
			[1] = 73,
			[2] = 96,
			form1 = { 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84 },
			form3 = { 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96 },
		},
	};

	function Nurfed_ActionBars:New()
		local object = {};
		setmetatable(object, self);
		self.__index = self;
		return object;
	end

	function Nurfed_ActionBars:GetUnused()
		local total = table.getn(self.buttons);
		for i = 1, total do
			if (not self.buttons[i].u) then
				self.buttons[i].u = true;
				return i;
			end
		end
		total = total + 1;
		self.buttons[total] = { u = true };
		framelib:ObjectInit("Nurfed_ActionButton"..total, "Nurfed_ActionButton_Template");
		return total;
	end

	function Nurfed_ActionBars:ClearUsed()
		local total = table.getn(self.buttons);
		for i = 1, total do
			self.buttons[i].u = false;
			local button = getglobal("Nurfed_ActionButton"..i);
			button:UnregisterAllEvents();
			button.page = nil;
			button:Hide();
		end
	end

	function Nurfed_ActionBars:InitBars()
		self:ClearUsed();
		local bars = utility:GetOption("actionbars", "bars");
		if (not bars) then
			return;
		end
		local id = 1;
		local pages = 1;
		for bar, opt in ipairs(bars) do
			local frame = getglobal("Nurfed_bar"..bar);
			local pos = utility:GetOption("utility", "Nurfed_bar"..bar);
			if (not frame) then
				frame = framelib:ObjectInit("Nurfed_bar"..bar, "Nurfed_ActionBar_Template");
			end
			if (not pos) then
				frame:SetPoint("CENTER", "UIParent", "CENTER", 0, 0);
			else
				frame:SetPoint("CENTER", "UIParent", "BOTTOMLEFT", pos[1], pos[2]);
			end
			if (opt[3] > pages) then
				pages = opt[3];
			end
			frame:SetScale(opt[4]);
			frame:SetAlpha(opt[7]);
			frame.pages = opt[3];
			local begin, last, button, n;
			local buttons = opt[1] * opt[2];
			for i = 1, opt[1] do
				for x = 1, opt[2] do
					n = self:GetUnused();
					button = getglobal("Nurfed_ActionButton"..n);
					local _, eclass = UnitClass("player");
					if (self.ignore[eclass]) then
						if (id >= self.ignore[eclass][1] and id <= self.ignore[eclass][2]) then
							id = self.ignore[eclass][2] + 1;
						end
					end
					button:SetID(id);
					button:SetParent(frame);
					button:ClearAllPoints();
					button:RegisterForDrag("LeftButton", "RightButton");
					button:RegisterForClicks("LeftButtonUp", "RightButtonUp");
					button:RegisterEvent("PLAYER_ENTERING_WORLD");
					button:RegisterEvent("ACTIONBAR_PAGE_CHANGED");
					button:RegisterEvent("ACTIONBAR_SLOT_CHANGED");
					button:RegisterEvent("ACTIONBAR_SHOWGRID");
					button:RegisterEvent("ACTIONBAR_HIDEGRID");
					button:RegisterEvent("UPDATE_BINDINGS");
					if (n <= 12) then
						button:RegisterEvent("UPDATE_BONUS_ACTIONBAR");
					end
					self:UpdateButton(button);
					if (x == 1) then
						if (begin) then
							button:SetPoint("BOTTOMLEFT", begin, "TOPLEFT", 0, opt[6]);
						else
							button:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 0, 0);
						end
						begin = button;
					else
						button:SetPoint("LEFT", last, "RIGHT", opt[5], 0);
					end
					last = button;

					if (opt[3] > 1) then
						button.page = {};
						for p = 1, opt[3] do
							button.page[p] = id + (buttons * (p - 1));
						end
					end
					id = id + 1;
				end
			end
			if (last.page) then
				local e = table.getn(last.page);
				local add = last.page[e];
				id = id + add;
			end
			if (opt[7] > 0) then
				if (opt[8] == 1) then
					frame:Hide();
					frame:RegisterEvent("PLAYER_ENTER_COMBAT");
					frame:RegisterEvent("PLAYER_LEAVE_COMBAT");
					frame:RegisterEvent("PLAYER_REGEN_DISABLED");
					frame:RegisterEvent("PLAYER_REGEN_ENABLED");
					frame:RegisterEvent("PLAYER_UPDATE_RESTING");
					frame:SetScript("OnEvent", function() if (event == "PLAYER_ENTER_COMBAT" or event == "PLAYER_REGEN_DISABLED") then this:Show() else this:Hide() end end);
				else
					frame:UnregisterAllEvents();
					frame:SetScript("OnEvent", nil);
					frame:Show();
				end
			else
				frame:Hide();
			end
		end
		NUM_ACTIONBAR_PAGES = pages;
		Nurfed_ActionBars_UpdateButtons();
	end

	function Nurfed_ActionBars:CreateBags()
		local frame = framelib:ObjectInit("Nurfed_bagbar", "Nurfed_ActionBar_Template");
		local pos = utility:GetOption("utility", "Nurfed_bagbar");
		if (not pos) then
			frame:SetPoint("CENTER", "UIParent", "CENTER", 0, 0);
		else
			frame:SetPoint("CENTER", "UIParent", "BOTTOMLEFT", pos[1], pos[2]);
		end
		local last, bag;
		for i = 1, 5 do
			if (i == 1) then
				bag = framelib:ObjectInit("Nurfed_bagbar"..i, "Nurfed_BackPack_Template", Nurfed_bagbar);
			else
				bag = framelib:ObjectInit("NurfedBagBag"..(i - 2).."Slot", "Nurfed_BagButton_Template", Nurfed_bagbar);
			end
			local texture = getglobal(bag:GetName().."IconTexture");
			bag:RegisterForDrag("LeftButton", "RightButton");
			bag:RegisterForClicks("LeftButtonUp", "RightButtonUp");
			if (i == 1) then
				bag:SetID(0);
				texture:SetTexture("Interface\\Buttons\\Button-Backpack-Up");
				bag:SetScript("OnClick", function() BackpackButton_OnClick() end);
				bag:SetScript("OnReceiveDrag", function() BackpackButton_OnClick() end);
				bag:SetScript("OnEnter", function()
								GameTooltip:SetOwner(this, "ANCHOR_LEFT");
								GameTooltip:SetText(TEXT(BACKPACK_TOOLTIP), 1.0, 1.0, 1.0);
								local keyBinding = GetBindingKey("TOGGLEBACKPACK");
								if ( keyBinding ) then
									GameTooltip:AppendText(" "..NORMAL_FONT_COLOR_CODE.."("..keyBinding..")"..FONT_COLOR_CODE_CLOSE);
								end
							end);
				bag:SetPoint("BOTTOMLEFT", "Nurfed_bagbar", "BOTTOMLEFT", 0, 0);
			else
				bag:SetPoint("RIGHT", last, "LEFT", 0, 0);
			end
			last = bag;
		end
		Nurfed_ActionBars_UpdateBars("bagbar", 5);
	end

	function Nurfed_ActionBars:CreatePetBar()
		local frame = framelib:ObjectInit("Nurfed_petbar", "Nurfed_ActionBar_Template");
		local pos = utility:GetOption("utility", "Nurfed_petbar");
		if (not pos) then
			frame:SetPoint("CENTER", "UIParent", "CENTER", 0, 0);
		else
			frame:SetPoint("CENTER", "UIParent", "BOTTOMLEFT", pos[1], pos[2]);
		end
		frame:RegisterEvent("UNIT_PET");
		frame:RegisterEvent("PET_BAR_UPDATE");
		frame:RegisterEvent("PET_BAR_UPDATE_COOLDOWN");
		frame:RegisterEvent("PLAYER_CONTROL_LOST");
		frame:RegisterEvent("PLAYER_CONTROL_GAINED");
		frame:RegisterEvent("PLAYER_FARSIGHT_FOCUS_CHANGED");
		frame:RegisterEvent("UNIT_FLAGS");
		frame:RegisterEvent("UNIT_AURA");
		frame:SetScript("OnEvent", function() Nurfed_ActionButton_OnEvent() end);
		for i = 1, NUM_PET_ACTION_SLOTS do
			framelib:ObjectInit("Nurfed_petbar"..i, "Nurfed_PetButton_Template", Nurfed_petbar);
			local button = getglobal("Nurfed_petbar"..i);
			if (i == 1) then
				button:SetPoint("BOTTOMLEFT", "Nurfed_petbar", "BOTTOMLEFT", 0, 0);
			end
			button:SetID(i);
			button.isPet = true;
			button:RegisterForDrag("LeftButton", "RightButton");
			button:RegisterForClicks("LeftButtonUp", "RightButtonUp");
			button:RegisterEvent("PLAYER_ENTERING_WORLD");
			button:RegisterEvent("UPDATE_BINDINGS");
		end
		Nurfed_ActionBars_UpdateBars("petbar", NUM_PET_ACTION_SLOTS);
	end

	function Nurfed_ActionBars:CreateMicroMenu()
		local frame = framelib:ObjectInit("Nurfed_micro", "Nurfed_ActionBar_Template");
		local pos = utility:GetOption("utility", "Nurfed_micro");
		if (not pos) then
			frame:SetPoint("CENTER", "UIParent", "CENTER", 0, 0);
		else
			frame:SetPoint("CENTER", "UIParent", "BOTTOMLEFT", pos[1], pos[2]);
		end
		CharacterMicroButton:SetParent(frame);
		CharacterMicroButton:ClearAllPoints();
		CharacterMicroButton:SetScript("OnDragStart", ab_OnDragStart);
		CharacterMicroButton:SetScript("OnDragStop", ab_OnDragStop);
		CharacterMicroButton:RegisterForDrag("LeftButton", "RightButton");
		CharacterMicroButton:SetPoint("LEFT", frame, "LEFT", 0, 0);
		SpellbookMicroButton:SetParent(frame);
		SpellbookMicroButton:ClearAllPoints();
		SpellbookMicroButton:SetScript("OnDragStart", ab_OnDragStart);
		SpellbookMicroButton:SetScript("OnDragStop", ab_OnDragStop);
		SpellbookMicroButton:RegisterForDrag("LeftButton", "RightButton");
		SpellbookMicroButton:SetPoint("LEFT", "CharacterMicroButton", "RIGHT", -3, 0);
		TalentMicroButton:SetParent(frame);
		TalentMicroButton:ClearAllPoints();
		TalentMicroButton:SetScript("OnDragStart", ab_OnDragStart);
		TalentMicroButton:SetScript("OnDragStop", ab_OnDragStop);
		TalentMicroButton:RegisterForDrag("LeftButton", "RightButton");
		TalentMicroButton:SetPoint("LEFT", "SpellbookMicroButton", "RIGHT", -3, 0);
		QuestLogMicroButton:SetParent(frame);
		QuestLogMicroButton:ClearAllPoints();
		QuestLogMicroButton:SetScript("OnDragStart", ab_OnDragStart);
		QuestLogMicroButton:SetScript("OnDragStop", ab_OnDragStop);
		QuestLogMicroButton:RegisterForDrag("LeftButton", "RightButton");
		QuestLogMicroButton:SetPoint("LEFT", "TalentMicroButton", "RIGHT", -3, 0);
		SocialsMicroButton:SetParent(frame);
		SocialsMicroButton:ClearAllPoints();
		SocialsMicroButton:SetScript("OnDragStart", ab_OnDragStart);
		SocialsMicroButton:SetScript("OnDragStop", ab_OnDragStop);
		SocialsMicroButton:RegisterForDrag("LeftButton", "RightButton");
		SocialsMicroButton:SetPoint("LEFT", "QuestLogMicroButton", "RIGHT", -3, 0);
		WorldMapMicroButton:SetParent(frame);
		WorldMapMicroButton:ClearAllPoints();
		WorldMapMicroButton:SetScript("OnDragStart", ab_OnDragStart);
		WorldMapMicroButton:SetScript("OnDragStop", ab_OnDragStop);
		WorldMapMicroButton:RegisterForDrag("LeftButton", "RightButton");
		WorldMapMicroButton:SetPoint("LEFT", "SocialsMicroButton", "RIGHT", -3, 0);
		MainMenuMicroButton:SetParent(frame);
		MainMenuMicroButton:ClearAllPoints();
		MainMenuMicroButton:SetScript("OnDragStart", ab_OnDragStart);
		MainMenuMicroButton:SetScript("OnDragStop", ab_OnDragStop);
		MainMenuMicroButton:RegisterForDrag("LeftButton", "RightButton");
		MainMenuMicroButton:SetPoint("LEFT", "WorldMapMicroButton", "RIGHT", -3, 0);
		HelpMicroButton:SetParent(frame);
		HelpMicroButton:ClearAllPoints();
		HelpMicroButton:SetScript("OnDragStart", ab_OnDragStart);
		HelpMicroButton:SetScript("OnDragStop", ab_OnDragStop);
		HelpMicroButton:RegisterForDrag("LeftButton", "RightButton");
		HelpMicroButton:SetPoint("LEFT", "MainMenuMicroButton", "RIGHT", -3, 0);
		Nurfed_ActionBars_UpdateMicro();
	end

	function Nurfed_ActionBars:CreateShapeShift()
		local frame = framelib:ObjectInit("Nurfed_stancebar", "Nurfed_ActionBar_Template");
		local pos = utility:GetOption("utility", "Nurfed_stancebar");
		if (not pos) then
			frame:SetPoint("CENTER", "UIParent", "CENTER", 0, 0);
		else
			frame:SetPoint("CENTER", "UIParent", "BOTTOMLEFT", pos[1], pos[2]);
		end
		frame:RegisterEvent("UPDATE_SHAPESHIFT_FORMS");
		frame:RegisterEvent("UPDATE_INVENTORY_ALERTS");
		frame:RegisterEvent("SPELL_UPDATE_COOLDOWN");
		frame:RegisterEvent("SPELL_UPDATE_USABLE");
		frame:RegisterEvent("PLAYER_AURAS_CHANGED");
		frame:SetScript("OnEvent", function() self:UpdateStanceState() end);
		for i = 1, NUM_SHAPESHIFT_SLOTS do
			local button = framelib:ObjectInit("Nurfed_stancebar"..i, "Nurfed_ShapeShift_Template", Nurfed_stancebar);
			if (i == 1) then
				button:SetPoint("BOTTOMLEFT", "Nurfed_stancebar", "BOTTOMLEFT", 0, 0);
			end
			button:SetID(i);
			button.isStance = true;
			button:RegisterForDrag("LeftButton", "RightButton");
			getglobal(button:GetName().."Cooldown"):SetScale(1);
		end
		Nurfed_ActionBars_UpdateBars("stancebar", NUM_SHAPESHIFT_SLOTS);
	end

	function Nurfed_ActionBars:UpdateButtons()
		local info = utility:GetOption("actionbars", "buttons");
		if (info[1]) then
			self.updating = true;
			for i = 1, 120 do
				if (info[i] ~= 999) then
					if (type(info[i]) == "number") then
						PickupSpell(info[i], BOOKTYPE_SPELL);
					else
						local macroid = GetMacroIndexByName(info[i]);
						if (macroid > 0) then
							PickupMacro(macroid);
						end
					end
					PlaceAction(i);
				elseif (info[i] == 999) then
					PickupAction(i);
					PutItemInBackpack();
				end
			end
			self.updating = nil;
		end
	end

	function Nurfed_ActionBars:GetSpellId(id)
		if (HasAction(id)) then
			Nurfed_ActionTooltipTextLeft1:SetText(nil);
			Nurfed_ActionTooltipTextRight1:SetText(nil);
			Nurfed_ActionTooltip:SetAction(id);
			local name = Nurfed_ActionTooltipTextLeft1:GetText();
			local rank = Nurfed_ActionTooltipTextRight1:GetText();
			local j = 1;
			local spellName, spellRank = GetSpellName(j, BOOKTYPE_SPELL);
			while spellName do
				if (name == spellName) then
					if (rank and string.find(rank, "^"..RANK)) then
						if(rank == spellRank) then
							return j;
						end
					else
						return j;
					end
				end
				j = j + 1;
				spellName, spellRank = GetSpellName(j, BOOKTYPE_SPELL);
			end
			return name;
		else
			return 999;
		end
	end

	function Nurfed_ActionBars:SaveButton(id)
		if (not self.updating) then
			local spellid = self:GetSpellId(id);
			utility:SetOption("actionbars", "buttons", spellid, id, nil, true);
		end
	end

	function Nurfed_ActionBars:SaveAllButtons()
		if (not self.updating) then
			local info = {};
			for i = 1, 120 do
				local spellid = self:GetSpellId(i);
				info[i] = spellid;
			end
			utility:SetOption("actionbars", "buttons", info);
		end
	end

	function Nurfed_ActionBars:UpdateButton(button)
		if (button) then
			this = button;
		end
		local id = this:GetID();
		local icon = getglobal(this:GetName().."Icon");
		local cooldown = getglobal(this:GetName().."Cooldown");
		local texture = GetActionTexture(id);
		if (texture) then
			icon:SetTexture(texture);
			icon:Show();
			this.rangeTimer = -1;
		else
			icon:Hide();
			cooldown:Hide();
			this.rangeTimer = nil;
			getglobal(this:GetName().."HotKey"):SetVertexColor(0.6, 0.6, 0.6);
		end
		self:UpdateCount();
		if (HasAction(id)) then
			this:RegisterEvent("ACTIONBAR_UPDATE_STATE");
			this:RegisterEvent("ACTIONBAR_UPDATE_USABLE");
			this:RegisterEvent("ACTIONBAR_UPDATE_COOLDOWN");
			this:RegisterEvent("UPDATE_INVENTORY_ALERTS");
			this:RegisterEvent("UNIT_INVENTORY_CHANGED");
			this:RegisterEvent("CRAFT_SHOW");
			this:RegisterEvent("CRAFT_CLOSE");
			this:RegisterEvent("TRADE_SKILL_SHOW");
			this:RegisterEvent("TRADE_SKILL_CLOSE");
			this:RegisterEvent("PLAYER_ENTER_COMBAT");
			this:RegisterEvent("PLAYER_LEAVE_COMBAT");
			this:RegisterEvent("START_AUTOREPEAT_SPELL");
			this:RegisterEvent("STOP_AUTOREPEAT_SPELL");

			this:Show();
			self:UpdateState();
			self:UpdateCooldown();
		else
			this:UnregisterEvent("ACTIONBAR_UPDATE_STATE");
			this:UnregisterEvent("ACTIONBAR_UPDATE_USABLE");
			this:UnregisterEvent("ACTIONBAR_UPDATE_COOLDOWN");
			this:UnregisterEvent("UPDATE_INVENTORY_ALERTS");
			this:UnregisterEvent("UNIT_INVENTORY_CHANGED");
			this:UnregisterEvent("CRAFT_SHOW");
			this:UnregisterEvent("CRAFT_CLOSE");
			this:UnregisterEvent("TRADE_SKILL_SHOW");
			this:UnregisterEvent("TRADE_SKILL_CLOSE");
			this:UnregisterEvent("PLAYER_ENTER_COMBAT");
			this:UnregisterEvent("PLAYER_LEAVE_COMBAT");
			this:UnregisterEvent("START_AUTOREPEAT_SPELL");
			this:UnregisterEvent("STOP_AUTOREPEAT_SPELL");

			if (this.showgrid == 0) then
				this:Hide();
			else
				cooldown:Hide();
			end
		end

		local border = getglobal(this:GetName().."Border");
		if (IsEquippedAction(id)) then
			border:SetVertexColor(0, 1.0, 0, 0.35);
			border:Show();
		else
			border:Hide();
		end

		local macroName = getglobal(this:GetName().."Name");
		macroName:SetText(GetActionText(id));
	end

	function Nurfed_ActionBars:UpdatePage()
		if (this.page and this.page[CURRENT_ACTIONBAR_PAGE]) then
			this:SetID(this.page[CURRENT_ACTIONBAR_PAGE]);
		end
		local _, eclass = UnitClass("player");
		if (CURRENT_ACTIONBAR_PAGE == 1 and self.ignore[eclass]) then
			self:UpdateStance();
		end
	end

	function Nurfed_ActionBars:UpdateStance()
		local numForms = GetNumShapeshiftForms();
		if (numForms > 0) then
			local id = string.gsub(this:GetName(), "Nurfed_ActionButton", "");
			id = tonumber(id);
			if (id > 12 or (this.page and CURRENT_ACTIONBAR_PAGE ~= 1)) then
				return;
			end
			local _, eclass = UnitClass("player");
			for i = 1, GetNumShapeshiftForms() do
				local _, _, active = GetShapeshiftFormInfo(i);
				if (active and self.ignore[eclass] and self.ignore[eclass]["form"..i]) then
					id = self.ignore[eclass]["form"..i][id];
				end
			end
			this:SetID(id);
			UIFrameFadeIn(this, 0.25);
			self:StopFlash();
			self:UpdateStanceState();
		end
	end

	function Nurfed_ActionBars:UpdateStanceState()
		local numForms = GetNumShapeshiftForms();
		for i=1, NUM_SHAPESHIFT_SLOTS do
			button = getglobal("Nurfed_stancebar"..i);
			icon = getglobal("Nurfed_stancebar"..i.."Icon");
			if (i <= numForms) then
				texture, name, isActive, isCastable = GetShapeshiftFormInfo(i);
				icon:SetTexture(texture);
				
				--Cooldown stuffs
				cooldown = getglobal("Nurfed_stancebar"..i.."Cooldown");
				if ( texture ) then
					cooldown:Show();
				else
					cooldown:Hide();
				end
				start, duration, enable = GetShapeshiftFormCooldown(i);
				CooldownFrame_SetTimer(cooldown, start, duration, enable);

				if (start > 0 and duration > 2 and enable > 0) then
					button.cooling = true;
					button.coolingstart = start;
					button.coolingduration = duration;
				else
					button.cooling = nil;
				end
				
				if (isActive) then
					button:SetChecked(1);
				else
					button:SetChecked(0);
				end

				if (isCastable) then
					icon:SetVertexColor(1.0, 1.0, 1.0);
				else
					icon:SetVertexColor(0.4, 0.4, 0.4);
				end

				button:Show();
			else
				button:Hide();
			end
		end
	end

	function Nurfed_ActionBars:UpdateBindings()
		local abtype;
		local id = string.gsub(this:GetName(), "Nurfed_ActionButton", "");
		id = tonumber(id);
		if (id <= 12) then
			abtype = "ACTIONBUTTON";
		else
			abtype = "NURFED_ACTIONBUTTON";
		end
		local hotkey = getglobal(this:GetName().."HotKey");
		local action = abtype..id;
		local text = utility:FormatBinding(GetBindingText(GetBindingKey(action), "KEY_"));
		hotkey:SetText(text);
	end

	function Nurfed_ActionBars:UpdateState()
		if (IsCurrentAction(this:GetID()) or IsAutoRepeatAction(this:GetID())) then
			this:SetChecked(1);
		else
			this:SetChecked(0);
		end
	end

	function Nurfed_ActionBars:UpdateCount()
		local text = getglobal(this:GetName().."Count");
		if (IsConsumableAction(this:GetID())) then
			text:SetText(GetActionCount(this:GetID()));
		else
			text:SetText("");
		end
	end

	function Nurfed_ActionBars:UpdateCooldown()
		local cooldown = getglobal(this:GetName().."Cooldown");
		local start, duration, enable = GetActionCooldown(this:GetID());
		CooldownFrame_SetTimer(cooldown, start, duration, enable);

		if (start > 0 and duration > 2 and enable > 0) then
			this.cooling = true;
			this.coolingstart = start;
			this.coolingduration = duration;
		else
			this.cooling = nil;
		end
	end

	function Nurfed_ActionBars:ShowGrid(button)
		if (not button) then
			button = this;
		end
		local border = getglobal(button:GetName().."NormalTexture");
		button.showgrid = 1;
		border:SetAlpha(0.5);
		border:Show();
		button:Show();
	end

	function Nurfed_ActionBars:HideGrid()
		local border = getglobal(this:GetName().."NormalTexture");
		if (utility:GetOption("actionbars", "showunused") ~= 1) then
			this.showgrid = 0;
		end
		if (utility:GetOption("actionbars", "showborder") ~= 1) then
			border:Hide();
		end
		if (this.showgrid == 0 and not HasAction(this:GetID())) then
			this:Hide();
		end
		border:SetAlpha(1);
	end

	function Nurfed_ActionBars:StartFlash()
		this.flashing = 1;
		this.flashtime = 0;
		self:UpdateState();
	end

	function Nurfed_ActionBars:StopFlash()
		this.flashing = 0;
		getglobal(this:GetName().."Flash"):Hide();
		self:UpdateState();
	end
end