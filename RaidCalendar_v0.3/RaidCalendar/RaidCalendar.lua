--[[
//##############################################################################
//# Autor: M. Herrmann
//# Datum: 2006-07-04
//# Letzte Aenderung: 2006-11-03
//##############################################################################
]]


-- Die Daten in dieser Tabelle werden in der SavedVariables abgespeichert
-- (siehe RaidCalendar.DEFAULT_OPTIONS)
RaidCalendarOptions = {};

--[[
//##############################################################################	
//#
//##############################################################################	
]]
RaidCalendar = {
	
	-- Das Slash-Commando. mit dem das Hauptfenster geöffnet werden kann
	SLASH_COMMAND = "/raidc",
	
	-- Diese Optionen werden bei der ersten Benutzung des Addons verwendet
	DEFAULT_OPTIONS = {
	
		Debugging = false,
		
		-- Soll Montag oder Sonntag als erster 
		-- Tag der Woche angezeigt werden?
		MondayIsFirstDay = true, 
		
		-- Welche Instanz soll im Kalender angezeigt werden?
		-- (gueltiges Kuerzel einer Instanz)
		-- Bei einem nicht gueltigen Kuerzel werden alle Instanzen angezeigt
		Filter = 1,
		
		-- Der Serverstandort
		Server = "US",
		
		-- Version der Optionen
		Version = 0.3
	},
	
	-- Das Datum, das aktuell im Kalender angezeigt wird
	CurrentDate = {
		Month = tonumber(date("%m")),
		Day = tonumber(date("%d")),
		Year = tonumber(date("%Y"))
	},

	Const = {
		DaysInMonth = {31, 28, 31, 30,  31,  30,  31,  31,  30,  31,  30,  31}
	},
		
	isInitialized = false,
	
	
	--[[
	//##########################################################################	
	//# Wird audgeführt, wenn der Benutzer das Slash-Kommando eingibt.
	//# Zeigt das Hauptfenster an.
	//##########################################################################	
	]]
	SlashCommand = function()
		RaidCalendar.MainFrame:Show();
	end,
	
	--[[
	//##########################################################################	
	//#
	//##########################################################################	
	]]
	OnLoad = function(self)
		
		-- this ist die Referenz auf den MainFrame, für den der Aufruf der
		-- aktuellen Methode ja definiert ist
		this:RegisterEvent("ADDON_LOADED");
		this:RegisterEvent("VARIABLES_LOADED");
	
		
		SlashCmdList["RAIDC"] = self.SlashCommand;
		SLASH_RAIDC1 = self.SLASH_COMMAND;
	end,
	
	
	--[[
	//##########################################################################	
	//# Wird beim Event ADDON_LOADED bzw. VARIABLES_LOADED aufgerufen.
	//# Initialisiert die Optionen, das Hauptfenster und das Optionen-Fenster
	//##########################################################################	
	]]
	Init = function(self)
		self:InitOptions();
	
		-- Das Hauptfenster initialisieren. 
		self.MainFrame:Init(self, this);
		self.OptionsFrame:Init(self, this);
	end,

	--[[
	//##########################################################################	
	//#
	//##########################################################################	
	]]
	OnEvent = function(self)

		if (event == "ADDON_LOADED") then
			if (strlower(arg1) == "raidcalendar") then
				self.isInitialized = true;
				self:Init();
			end
		elseif (event == "VARIABLES_LOADED") then
			if (not self.isInitialized) then
				self.isInitialized = true;
				self:Init();
			end
		end
	end,
	
	--[[
	//##########################################################################	
	//#
	//##########################################################################	
	]]
	InitOptions = function(self)
		
		-- Falls noch keine Optionen vorhanden sind oder die Version der Optionen
		-- nicht mehr stimmt werden neue Optionen angelegt.
		if ((RaidCalendarOptions == nil) 
			or (RaidCalendarOptions.Version ~= self.DEFAULT_OPTIONS.Version)) then
			RaidCalendarOptions = self.DEFAULT_OPTIONS;
		end
	end,
	
	
	--[[
	//##########################################################################	
	//#
	//##########################################################################	
	]]
	DebugMessage = function(self, msg)
		if RaidCalendarOptions.Debugging == true then
			DEFAULT_CHAT_FRAME:AddMessage("<IcalDebug>:"..msg);
		end
	end,
	
	--[[
	//##########################################################################	
	//# Wird aufgerufen, wenn der Benutzer die Schaltfäche "Nächster Monat"
	//# anklickt. Der Monat wird erhöht (ggf. das Jahr auch) und anschliessend 
	//# "Update" aufgerufen, um die Anzeige zu aktualisieren
	//##########################################################################	
	]]
	NextMonth = function(self)
		if (self.CurrentDate.Month == 12) then
			self.CurrentDate.Month = 1;
			self.CurrentDate.Year = self.CurrentDate.Year + 1;
		else
			self.CurrentDate.Month = self.CurrentDate.Month + 1;
		end
		self.MainFrame:Update();
	end,
	--[[
	//##########################################################################	
	//# Wird aufgerufen, wenn der Benutzer die Schaltfäche "Vorheriger Monat"
	//# anklickt. Der Monat wird verringert (ggf. das Jahr auch) und anschliessend 
	//# "Update" aufgerufen, um die Anzeige zu aktualisieren
	//##########################################################################	
	]]
	PreviousMonth = function(self)
		if (self.CurrentDate.Month == 1) then
			self.CurrentDate.Month = 12;
			self.CurrentDate.Year = self.CurrentDate.Year - 1;
		else
 			self.CurrentDate.Month = self.CurrentDate.Month - 1;
		end
		self.MainFrame:Update();
	end,
	
	--[[
	//##########################################################################	
	//# Wird aufgerufen, wenn der Benutzer die Schaltfäche "Heute"
	//# anklickt. Es wird zum aktuellen Datum gesprungen
	//##########################################################################	
	]]
	Today = function(self)
	
		self.CurrentDate.Month = tonumber(date("%m"));
		self.CurrentDate.Day = tonumber(date("%d"));
		self.CurrentDate.Year = tonumber(date("%Y"));
		
		self.MainFrame:Update();
	end,
	
	
	--[[
	//##########################################################################	
	//# Liefert fpr einen bestimmten Monat eine Liste der Instanz-Resets 
	//# sortiert nach Tag zurück.
	//##########################################################################	
	]]
	GetResetList = function (self, month, year) 

		local currentInstance, startYear, startMonth, startDay;
		local startTime, endTime, numDays, firstDay, day;
		local resets = {};
		local daysInMonth = self:DaysInMonth(month,year);
		
		-- Algo: Vom ersten Reset-Datum bis zum Vormonat des gewünschten
		-- Monats alle Tage zusammenzählen
		-- Die Anzahl der Tage Modulo dem Reset-Interval ergibt die 
		-- "verbleibenden" Tage im Vormonat an denen nicht resettet wird.
		-- Das Reset-Interval minus der "verbleibenden" Tage ergibt das
		-- erste Datum des gewünschten Monats, an dem resettet wird
		-- von da an wird einfach immer das Reset-Interval addiert um das
		-- nächste Datum zu errechnen.
		-- Diese Prozedur für jede Instanz durchlaufen
		for instanceNum = 1, table.getn(ICalInstances) do
		
			currentInstance = ICalInstances[instanceNum];
						
			startYear = currentInstance.Reset[RaidCalendarOptions.Server].FirstResetYear;
			startMonth = currentInstance.Reset[RaidCalendarOptions.Server].FirstResetMonth;
			startDay = currentInstance.Reset[RaidCalendarOptions.Server].FirstResetDay;
			startTime = time({year=startYear,month=startMonth,day=startDay});
			endTime = time({year=year,month=month,day=1});
			numDays = (endTime - startTime) / (60 * 60 * 24) - 1;
			firstDay = currentInstance.Reset[RaidCalendarOptions.Server].ResetInterval 
				- math.mod(numDays, currentInstance.Reset[RaidCalendarOptions.Server].ResetInterval);
			
			
			local day = firstDay;
			while day <= daysInMonth do
				local currentDay;
				if resets[day] == nil then
					resets[day] = {};
				end
				table.insert(resets[day], currentInstance);
				day = day + currentInstance.Reset[RaidCalendarOptions.Server].ResetInterval;
			end
		end
				
		return resets;
	end,
	
	--[[
	//##########################################################################	
	//#
	//##########################################################################	
	]]
	DaysInMonth = function(self, month, year)
		if month == 2 and self:IsLeapYear(year) then
			return 29;
		elseif month == 2 then
			return 28;
		else
			return self.Const.DaysInMonth[month];
		end
	end,
	
	--[[
	//######################################################################	
	//#
	//######################################################################	
	]]
	IsLeapYear = function(self, year)
		return (math.mod(year, 400) == 0)
			or ((math.mod(year, 4) == 0) and (math.mod(year, 100) ~= 0));
	end,
	

	--[[
	//##########################################################################	
	//#
	//##########################################################################	
	]]
	MainFrame = {
	
		-- Damit spätere Namensänderungen im XML-Code erleichtert werden wird
		-- der Name des Frames hier in einer Konstanten festgehalten und 
		frameName = "ICalMainFrame",
		
		-- Referenz auf das Hauptfenster, damit immer bequem darauf zugegriffen 
		-- werden kann
		frame = nil,
		
		-- Referenz auf den RaidCalender, zu dem das RaidCalender-Fenster gehört
		owmer = nil,
		
		--[[
		//######################################################################	
		//#
		//######################################################################	
		]]
		Init = function(self, owner, frame)
			
			self.frame = frame
			self.owner = owner;
			
			-- Ermöglicht das Schliessen des Frames mit Hilfe der Escape-Taste
			tinsert(UISpecialFrames, self.frameName);
			
			-- Die Update methode füllt den Kalender mit den Daten des aktuell
			-- eingestellten Monats
			self:Update();
		end,
		
		--[[
		//######################################################################	
		//#
		//######################################################################	
		]]
		Show = function(self) 
			self.frame:Show();
		end,
		
		--[[
		//######################################################################	
		//# Aktualisiert die Wochentage über dem Kalender. Jenachdem, ob
		//# Sonntag oder Montag der erste Tag der Woche ist
		//######################################################################	
		]]
		UpdateWeekdayHeaders = function(self)
		
			local headerPrefix = self.frameName.."WeekdayHeadersDay";
			local header;
			
			if RaidCalendarOptions.MondayIsFirstDay == true then
				for n = 1, 7 do
					header = getglobal(headerPrefix..n);
					header:SetText(RAIDCLOC_WEEKDAYS[n]);
				end
			else
				header = getglobal(headerPrefix..1);
				header:SetText(RAIDCLOC_WEEKDAYS[7]);
				for n = 1, 6 do
					header = getglobal(headerPrefix..(n + 1));
					header:SetText(RAIDCLOC_WEEKDAYS[n]);
				end
			end
		end,
		
		--[[
		//######################################################################	
		//# Aktualisiert die Anzeige des Kalenders.
		//# Wird z.B. aufgerufen, wenn zum nächsten oder vorherigen Monat
		//# weitergeschaltet wird.
		//######################################################################	
		]]
		Update = function(self)
		
			-- aktualisiert die Wochentage über dem Kalender. Jenachdem, ob
			-- Sonntag oder Montag der erste Tag der Woche ist
			self:UpdateWeekdayHeaders();
		
			local m, d, y, firstDay, daysInMonth;
			
			m = self.owner.CurrentDate.Month;
			d = self.owner.CurrentDate.Day;
			y = self.owner.CurrentDate.Year;

			-- das heutige Datum wird benötigt, da es im Kalender
			-- hervorgehiben werden soll.
			local todayMonth = tonumber(date("%m"));
			local todayDay = tonumber(date("%d"));
			local todayYear = tonumber(date("%Y"));
			
			-- Im Hauptfester den Namen des Monats aktualisieren
			ICalMainFrameHeaderMonthText:SetText(RAIDCLOC_MONTHS[m].." "..y);
			
			-- Was ist der Wochentag des ersten Tages des aktuellen Monats?
			-- Bei wday bedeutet 1, dass es der Sonntag ist. 
			-- Ist die Option "MondayIsFirstDay" auf true gesetzt 
			-- muss firstDay dekrementiert werden, 
			-- damit es im Kalender richtig angezeigt wird
			firstDay = date("*t",time({year=y,month=m,day=1})).wday;
			if (RaidCalendarOptions.MondayIsFirstDay == true) then
				if (firstDay == 1) then
					firstDay = 7
				else 
					firstDay = firstDay - 1;
				end
			end
			
			
			daysInMonth = self.owner:DaysInMonth(m, y);
			
			-- Zunächst werden alle bisherigen Einträge aus dem Kalender entfernt, 
			-- damit keine ungültigen Resteinträge vorhanden sind. Dazu gehören auch 
			-- die Tooltip-Einträge
			for num = 1, 42 do
				-- TODO: Die 42 in eine Konstante packen
				getglobal("ICalMainFrameDaysDay"..num.."DateLabel"):SetText("");
				getglobal("ICalMainFrameDaysDay"..num.."Texture"):SetAlpha(128);
				getglobal("ICalMainFrameDaysDay"..num.."Texture"):SetTexture("Interface\\Buttons\\UI-EmptySlot-Disabled");
				-- TODO: Anzahl der Texturen als Konstante anlegen
				for resetButtonNum = 1, 9 do
					local resetButton = getglobal(
						"ICalMainFrameDaysDay"
						..num
						.."InstanceButton"
						..resetButtonNum
					);
					local resetButtonTexture = getglobal(
						"ICalMainFrameDaysDay"
						..num
						.."InstanceButton"
						..resetButtonNum
						.."Texture"
					);
					if resetButton ~= nil then
						resetButtonTexture:SetTexture(0, 0, 0, 0);
						resetButton.TooltipText = {};
					end
					
				end
			end
			
			-- Jetzt müssen alle aktuellen DatumsButtons durchlaufen werden und 
			-- der Text korrekt gesetzt werden (jenachdem, wieviele Tage der 
			-- Monat hat).Ausserdem werden beim Durchlauf gleich die Resets 
			-- eingetragen
			-- #################################################################
			
			local instanceResets = self.owner:GetResetList(m, y);
			
			local firstButton;
			firstButton = firstDay - 1;
			for num = 1, daysInMonth do
			
				-- Datumstrext im Button setzen
				local dateLabel = getglobal("ICalMainFrameDaysDay"..(firstButton + num).."DateLabel");
				dateLabel:SetText(num);
				
				-- Die Transparenz des Datumsbuttons runtersetzen, damit er gegenüber 
				-- den unbenutzten Buttons etwas hervorgehoben ist
				local dayBackground  = getglobal("ICalMainFrameDaysDay"..(firstButton + num).."Texture");
				if (y == todayYear) and (m == todayMonth) and (num == todayDay) then
					dayBackground:SetTexture("Interface\\Buttons\\UI-EmptySlot-white");
				end
				dayBackground:SetAlpha(16);
				
				-- Falls für den aktuellen Tag Resets vorhanden sind diese jetzt anzeigen.
				-- Allerdings nur die, die durch den Filter kommen
				if (instanceResets[num] ~= nil) then
					buttonCount = 1;
					for resetCount = 1, table.getn(instanceResets[num]) do
						if (RaidCalendarOptions.Filter == nil)
							or (RaidCalendarOptions.Filter == 1)
							or (instanceResets[num][resetCount].ShortName == RaidCalendarOptions.Filter) then
							local resetButton = getglobal(
								"ICalMainFrameDaysDay"
								..(firstButton + num)
								.."InstanceButton"
								..buttonCount
							);
							local resetButtonTexture = getglobal(
								"ICalMainFrameDaysDay"
								..(firstButton + num)
								.."InstanceButton"
								..buttonCount
								.."Texture");
							resetButtonTexture:SetTexture(instanceResets[num][resetCount].Texture);
							
							-- Die Texte für das Tooltip des Buttons werden im Button selbst gespeichert.
							-- Die Methode ShowTooltip verwendet diese.
							resetButton.TooltipText = { 
								instanceResets[num][resetCount].Name,
								RAIDCLOC_RESET..": "..instanceResets[num][resetCount].Reset[RaidCalendarOptions.Server].ResetTime
							};
							buttonCount = buttonCount + 1;
						end
					end
				end
			end
		end,
		
		--[[
		//######################################################################	
		//# Wird aufgerufen, wenn der Benutzer die Maus über einen
		//# Instanz_Rest-Button bewegt.
		//# Falls ein Tooltip für diesen Button definiert ist, dann wird dieses
		//# angezeigt
		//######################################################################	
		]]
		ShowTooltip = function() 
			
			-- this ist die Referenz auf den Tooltip-Button, für den der
			-- Aufruf dieser Funktion gerade erfolg
			if table.getn(this.TooltipText) > 1 then
				GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
				GameTooltip:AddLine(this.TooltipText[1], 0, 1, 0);
				GameTooltip:AddLine(this.TooltipText[2], 1, 1, 1);
				GameTooltip:Show();
			end
		end,
		
		--[[
		//######################################################################	
		//#
		//######################################################################	
		]]
		OnMouseDown = function(self)
			this:StartMoving();
		end,
		
		--[[
		//######################################################################	
		//#
		//######################################################################	
		]]
		OnMouseUp = function(self)
			this:StopMovingOrSizing();
		end,
		
				
	}, --[[ MainFrame ]]
	
	
	--[[
	//##########################################################################	
	//#
	//##########################################################################
	]]
	OptionsFrame = {
	
		-- Enthält nach der Initialisierung die Einträge für die Filter-Combobox
		FilterOptions = {},
		
		-- Enthält nach der Initialisierung die Einträge für die Server-Combobox
		ServerOptions = {},
		
		--[[
		//######################################################################	
		//#
		//######################################################################	
		]]
		Init = function(self)
		end,
	
		--[[
		//######################################################################	
		//# TODO: Das direkte Referenzieren der 
		//# RaidCalendar-Instanz gefällt mir nicht
		//######################################################################	
		]]
		OptionsFirstDayInitilize = function()
			local info;
			info = {
				text = RAIDCLOC_WEEKDAYS[1],
				func = RaidCalendar.OptionsFrame.OptionsFirstDayOnClick
			};
			UIDropDownMenu_AddButton(info);
			info = {
				text = RAIDCLOC_WEEKDAYS[7],
				func = RaidCalendar.OptionsFrame.OptionsFirstDayOnClick
			};
			UIDropDownMenu_AddButton(info);
		end,

		--[[
		//######################################################################	
		//#
		//######################################################################	
		]]
		OptionsFirstDayOnShow = function(self)
			UIDropDownMenu_Initialize(
				ICalMainFrameFirstDayDropDown, self.OptionsFirstDayInitilize);
			
			if RaidCalendarOptions.MondayIsFirstDay == true then
				UIDropDownMenu_SetSelectedID(ICalMainFrameFirstDayDropDown, 1);
			else
				UIDropDownMenu_SetSelectedID(ICalMainFrameFirstDayDropDown, 2);
			end
			UIDropDownMenu_SetWidth(175, ICalMainFrameFirstDayDropDown);
		end,

		--[[
		//######################################################################	
		//#
		//######################################################################	
		]]
		OptionsFirstDayOnClick = function(self)
			local i = this:GetID();
			UIDropDownMenu_SetSelectedID(ICalMainFrameFirstDayDropDown, i);
			RaidCalendar:DebugMessage(i);
			RaidCalendarOptions.MondayIsFirstDay = (i == 1);
			RaidCalendar.MainFrame:Update();
		end,
		
		
		
		
		--[[
		//######################################################################	
		//#
		//######################################################################	
		]]
		OptionsFilterInitilize = function()
			
			local info = {
				text = RAIDCLOC_OPTIONS_FILTER_ALL,
				func = RaidCalendar.OptionsFrame.OptionsFilterOnClick,
				id = 1,
				instance = nil
			}
			table.insert(RaidCalendar.OptionsFrame.FilterOptions, info);
			UIDropDownMenu_AddButton(info);
				
			for optionNum = 1, table.getn(ICalInstances) do
				local currentInstance = ICalInstances[optionNum];
				info = {
					text = currentInstance.Name,
					func = RaidCalendar.OptionsFrame.OptionsFilterOnClick,
					id = optionNum + 1,
					instance = currentInstance
				}
				
				table.insert(RaidCalendar.OptionsFrame.FilterOptions, info);
				UIDropDownMenu_AddButton(info);
			end;
		end,

		--[[
		//######################################################################	
		//#
		//######################################################################	
		]]
		OptionsFilterOnShow = function(self)
			UIDropDownMenu_Initialize(
				ICalMainFrameFilterDropDown, self.OptionsFilterInitilize);
			UIDropDownMenu_SetWidth(175, ICalMainFrameFilterDropDown);
			for n = 1, table.getn(self.FilterOptions) do
				if self.FilterOptions[n].instance ~= nil then
					if self.FilterOptions[n].instance.ShortName == RaidCalendarOptions.Filter then
						UIDropDownMenu_SetSelectedID(ICalMainFrameFilterDropDown, n);
						return;
					end
				end
			end
			RaidCalendarOptions.Filter = nil;
			UIDropDownMenu_SetSelectedID(ICalMainFrameFilterDropDown, 1);
		end,

		--[[
		//######################################################################	
		//#
		//######################################################################	
		]]
		OptionsFilterOnClick = function(self)
			local i = this:GetID();
			UIDropDownMenu_SetSelectedID(ICalMainFrameFilterDropDown, i);
			if RaidCalendar.OptionsFrame.FilterOptions[i].instance ~= nil then
				RaidCalendarOptions.Filter = RaidCalendar.OptionsFrame.FilterOptions[i].instance.ShortName;
			else 
				RaidCalendarOptions.Filter = nil;
			end
			RaidCalendar.MainFrame:Update();
		end,
		
		
		
		
		--[[
		//######################################################################	
		//#
		//######################################################################	
		]]
		OptionsServersInitilize = function()
			
			for optionNum = 1, table.getn(ICalServers) do
				local currentServer = ICalServers[optionNum];
				info = {
					text = currentServer.Name,
					func = RaidCalendar.OptionsFrame.OptionsServersOnClick,
					id = optionNum,
					server = currentServer
				}
				
				table.insert(RaidCalendar.OptionsFrame.ServerOptions, info);
				UIDropDownMenu_AddButton(info);
			end;
		end,

		--[[
		//######################################################################	
		//#
		//######################################################################	
		]]
		OptionsServersOnShow = function(self)
			
			UIDropDownMenu_Initialize(
				ICalMainFrameServerDropDown, self.OptionsServersInitilize);
			UIDropDownMenu_SetWidth(175, ICalMainFrameServerDropDown);
			for n = 1, table.getn(self.ServerOptions) do
				if self.ServerOptions[n].server ~= nil then
					if self.ServerOptions[n].server.ShortName == RaidCalendarOptions.Server then
						UIDropDownMenu_SetSelectedID(ICalMainFrameServerDropDown, n);
						return;
					end
				end
			end
			RaidCalendarOptions.Server = nil;
			UIDropDownMenu_SetSelectedID(ICalMainFrameServerDropDown, 1);
		end,

		--[[
		//######################################################################	
		//#
		//######################################################################	
		]]
		OptionsServersOnClick = function(self)
			local i = this:GetID();
			UIDropDownMenu_SetSelectedID(ICalMainFrameServerDropDown, i);
			if RaidCalendar.OptionsFrame.ServerOptions[i].server ~= nil then
				RaidCalendarOptions.Server = RaidCalendar.OptionsFrame.ServerOptions[i].server.ShortName;
			else 
				RaidCalendarOptions.Server = nil;
			end
			RaidCalendar.MainFrame:Update();
		end,
	}, --[[ OptionsFrame ]]
	
}; --[[ RaidCalendar ]]