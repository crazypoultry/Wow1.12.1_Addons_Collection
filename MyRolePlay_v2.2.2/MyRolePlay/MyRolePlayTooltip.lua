-- This is the list of global constants that define what kind of information is to be displayed
-- on the current slot in a tooltip.
MRP_EMPTY = 0;
MRP_NEWLINE = 3;
MRP_PREFIX = 4;
MRP_FIRSTNAME = 5;
MRP_MIDDLENAME = 6;
MRP_SURNAME = 7;
MRP_TITLE = 8;
MRP_HOUSENAME = 9;
MRP_NICKNAME = 10;
MRP_GUILDRANK = 11;
MRP_PVPRANK = 12;
MRP_PVPSTATUS = 13;
MRP_LEVEL = 14;
MRP_CLASS = 15;
MRP_RACE = 16;
MRP_RPSTYLE = 17;
MRP_CSSTATUS = 18;
MRP_UNITNAME = 19;
MRP_EYECOLOUR = 20;
MRP_HEIGHT = 21;
MRP_WEIGHT = 22;
MRP_CURRENT_EMOTION = 23;
MRP_HOMECITY = 24;
MRP_BIRTHCITY = 25;
MRP_AGE = 26;
MRP_BIRTHDATE = 27;
MRP_MOTTO = 28;
MRP_GUILD = 29;


mrpPrevOffset = 1;

mrpCurrentRowBeingEdited = nil;

--[[ 
	This next bit of code, MRP_CONDITIONAL_NEWLINE is another global tooltip type. Though it is special.
	It is a table that holds the information to create a conditional. This means that this newline will ONLY
	display IF its conditions are met. Here is an explaination of those conditions:

	Value - The value table holds information that tells the tooltip what to look for. If it finds any of these values
		within its given distance and direction (see below), it will display a newline in the tooltip.
	
	Distance - The amount of lines that the tooltip is to look in relavance to itself for the values.

	Type - 1 means look after the current location by [distance] rows. 0 means look before.
]]
MRP_CONDITIONAL_NEWLINE = {};

MRP_CONDITIONAL_NEWLINE[1] = {};
MRP_CONDITIONAL_NEWLINE[1].Distance = 2;
MRP_CONDITIONAL_NEWLINE[1].Value = {};
MRP_CONDITIONAL_NEWLINE[1].Value[1] = MRP_TITLE;
MRP_CONDITIONAL_NEWLINE[1].Value[2] = MRP_HOUSENAME;
MRP_CONDITIONAL_NEWLINE[1].Type = 0;

MRP_CONDITIONAL_NEWLINE[2] = {};
MRP_CONDITIONAL_NEWLINE[2].Distance = 3;
MRP_CONDITIONAL_NEWLINE[2].Value = {};
MRP_CONDITIONAL_NEWLINE[2].Value[1] = MRP_GUILDRANK;
MRP_CONDITIONAL_NEWLINE[2].Value[2] = MRP_NICKNAME;
MRP_CONDITIONAL_NEWLINE[2].Value[3] = MRP_PVPRANK;
MRP_CONDITIONAL_NEWLINE[2].Type = 0;

MRP_CONDITIONAL_NEWLINE[3] = {};
MRP_CONDITIONAL_NEWLINE[3].Distance = 2;
MRP_CONDITIONAL_NEWLINE[3].Value = {};
MRP_CONDITIONAL_NEWLINE[3].Value[1] = MRP_RPSTYLE;
MRP_CONDITIONAL_NEWLINE[3].Value[2] = MRP_CSSTATUS;
MRP_CONDITIONAL_NEWLINE[3].Type = 0;

--[[ 
	function
	name: mrpDisplayTooltip
	args: Unit target, String mrpFromWhere
	returns: nil;

	Description:
		mrpDisplayTooltip displays a tooltip describing the target chosen by the args.
		This function creates an arithmetically created tooltip. It is not static in any way.
		Depending on where the call came from, the target, and the information in the Order table,
		mrpDisplayTooltip will dynamically create new tooltips.

		Tooltips with this function are displayed in a table format, with rows and columns.
		For example:

		       | Col1 | Col2 | Col3 | Col4
		-------------------------------------
		Row1   | Mrs. |Trilia| Sair | Trinkart
		Row2   | Leader of the Forgotten people
		Row3   |Level |  14  | Priest 
		Row4   | More data
		Row5   | And as much as you want up to 30 (the gametooltip limit)

		Notice how you don't have to have the same number of columns in each row.

		To pass information into this function, you use the foo[row][col] = x format.

	-- args description -- 
	Unit target:
		The Unit you want to display the information for.
		The following Units are handled currently in this function:
			"player"	-- you
			"target"	-- your target
			"mouseover"	-- the object you are mousing over
	
	String mrpFromWhere:
		This is a flag to tell the function where the request for a tooltip is coming from.
		Most calls to mrpDisplayTooltip are from a mouseover. So the appropriate name for mrpFromWhere
		in this case is "MOUSEOVER"
		Possible values:
			"CHATMESSAGE"	-- whenever a chat event calls the function
			"MOUSEOVER"	-- whenever a mouseover event calls the function
			"PLAYER"	-- whenever you call the function on yourself
]]
function mrpDisplayTooltip(target, mrpFromWhere)
	-- If the display tooltips MRP style option is enabled, execute this code.
	if (MyRolePlay.Settings.Tooltip.Enabled == 1) then
		if (UnitIsPlayer(target)) then
			-- Reset the tooltip to be blank.
			mrpResetLines();

			mrpTarget.Identification.Surname = "";
			mrpTarget.Identification.Title = "";
			mrpTarget.Status.Roleplay = "";
			mrpTarget.Status.Character = "";

			mrpTarget.Identification.Firstname = UnitName(target);
			mrpTarget.Identification.Middlename = "";								
			mrpTarget.Identification.Nickname = "";
			mrpTarget.Identification.Housename = "";
			mrpTarget.Identification.DateOfBirth = "";

			mrpTarget.Appearance.EyeColour = "";
			mrpTarget.Appearance.Height = "";
			mrpTarget.Appearance.Weight = "";
			mrpTarget.Appearance.Description1 = "";
			mrpTarget.Appearance.Description2 = "";
			mrpTarget.Appearance.Description3 = "";
			mrpTarget.Appearance.Description4 = "";
			mrpTarget.Appearance.Description5 = "";
			mrpTarget.Appearance.Description6 = "";
			mrpTarget.Appearance.CurrentEmotion = "";

			mrpTarget.Lore.History1 = "";
			mrpTarget.Lore.History2 = "";
			mrpTarget.Lore.History3 = "";
			mrpTarget.Lore.History4 = "";
			mrpTarget.Lore.History5 = "";
			mrpTarget.Lore.History6 = "";
			mrpTarget.Lore.Motto = "";
			mrpTarget.Lore.Homecity = "";
			mrpTarget.Lore.Birthcity = "";

			mrpTarget.Identification.Prefix = "";

			MyRolePlay.Settings.Tooltip.Order.MRPEnabled = true;

			-- Set the anchor to be the same as the regular game tootlip.
			--GameTooltip_SetDefaultAnchor(GameTooltip, UIParent);
			-- The current hack for getting the healthbar to show under the tooltip.
			--GameTooltipStatusBar:Show();
			-- More hacking for the healthbar.
			--getglobal("GameTooltip"):SetScript("OnHide", function() GameTooltip_OnHide() ShoppingTooltip1:Hide() ShoppingTooltip2:Hide() GameTooltipStatusBar:Hide() end);
						
			if (UnitIsFriend("player", target)) then
				local i = nil;
				local j = nil;
				-- mrpTempString is a string that stores the temporary line that is being worked on.
				-- It is reset everytime a new sector is calculated.
				mrpTempString = "";
				local firstRun = 1;
				
				if (mrpFromWhere == "CHATMESSAGE") then -- possible deletion
					MyRolePlay.Settings.Tooltip.Order.MRPEnabled = true; -- possible deletion
					MyRolePlay.Settings.Tooltip.Order.RegularEnabled = false; -- possible deletion
				elseif (mrpFromWhere == "MOUSEOVER") then

					local mrpPlayerIndex = nil;
					local mrpFlagRSPPlayerIndex = nil;
					
					local mrpEnableFlagRSP = false;
					local mrpEnableMRP = false;

					-- Checks to see if target has MyRolePlay
					mrpPlayerIndex = mrpIsPlayerInMRP(target);

					-- Checks to see if target has FlagRSP
					mrpFlagRSPPlayerIndex = mrpIsPlayerInFlagRSP(target);

					local mrpIndexOfChannel = GetChannelName("MyRolePlay");
					local mrpIndexOfFlagRSPChannel = GetChannelName("xtensionxtooltip2");
					
					-- If the player has MyRolePlay, load his/her information into the target.
					if (mrpIndexOfChannel ~= nil and mrpPlayerIndex ~= nil) then
						if (mrpPlayerList[mrpPlayerIndex].HasInfo == true) then
							mrpTarget.Identification.Surname = mrpPlayerList[mrpPlayerIndex].Surname;
							mrpTarget.Identification.Title = mrpPlayerList[mrpPlayerIndex].Title;
							mrpTarget.Status.Roleplay = mrpPlayerList[mrpPlayerIndex].Roleplay;
							mrpTarget.Status.Character = mrpPlayerList[mrpPlayerIndex].Character;

							mrpTarget.Identification.Firstname = mrpPlayerList[mrpPlayerIndex].Firstname;
							mrpTarget.Identification.Middlename = mrpPlayerList[mrpPlayerIndex].Middlename;							
							mrpTarget.Identification.Nickname = mrpPlayerList[mrpPlayerIndex].Nickname;
							mrpTarget.Identification.Housename = mrpPlayerList[mrpPlayerIndex].Housename;
							mrpTarget.Identification.DateOfBirth = "";

							mrpTarget.Appearance.EyeColour = mrpPlayerList[mrpPlayerIndex].EyeColour;
							mrpTarget.Appearance.Height = mrpPlayerList[mrpPlayerIndex].Height;
							mrpTarget.Appearance.Weight = mrpPlayerList[mrpPlayerIndex].Weight;
							mrpTarget.Appearance.Description1 = "";
							mrpTarget.Appearance.Description2 = "";
							mrpTarget.Appearance.Description3 = "";
							mrpTarget.Appearance.Description4 = "";
							mrpTarget.Appearance.Description5 = "";
							mrpTarget.Appearance.Description6 = "";
							mrpTarget.Appearance.CurrentEmotion = mrpPlayerList[mrpPlayerIndex].CurrentEmotion;

							mrpTarget.Lore.History1 = "";
							mrpTarget.Lore.History2 = "";
							mrpTarget.Lore.History3 = "";
							mrpTarget.Lore.History4 = "";
							mrpTarget.Lore.History5 = "";
							mrpTarget.Lore.History6 = "";
							mrpTarget.Lore.Motto = mrpPlayerList[mrpPlayerIndex].Motto;
							mrpTarget.Lore.Homecity = mrpPlayerList[mrpPlayerIndex].Homecity;
							mrpTarget.Lore.Birthcity = mrpPlayerList[mrpPlayerIndex].Birthcity;

							mrpTarget.Identification.Prefix = mrpPlayerList[mrpPlayerIndex].Prefix;

							mrpEnableMRP = true;
						-- elseif the target has MyRolePlay information, grab it.
						elseif (mrpPlayerList[mrpPlayerIndex].HasInfo == false) then
								mrpSendMessage(MRP_GET_INFO);
						end
					-- elseif the player doesn't have MyRolePlay but has FlagRSP, load their data into the target.
					elseif (mrpIndexOfFlagRSPChannel ~= nil and mrpFlagRSPPlayerIndex ~= nil) then
						if (mrpFlagRSPPlayerList[mrpFlagRSPPlayerIndex].HasInfo == true) then
							mrpTarget.Identification.Surname = mrpFlagRSPPlayerList[mrpFlagRSPPlayerIndex].Surname;
							mrpTarget.Identification.Title = mrpFlagRSPPlayerList[mrpFlagRSPPlayerIndex].Title;
							mrpTarget.Status.Roleplay = mrpFlagRSPPlayerList[mrpFlagRSPPlayerIndex].Roleplay;
							mrpTarget.Status.Character = mrpFlagRSPPlayerList[mrpFlagRSPPlayerIndex].Character;

							mrpTarget.Identification.Firstname = UnitName(target);
							mrpTarget.Identification.Middlename = "";								
							mrpTarget.Identification.Nickname = "";
							mrpTarget.Identification.Housename = "";
							mrpTarget.Identification.DateOfBirth = "";

							mrpTarget.Appearance.EyeColour = "";
							mrpTarget.Appearance.Height = "";
							mrpTarget.Appearance.Weight = "";
							mrpTarget.Appearance.Description1 = "";
							mrpTarget.Appearance.Description2 = "";
							mrpTarget.Appearance.Description3 = "";
							mrpTarget.Appearance.Description4 = "";
							mrpTarget.Appearance.Description5 = "";
							mrpTarget.Appearance.Description6 = "";
							mrpTarget.Appearance.CurrentEmotion = "";

							mrpTarget.Lore.History1 = "";
							mrpTarget.Lore.History2 = "";
							mrpTarget.Lore.History3 = "";
							mrpTarget.Lore.History4 = "";
							mrpTarget.Lore.History5 = "";
							mrpTarget.Lore.History6 = "";
							mrpTarget.Lore.Motto = "";
							mrpTarget.Lore.Homecity = "";
							mrpTarget.Lore.Birthcity = "";

							mrpTarget.Identification.Prefix = "";

							mrpEnableFlagRSP = true;
						end					
					-- else - The target is niether a MyRolePlay user or FlagRSP user. Load only UnitName.
					else
						mrpTarget.Identification.Surname = "";
						mrpTarget.Identification.Title = "";
						mrpTarget.Status.Roleplay = "";
						mrpTarget.Status.Character = "";

						mrpTarget.Identification.Firstname = UnitName(target);
						mrpTarget.Identification.Middlename = "";								
						mrpTarget.Identification.Nickname = "";
						mrpTarget.Identification.Housename = "";
						mrpTarget.Identification.DateOfBirth = "";

						mrpTarget.Appearance.EyeColour = "";
						mrpTarget.Appearance.Height = "";
						mrpTarget.Appearance.Weight = "";
						mrpTarget.Appearance.Description1 = "";
						mrpTarget.Appearance.Description2 = "";
						mrpTarget.Appearance.Description3 = "";
						mrpTarget.Appearance.Description4 = "";
						mrpTarget.Appearance.Description5 = "";
						mrpTarget.Appearance.Description6 = "";
						mrpTarget.Appearance.CurrentEmotion = "";

						mrpTarget.Lore.History1 = "";
						mrpTarget.Lore.History2 = "";
						mrpTarget.Lore.History3 = "";
						mrpTarget.Lore.History4 = "";
						mrpTarget.Lore.History5 = "";
						mrpTarget.Lore.History6 = "";
						mrpTarget.Lore.Motto = "";
						mrpTarget.Lore.Homecity = "";
						mrpTarget.Lore.Birthcity = "";

						mrpTarget.Identification.Prefix = "";
					end

					if (mrpEnableFlagRSP == true or mrpEnableMRP == true) then
						MyRolePlay.Settings.Tooltip.Order.MRPEnabled = true;
						MyRolePlay.Settings.Tooltip.Order.RegularEnabled = false;
					elseif (mrpEnableFlagRSP == false and mrpEnableMRP == false) then -- possible deletion
						MyRolePlay.Settings.Tooltip.Order.MRPEnabled = true; -- possible deletion
						MyRolePlay.Settings.Tooltip.Order.RegularEnabled = false; -- possible deletion
					end
				
				-- elseif the call came from the player, you, enable MyRolePlay information displaying
				elseif (mrpFromWhere == "PLAYER") then
					MyRolePlay.Settings.Tooltip.Order.MRPEnabled = false;
					MyRolePlay.Settings.Tooltip.Order.RegularEnabled = false;
				end

				-- if target is a MyRolePlay user, display a MyRolePlay style tooltip.
				if (MyRolePlay.Settings.Tooltip.Order.MRPEnabled == true) then
					-- Grab the rank only of the target.
					mrpSetTargetFactionRank(mrpFromWhere);

					-- Begin iterating through the rows.
					for i = 1, table.getn(MyRolePlay.Settings.Tooltip.Order.MRP) do
						-- reset the tempstring to nothing.
						mrpTempString = "";
						-- Begin iterating through the columns of the current row.
						for j = 1, table.getn(MyRolePlay.Settings.Tooltip.Order.MRP[i]) do
							-- The string for the current column in the current row.
							-- Assign its value and colour via this function,
							-- passing in the current state of the table.
							mrpSecondTempString = mrpAssessTooltipInfo("MRP", i, j, target);
							-- If there was information about the target for this column,
							-- add it's information to the row string.
							if (mrpSecondTempString ~= "") then
								mrpTempString = mrpTempString .. mrpSecondTempString;
							end						
						end
						
						-- If it is the first line of the tooltip, use its larger font.
						-- Add the row to the tooltip.
						if (firstRun == 1) then
							if (mrpTempString ~= "") then
								GameTooltipTextLeft1:SetText(mrpTempString);
								firstRun = 0;
							end
						else
							if (mrpTempString ~= "") then
								GameTooltip:AddLine(mrpTempString);
							end
						end
					end
				-- elseif target is not a MyRolePlay user, display a regular style tooltip. -- possible deletion.
				elseif (MyRolePlay.Settings.Tooltip.Order.RegularEnabled == true) then
					-- Grab the rank only of the target.
					mrpSetTargetFactionRank(mrpFromWhere);

					for i = 1, table.getn(MyRolePlay.Settings.Tooltip.Order.Regular) do
						mrpTempString = "";
						for j = 1, table.getn(MyRolePlay.Settings.Tooltip.Order.Regular[i]) do
							mrpSecondTempString = mrpAssessTooltipInfo("Regular", i, j, target);
							if (mrpSecondTempString ~= "") then
								mrpTempString = mrpTempString .. mrpSecondTempString;
							end						
						end
						if (firstRun == 1) then
							if (mrpTempString ~= "") then
								GameTooltipTextLeft1:SetText(mrpTempString);
								firstRun = 0;
							end
						else
							if (mrpTempString ~= "") then
								GameTooltip:AddLine(mrpTempString);
							end
						end
					end
				-- elseif target is you, display all your information, without trying to request it in the channel.
				elseif (MyRolePlay.Settings.Tooltip.Order.RegularEnabled == false and MyRolePlay.Settings.Tooltip.Order.MRPEnabled == false) then
					-- Grab the rank only of the target.
					mrpSetTargetFactionRank(mrpFromWhere);

					mrpTarget.Identification = MyRolePlay.Identification;
					mrpTarget.Appearance = MyRolePlay.Appearance;
					mrpTarget.Lore = MyRolePlay.Lore;
					mrpTarget.Status = MyRolePlay.Status;
					mrpSetTargetFactionRank(mrpFromWhere);

					--GameTooltipTextLeft1:SetText("");
					--GameTooltipTextRight1:SetText("");

					for i = 1, table.getn(MyRolePlay.Settings.Tooltip.Order.MRP) do
						mrpTempString = "";
						for j = 1, table.getn(MyRolePlay.Settings.Tooltip.Order.MRP[i]) do
							mrpSecondTempString = mrpAssessTooltipInfo("MRP", i, j, target);
							if (mrpSecondTempString ~= "") then
								mrpTempString = mrpTempString .. mrpSecondTempString;
							end						
						end
						if (firstRun == 1) then
							if (mrpTempString ~= "") then
								GameTooltip:SetText(mrpTempString);
								firstRun = 0;
							end
						else
							if (mrpTempString ~= "") then
								GameTooltip:AddLine(mrpTempString);
							end
						end
					end

					mrpTarget.Identification = {};
					mrpTarget.Appearance = {};
					mrpTarget.Lore = {};
					mrpTarget.Status = {};
				end
			elseif (UnitIsEnemy("player", target)) then
				-- Grab the rank only of the target.
				mrpSetTargetFactionRank(mrpFromWhere);


				local i = nil;
				local j = nil;
				-- mrpTempString is a string that stores the temporary line that is being worked on.
				-- It is reset everytime a new sector is calculated.
				mrpTempString = "";
				local firstRun = 1;

				mrpTarget.Identification.Surname = "";
				mrpTarget.Identification.Title = "";
				mrpTarget.Status.Roleplay = "";
				mrpTarget.Status.Character = "";

				mrpTarget.Identification.Firstname = UnitName(target);
				mrpTarget.Identification.Middlename = "";								
				mrpTarget.Identification.Nickname = "";
				mrpTarget.Identification.Housename = "";
				mrpTarget.Identification.DateOfBirth = "";

				mrpTarget.Appearance.EyeColour = "";
				mrpTarget.Appearance.Height = "";
				mrpTarget.Appearance.Weight = "";
				mrpTarget.Appearance.Description1 = "";
				mrpTarget.Appearance.Description2 = "";
				mrpTarget.Appearance.Description3 = "";
				mrpTarget.Appearance.Description4 = "";
				mrpTarget.Appearance.Description5 = "";
				mrpTarget.Appearance.Description6 = "";
				mrpTarget.Appearance.CurrentEmotion = "";

				mrpTarget.Lore.History1 = "";
				mrpTarget.Lore.History2 = "";
				mrpTarget.Lore.History3 = "";
				mrpTarget.Lore.History4 = "";
				mrpTarget.Lore.History5 = "";
				mrpTarget.Lore.History6 = "";
				mrpTarget.Lore.Motto = "";
				mrpTarget.Lore.Homecity = "";
				mrpTarget.Lore.Birthcity = "";

				mrpTarget.Identification.Prefix = "";

				for i = 1, table.getn(MyRolePlay.Settings.Tooltip.Order.MRP) do
					mrpTempString = "";
					for j = 1, table.getn(MyRolePlay.Settings.Tooltip.Order.MRP[i]) do
						mrpSecondTempString = mrpAssessTooltipInfo("MRP", i, j, target);
						if (mrpSecondTempString ~= "") then
							mrpTempString = mrpTempString .. mrpSecondTempString;
						end						
					end
					if (firstRun == 1) then
						if (mrpTempString ~= "") then
							GameTooltipTextLeft1:SetText(mrpTempString);
							firstRun = 0;
						end
					else
						if (mrpTempString ~= "") then
							GameTooltip:AddLine(mrpTempString);
						end
					end
				end
			end
			GameTooltip:Show();
		end
	end
end

--[[
	function
	name: mrpAssessTooltipInfo
	args: string mrpOrderType, int i, int j, Unit target
	returns: string

	Description:
		This function takes the data specified in a table but looking at row i and column j of the Order table of
		Order mrpOrderType and return a string with the information that the Order table told it to find.
		Most of the options here are fairly simple. A few are not though, and they are documented.

	-- args description -- 
	string mrpOrderType:
		This string determines the order which the tooltip is to be diplayed from the Order table.
	
	int i:
		The current row.

	int j:
		The current column.
	
	Unit target:
		The Unit you want to display the information for.
		The following Units are handled currently in this function:
			"player"	-- you
			"mouseover"	-- the object you are mousing over
	
	-- return description --
	This function returns many possible strings. Most are colour formatted with the options that the
	user has specified in the settings. Some returns have special meaning.

	return (" ")
		This is a newline.

	return ("")
		This is essentially a null. The function that this returns this string to will see a "" (a blank string)
		and then not add its information to the tooltip.
]]
function mrpAssessTooltipInfo(mrpOrderType, i, j, target)
	if (MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j] == MRP_NEWLINE) then
		return (" ");
	end

	-- This for loop handles the conditional newline. This means that it will only add a new line IF its condition is met.
	-- This is explained at the top of this lua file.
	for newlineCheck = 1, table.getn(MRP_CONDITIONAL_NEWLINE) do
		if (type(MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j]) == "table" and MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j].Value ~= nil and MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j].Value[1] == MRP_CONDITIONAL_NEWLINE[newlineCheck].Value[1]) then
			for curDistance = 1, MRP_CONDITIONAL_NEWLINE[newlineCheck].Distance do
				if (MRP_CONDITIONAL_NEWLINE[newlineCheck].Type == 0) then
					for column = 1, table.getn(MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i - curDistance]) do
						for curValue = 1, table.getn(MRP_CONDITIONAL_NEWLINE[newlineCheck].Value) do
							if (MRP_CONDITIONAL_NEWLINE[newlineCheck].Value[curValue] == MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i - curDistance][column] and mrpAssessTooltipInfo(mrpOrderType, i - curDistance, column, target) ~= "") then
								return (" ");					
							end
						end				
					end
				else
					for column = 1, table.getn(MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i + curDistance]) do
						for curValue = 1, table.getn(MRP_CONDITIONAL_NEWLINE[newlineCheck].Value) do
							if (MRP_CONDITIONAL_NEWLINE[newlineCheck].Value[curValue] == MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i + curDistance][column] and mrpAssessTooltipInfo(mrpOrderType, i + curDistance, column, target) ~= "") then
								return (" ");					
							end
						end				
					end
				end					
			end
			
			return ("");
		end
	end
	for textCheck = 1, table.getn(MyRolePlay.Settings.Tooltip.Order.MRP_TEXT) do
		if (type(MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j]) == "table" and MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j].Text == MyRolePlay.Settings.Tooltip.Order.MRP_TEXT[textCheck].Text) then
			if (MyRolePlay.Settings.Tooltip.Order.MRP_TEXT[textCheck].BoA == MRP_TOOLTIP_TEXT_BEFORE) then
				if (MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j - 1] ~= nil) then
					if (mrpAssessTooltipInfo(mrpOrderType, i, j - 1, target) ~= "") then
						return (mrpHexStart .. mrpColourToHex(MyRolePlay.Settings.Tooltip.Order.MRP_TEXT[textCheck].Colours.red, MyRolePlay.Settings.Tooltip.Order.MRP_TEXT[textCheck].Colours.green, MyRolePlay.Settings.Tooltip.Order.MRP_TEXT[textCheck].Colours.blue) .. MyRolePlay.Settings.Tooltip.Order.MRP_TEXT[textCheck].Text .. mrpHexEnd);
					end
				end
			elseif (MyRolePlay.Settings.Tooltip.Order.MRP_TEXT[textCheck].BoA == MRP_TOOLTIP_TEXT_AFTER) then
				if (MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j + 1] ~= nil) then
					if (mrpAssessTooltipInfo(mrpOrderType, i, j + 1, target) ~= "") then
						return (mrpHexStart .. mrpColourToHex(MyRolePlay.Settings.Tooltip.Order.MRP_TEXT[textCheck].Colours.red, MyRolePlay.Settings.Tooltip.Order.MRP_TEXT[textCheck].Colours.green, MyRolePlay.Settings.Tooltip.Order.MRP_TEXT[textCheck].Colours.blue) .. MyRolePlay.Settings.Tooltip.Order.MRP_TEXT[textCheck].Text .. mrpHexEnd);
					end
				end
			elseif (MyRolePlay.Settings.Tooltip.Order.MRP_TEXT[textCheck].BoA == MRP_TOOLTIP_TEXT_ALWAYS) then
				return (mrpHexStart .. mrpColourToHex(MyRolePlay.Settings.Tooltip.Order.MRP_TEXT[textCheck].Colours.red, MyRolePlay.Settings.Tooltip.Order.MRP_TEXT[textCheck].Colours.green, MyRolePlay.Settings.Tooltip.Order.MRP_TEXT[textCheck].Colours.blue) .. MyRolePlay.Settings.Tooltip.Order.MRP_TEXT[textCheck].Text .. mrpHexEnd);

			elseif (MyRolePlay.Settings.Tooltip.Order.MRP_TEXT[textCheck].BoA == MRP_TOOLTIP_TEXT_BOTH) then
				if (MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j + 1] ~= nil and MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j - 1] ~= nil) then
					if (mrpAssessTooltipInfo(mrpOrderType, i, j + 1, target) ~= ""and mrpAssessTooltipInfo(mrpOrderType, i, j - 1, target) ~= "") then
						return (mrpHexStart .. mrpColourToHex(MyRolePlay.Settings.Tooltip.Order.MRP_TEXT[textCheck].Colours.red, MyRolePlay.Settings.Tooltip.Order.MRP_TEXT[textCheck].Colours.green, MyRolePlay.Settings.Tooltip.Order.MRP_TEXT[textCheck].Colours.blue) .. MyRolePlay.Settings.Tooltip.Order.MRP_TEXT[textCheck].Text .. mrpHexEnd);
					end
				end
			end
			
			return ("");
		end
	end
	if (MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j] == MRP_PREFIX) then
		if (mrpTarget.Identification.Prefix ~= "") then
			if (UnitCanAttack(target, "player")) then
				return (mrpHexStart .. mrpColourToHex(MyRolePlay.Settings.Colours.EnemyPvpHostile.red, MyRolePlay.Settings.Colours.EnemyPvpHostile.green, MyRolePlay.Settings.Colours.EnemyPvpHostile.blue) .. mrpTarget.Identification.Prefix .. " " .. mrpHexEnd);
			elseif (UnitCanAttack("player", target)) then
				return (mrpHexStart .. mrpColourToHex(MyRolePlay.Settings.Colours.EnemyPvpNotHostile.red, MyRolePlay.Settings.Colours.EnemyPvpNotHostile.green, MyRolePlay.Settings.Colours.EnemyPvpNotHostile.blue) .. mrpTarget.Identification.Prefix .. " " .. mrpHexEnd);
			end
			if (UnitIsPVP(target)) then
				return (mrpHexStart .. mrpColourToHex(MyRolePlay.Settings.Colours.PrefixPvp.red, MyRolePlay.Settings.Colours.PrefixPvp.green, MyRolePlay.Settings.Colours.PrefixPvp.blue) .. mrpTarget.Identification.Prefix .. " " .. mrpHexEnd);
			else
				return (mrpHexStart .. mrpColourToHex(MyRolePlay.Settings.Colours.PrefixNonPvp.red, MyRolePlay.Settings.Colours.PrefixNonPvp.green, MyRolePlay.Settings.Colours.PrefixNonPvp.blue) .. mrpTarget.Identification.Prefix .. " " .. mrpHexEnd);
			end
		end
		return ("");
	end
	if (MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j] == MRP_FIRSTNAME) then
		if (mrpTarget.Identification.Firstname ~= "") then
			if (UnitCanAttack(target, "player")) then
				return (mrpHexStart .. mrpColourToHex(MyRolePlay.Settings.Colours.EnemyPvpHostile.red, MyRolePlay.Settings.Colours.EnemyPvpHostile.green, MyRolePlay.Settings.Colours.EnemyPvpHostile.blue) .. mrpTarget.Identification.Firstname .. " " .. mrpHexEnd);
			elseif (UnitCanAttack("player", target)) then
				return (mrpHexStart .. mrpColourToHex(MyRolePlay.Settings.Colours.EnemyPvpNotHostile.red, MyRolePlay.Settings.Colours.EnemyPvpNotHostile.green, MyRolePlay.Settings.Colours.EnemyPvpNotHostile.blue) .. mrpTarget.Identification.Firstname .. " " .. mrpHexEnd);
			end
			if (UnitIsPVP(target)) then
				return (mrpHexStart .. mrpColourToHex(MyRolePlay.Settings.Colours.FirstnamePvp.red, MyRolePlay.Settings.Colours.FirstnamePvp.green, MyRolePlay.Settings.Colours.FirstnamePvp.blue) .. mrpTarget.Identification.Firstname .. " " .. mrpHexEnd);	
			else
				return (mrpHexStart .. mrpColourToHex(MyRolePlay.Settings.Colours.FirstnameNonPvp.red, MyRolePlay.Settings.Colours.FirstnameNonPvp.green, MyRolePlay.Settings.Colours.FirstnameNonPvp.blue) .. mrpTarget.Identification.Firstname .. " " .. mrpHexEnd);
			end
		end
		return ("");
	end
	if (MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j] == MRP_MIDDLENAME) then
		if (mrpTarget.Identification.Middlename ~= "") then
			if (UnitCanAttack(target, "player")) then
				return (mrpHexStart .. mrpColourToHex(MyRolePlay.Settings.Colours.EnemyPvpHostile.red, MyRolePlay.Settings.Colours.EnemyPvpHostile.green, MyRolePlay.Settings.Colours.EnemyPvpHostile.blue) .. mrpTarget.Identification.Middlename .. " " .. mrpHexEnd);
			elseif (UnitCanAttack("player", target)) then
				return (mrpHexStart .. mrpColourToHex(MyRolePlay.Settings.Colours.EnemyPvpNotHostile.red, MyRolePlay.Settings.Colours.EnemyPvpNotHostile.green, MyRolePlay.Settings.Colours.EnemyPvpNotHostile.blue) .. mrpTarget.Identification.Middlename .. " " .. mrpHexEnd);
			end
			if (UnitIsPVP(target)) then
				return (mrpHexStart .. mrpColourToHex(MyRolePlay.Settings.Colours.MiddlenamePvp.red, MyRolePlay.Settings.Colours.MiddlenamePvp.green, MyRolePlay.Settings.Colours.MiddlenamePvp.blue) .. mrpTarget.Identification.Middlename .. " " .. mrpHexEnd);	
			else
				return (mrpHexStart .. mrpColourToHex(MyRolePlay.Settings.Colours.MiddlenameNonPvp.red, MyRolePlay.Settings.Colours.MiddlenameNonPvp.green, MyRolePlay.Settings.Colours.MiddlenameNonPvp.blue) .. mrpTarget.Identification.Middlename .. " " .. mrpHexEnd);
			end
		end
		return ("");
	end
	if (MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j] == MRP_SURNAME) then
		if (mrpTarget.Identification.Surname ~= "") then
			if (UnitCanAttack(target, "player")) then
				return (mrpHexStart .. mrpColourToHex(MyRolePlay.Settings.Colours.EnemyPvpHostile.red, MyRolePlay.Settings.Colours.EnemyPvpHostile.green, MyRolePlay.Settings.Colours.EnemyPvpHostile.blue) .. mrpTarget.Identification.Surname .. " " .. mrpHexEnd);
			elseif (UnitCanAttack("player", target)) then
				return (mrpHexStart .. mrpColourToHex(MyRolePlay.Settings.Colours.EnemyPvpNotHostile.red, MyRolePlay.Settings.Colours.EnemyPvpNotHostile.green, MyRolePlay.Settings.Colours.EnemyPvpNotHostile.blue) .. mrpTarget.Identification.Surname .. " " .. mrpHexEnd);
			end
			if (UnitIsPVP(target)) then
				return (mrpHexStart .. mrpColourToHex(MyRolePlay.Settings.Colours.SurnamePvp.red, MyRolePlay.Settings.Colours.SurnamePvp.green, MyRolePlay.Settings.Colours.SurnamePvp.blue) .. mrpTarget.Identification.Surname .. " " .. mrpHexEnd);	
			else
				return (mrpHexStart .. mrpColourToHex(MyRolePlay.Settings.Colours.SurnameNonPvp.red, MyRolePlay.Settings.Colours.SurnameNonPvp.green, MyRolePlay.Settings.Colours.SurnameNonPvp.blue) .. mrpTarget.Identification.Surname .. " " .. mrpHexEnd);
			end
		end
		return ("");
	end
	if (MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j] == MRP_TITLE) then
		if (mrpTarget.Identification.Title ~= "") then
			return (mrpHexStart .. mrpColourToHex(MyRolePlay.Settings.Colours.Title.red, MyRolePlay.Settings.Colours.Title.green, MyRolePlay.Settings.Colours.Title.blue) .. mrpTarget.Identification.Title .. " " .. mrpHexEnd);
		end
		return ("");
	end
	if (MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j] == MRP_HOUSENAME) then
		if (mrpTarget.Identification.Housename ~= "") then
			return (mrpHexStart .. mrpColourToHex(MyRolePlay.Settings.Colours.HouseName.red, MyRolePlay.Settings.Colours.HouseName.green, MyRolePlay.Settings.Colours.HouseName.blue) .. mrpTarget.Identification.Housename .. " " .. mrpHexEnd);
		end
		return ("");
	end
	if (MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j] == MRP_NICKNAME) then
		if (mrpTarget.Identification.Nickname ~= "") then
			return (mrpHexStart .. mrpColourToHex(MyRolePlay.Settings.Colours.Nickname.red, MyRolePlay.Settings.Colours.Nickname.green, MyRolePlay.Settings.Colours.Nickname.blue) .. mrpTarget.Identification.Nickname .. " " .. mrpHexEnd);
		end
		return ("");
	end
	if (MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j] == MRP_GUILDRANK) then
		mrpTargetGuildName, mrpTargetGuildRank = GetGuildInfo(target);
		if (mrpTargetGuildName ~= nil) then
			return (mrpHexStart .. mrpColourToHex(MyRolePlay.Settings.Colours.Guild.red, MyRolePlay.Settings.Colours.Guild.green, MyRolePlay.Settings.Colours.Guild.blue) .. mrpTargetGuildRank .. mrpHexEnd);
		end
		return ("");
	end
	if (MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j] == MRP_GUILD) then
		mrpTargetGuildName, mrpTargetGuildRank = GetGuildInfo(target);
		if (mrpTargetGuildName ~= nil) then
			return (mrpHexStart .. mrpColourToHex(MyRolePlay.Settings.Colours.Guild.red, MyRolePlay.Settings.Colours.Guild.green, MyRolePlay.Settings.Colours.Guild.blue) .. mrpTargetGuildName .. mrpHexEnd);
		end
		return ("");
	end
	if (MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j] == MRP_PVPRANK) then
		if (UnitPlayerControlled(target)) then
			mrpTargetFaction = UnitFactionGroup(target);
			if (mrpTarget.Identification.FactionRank ~= "") then
				if (mrpTargetFaction == "Horde") then
					return (mrpHexStart .. mrpColourToHex(MyRolePlay.Settings.Colours.FactionHorde.red, MyRolePlay.Settings.Colours.FactionHorde.green, MyRolePlay.Settings.Colours.FactionHorde.blue) .. mrpTarget.Identification.FactionRank .. " of the " .. mrpTargetFaction .. " " .. mrpHexEnd);
				else
					return (mrpHexStart .. mrpColourToHex(MyRolePlay.Settings.Colours.FactionAlliance.red, MyRolePlay.Settings.Colours.FactionAlliance.green, MyRolePlay.Settings.Colours.FactionAlliance.blue) .. mrpTarget.Identification.FactionRank .. " of the " .. mrpTargetFaction .. " " .. mrpHexEnd);
				end
			end
		end		
		return ("");
	end
	if (MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j] == MRP_PVPSTATUS) then
		if (UnitIsPVP(target)) then
			if (UnitIsEnemy(target, "player")) then
				return (mrpHexStart .. mrpColourToHex(MyRolePlay.Settings.Colours.EnemyPvp.red, MyRolePlay.Settings.Colours.EnemyPvp.green, MyRolePlay.Settings.Colours.EnemyPvp.blue) .. "PvP" .. " " .. mrpHexEnd);
			elseif (UnitIsFriend(target, "player")) then
				return (mrpHexStart .. mrpColourToHex(MyRolePlay.Settings.Colours.FriendlyPvp.red, MyRolePlay.Settings.Colours.FriendlyPvp.green, MyRolePlay.Settings.Colours.FriendlyPvp.blue) .. "PvP" .. " " .. mrpHexEnd);
			end
		else
			return ("");
		end
		return ("");
	end
	if (MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j] == MRP_LEVEL) then
		if (MyRolePlay.Settings.Relative == 1) then
			return (mrpHexStart .. mrpColourToHex(MyRolePlay.Settings.Colours.Level.red, MyRolePlay.Settings.Colours.Level.green, MyRolePlay.Settings.Colours.Level.blue) .. mrpRelativeLevelCheck(UnitLevel(target)) .. " " .. mrpHexEnd);
		else
			if (UnitLevel(target) > -1) then
				return (mrpHexStart .. mrpColourToHex(MyRolePlay.Settings.Colours.Level.red, MyRolePlay.Settings.Colours.Level.green, MyRolePlay.Settings.Colours.Level.blue) .. "Level " .. UnitLevel(target) .. " " .. mrpHexEnd);
			else
				return (mrpHexStart .. mrpColourToHex(MyRolePlay.Settings.Colours.Level.red, MyRolePlay.Settings.Colours.Level.green, MyRolePlay.Settings.Colours.Level.blue) .. "Level ?? " .. mrpHexEnd);
			end
		end
		return ("");
	end
	if (MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j] == MRP_CLASS) then
		if (MyRolePlay.Settings.ColourClassSpecific == 1) then
			return (mrpHexStart .. mrpColourToHex(MyRolePlay.Settings.Colours.ClassSpecific[UnitClass(target)].red, MyRolePlay.Settings.Colours.ClassSpecific[UnitClass(target)].green, MyRolePlay.Settings.Colours.ClassSpecific[UnitClass(target)].blue) .. UnitClass(target) .. " " .. mrpHexEnd);
		else
			return (mrpHexStart .. mrpColourToHex(MyRolePlay.Settings.Colours.Class.red, MyRolePlay.Settings.Colours.Class.green, MyRolePlay.Settings.Colours.Class.blue) .. UnitClass(target) .. " " .. mrpHexEnd);
		end
	end
	if (MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j] == MRP_RACE) then
		return (mrpHexStart .. mrpColourToHex(MyRolePlay.Settings.Colours.Race.red, MyRolePlay.Settings.Colours.Race.green, MyRolePlay.Settings.Colours.Race.blue) .. UnitRace(target) .. " " .. mrpHexEnd);
	end
	if (MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j] == MRP_RPSTYLE) then
		if (mrpTarget.Status.Roleplay ~= "") then
			return (mrpHexStart .. mrpColourToHex(MyRolePlay.Settings.Colours.Roleplay.red, MyRolePlay.Settings.Colours.Roleplay.green, MyRolePlay.Settings.Colours.Roleplay.blue) .. mrpDecodeStatus(mrpTarget.Status.Roleplay) .. " " .. mrpHexEnd);
		end
		return ("");
	end
	if (MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j] == MRP_CSSTATUS) then
		if (mrpTarget.Status.Character ~= "") then
			return (mrpHexStart .. mrpColourToHex(MyRolePlay.Settings.Colours.CharacterStat.red, MyRolePlay.Settings.Colours.CharacterStat.green, MyRolePlay.Settings.Colours.CharacterStat.blue) .. mrpDecodeStatus(mrpTarget.Status.Character) .. " " .. mrpHexEnd);
		end
		return ("");
	end
	if (MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j] == MRP_UNITNAME) then
		if (UnitCanAttack(target, "player")) then
			return (mrpHexStart .. mrpColourToHex(MyRolePlay.Settings.Colours.EnemyPvpHostile.red, MyRolePlay.Settings.Colours.EnemyPvpHostile.green, MyRolePlay.Settings.Colours.EnemyPvpHostile.blue) .. UnitName(target) .. " " .. mrpHexEnd);
		elseif (UnitCanAttack("player", target)) then
			return (mrpHexStart .. mrpColourToHex(MyRolePlay.Settings.Colours.EnemyPvpNotHostile.red, MyRolePlay.Settings.Colours.EnemyPvpNotHostile.green, MyRolePlay.Settings.Colours.EnemyPvpNotHostile.blue) .. UnitName(target) .. " " .. mrpHexEnd);
		end
		if (UnitIsPVP(target)) then
			if (UnitIsEnemy(target, "player")) then
				return (mrpHexStart .. mrpColourToHex(MyRolePlay.Settings.Colours.EnemyPvpNotHostile.red, MyRolePlay.Settings.Colours.EnemyPvpNotHostile.green, MyRolePlay.Settings.Colours.EnemyPvpNotHostile.blue) .. UnitName(target) .. " " .. mrpHexEnd);
			elseif (UnitIsFriend(target, "player")) then
				return (mrpHexStart .. mrpColourToHex(MyRolePlay.Settings.Colours.FirstnamePvp.red, MyRolePlay.Settings.Colours.FirstnamePvp.green, MyRolePlay.Settings.Colours.FirstnamePvp.blue) .. UnitName(target) .. " " .. mrpHexEnd);
			end
		else
			return (mrpHexStart .. mrpColourToHex(MyRolePlay.Settings.Colours.FirstnameNonPvp.red, MyRolePlay.Settings.Colours.FirstnameNonPvp.green, MyRolePlay.Settings.Colours.FirstnameNonPvp.blue) .. UnitName(target) .. " " .. mrpHexEnd);
		end
		return ("");
	end
	if (MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j] == MRP_EYECOLOUR) then
		if (mrpTarget.Appearance.EyeColour ~= "") then
			return (MRP_LOCALE_Eye_Colour_TT .. mrpTarget.Appearance.EyeColour .. " ");
		end
	end
	if (MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j] == MRP_HEIGHT) then
		if (mrpTarget.Appearance.Height ~= "") then
			return (MRP_LOCALE_Stands_TT .. mrpTarget.Appearance.Height .. " ");
		end
	end
	if (MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j] == MRP_WEIGHT) then
		if (mrpTarget.Appearance.Weight ~= "") then
			return (MRP_LOCALE_Weighs_TT .. mrpTarget.Appearance.Weight .. " ");
		end
	end
	if (MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j] == MRP_CURRENT_EMOTION) then
		if (mrpTarget.Appearance.CurrentEmotion ~= "") then
			return (MRP_LOCALE_Current_Emotion_TT .. mrpTarget.Appearance.CurrentEmotion .. " ");
		end
	end
	if (MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j] == MRP_HOMECITY) then
		if (mrpTarget.Lore.Homecity ~= "") then
			return (MRP_LOCALE_Home_TT .. mrpTarget.Lore.Homecity .. " ");
		end
	end
	if (MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j] == MRP_BIRTHCITY) then
		if (mrpTarget.Lore.Birthcity ~= "") then
			return (MRP_LOCALE_Born_TT .. mrpTarget.Lore.Birthcity .. " ");
		end
	end
	if (MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j] == MRP_AGE) then
		
	end
	if (MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j] == MRP_BIRTHDATE) then
		
	end
	if (MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j] == MRP_MOTTO) then
		if (mrpTarget.Lore.Motto ~= "") then
			return (MRP_LOCALE_Motto_TT .. mrpTarget.Lore.Motto .. " ");
		end
	end

	-- If it didn't find any of these options, make sure nothing is displayed in the column.
	return ("");
end


--[[
	function
	name: mrpResetLinse
	args: nil
	return: nil

	Description:
		This simple function resets each of the fontstrings in GameTooltip to nil and then hides them.
		This is done instead of ClearLines() because of some new issues with patch 1.10
]]
function mrpResetLines()
	
	GameTooltipTextLeft1:SetText(nil);
	GameTooltipTextLeft2:SetText(nil);
	GameTooltipTextLeft3:SetText(nil);
	GameTooltipTextLeft4:SetText(nil);
	GameTooltipTextLeft5:SetText(nil);
	GameTooltipTextLeft6:SetText(nil);
	GameTooltipTextLeft7:SetText(nil);
	GameTooltipTextLeft8:SetText(nil);
	GameTooltipTextLeft9:SetText(nil);
	GameTooltipTextLeft10:SetText(nil);
	GameTooltipTextLeft11:SetText(nil);
	GameTooltipTextLeft12:SetText(nil);
	GameTooltipTextLeft13:SetText(nil);
	GameTooltipTextLeft14:SetText(nil);
	GameTooltipTextLeft15:SetText(nil);
	GameTooltipTextLeft16:SetText(nil);
	GameTooltipTextLeft17:SetText(nil);
	GameTooltipTextLeft18:SetText(nil);
	GameTooltipTextLeft19:SetText(nil);
	GameTooltipTextLeft20:SetText(nil);
	GameTooltipTextLeft21:SetText(nil);
	GameTooltipTextLeft22:SetText(nil);
	GameTooltipTextLeft23:SetText(nil);
	GameTooltipTextLeft24:SetText(nil);
	GameTooltipTextLeft25:SetText(nil);
	GameTooltipTextLeft26:SetText(nil);
	GameTooltipTextLeft27:SetText(nil);
	GameTooltipTextLeft28:SetText(nil);
	GameTooltipTextLeft29:SetText(nil);
	GameTooltipTextLeft30:SetText(nil);

	GameTooltipTextRight1:SetText(nil);
	GameTooltipTextRight2:SetText(nil);
	GameTooltipTextRight3:SetText(nil);
	GameTooltipTextRight4:SetText(nil);
	GameTooltipTextRight5:SetText(nil);
	GameTooltipTextRight6:SetText(nil);
	GameTooltipTextRight7:SetText(nil);
	GameTooltipTextRight8:SetText(nil);
	GameTooltipTextRight9:SetText(nil);
	GameTooltipTextRight10:SetText(nil);
	GameTooltipTextRight11:SetText(nil);
	GameTooltipTextRight12:SetText(nil);
	GameTooltipTextRight13:SetText(nil);
	GameTooltipTextRight14:SetText(nil);
	GameTooltipTextRight15:SetText(nil);
	GameTooltipTextRight16:SetText(nil);
	GameTooltipTextRight17:SetText(nil);
	GameTooltipTextRight18:SetText(nil);
	GameTooltipTextRight19:SetText(nil);
	GameTooltipTextRight20:SetText(nil);
	GameTooltipTextRight21:SetText(nil);
	GameTooltipTextRight22:SetText(nil);
	GameTooltipTextRight23:SetText(nil);
	GameTooltipTextRight24:SetText(nil);
	GameTooltipTextRight25:SetText(nil);
	GameTooltipTextRight26:SetText(nil);
	GameTooltipTextRight27:SetText(nil);
	GameTooltipTextRight28:SetText(nil);
	GameTooltipTextRight29:SetText(nil);
	GameTooltipTextRight30:SetText(nil);


	--GameTooltipTextLeft1:Hide();
	GameTooltipTextLeft2:Hide();
	GameTooltipTextLeft3:Hide();
	GameTooltipTextLeft4:Hide();
	GameTooltipTextLeft5:Hide();
	GameTooltipTextLeft6:Hide();
	GameTooltipTextLeft7:Hide();
	GameTooltipTextLeft8:Hide();
	GameTooltipTextLeft9:Hide();
	GameTooltipTextLeft10:Hide();
	GameTooltipTextLeft11:Hide();
	GameTooltipTextLeft12:Hide();
	GameTooltipTextLeft13:Hide();
	GameTooltipTextLeft14:Hide();
	GameTooltipTextLeft15:Hide();
	GameTooltipTextLeft16:Hide();
	GameTooltipTextLeft17:Hide();
	GameTooltipTextLeft18:Hide();
	GameTooltipTextLeft19:Hide();
	GameTooltipTextLeft20:Hide();
	GameTooltipTextLeft21:Hide();
	GameTooltipTextLeft22:Hide();
	GameTooltipTextLeft23:Hide();
	GameTooltipTextLeft24:Hide();
	GameTooltipTextLeft25:Hide();
	GameTooltipTextLeft26:Hide();
	GameTooltipTextLeft27:Hide();
	GameTooltipTextLeft28:Hide();
	GameTooltipTextLeft29:Hide();
	GameTooltipTextLeft30:Hide();

	--GameTooltipTextRight1:Hide();
	GameTooltipTextRight2:Hide();
	GameTooltipTextRight3:Hide();
	GameTooltipTextRight4:Hide();
	GameTooltipTextRight5:Hide();
	GameTooltipTextRight6:Hide();
	GameTooltipTextRight7:Hide();
	GameTooltipTextRight8:Hide();
	GameTooltipTextRight9:Hide();
	GameTooltipTextRight10:Hide();
	GameTooltipTextRight11:Hide();
	GameTooltipTextRight12:Hide();
	GameTooltipTextRight13:Hide();
	GameTooltipTextRight14:Hide();
	GameTooltipTextRight15:Hide();
	GameTooltipTextRight16:Hide();
	GameTooltipTextRight17:Hide();
	GameTooltipTextRight18:Hide();
	GameTooltipTextRight19:Hide();
	GameTooltipTextRight20:Hide();
	GameTooltipTextRight21:Hide();
	GameTooltipTextRight22:Hide();
	GameTooltipTextRight23:Hide();
	GameTooltipTextRight24:Hide();
	GameTooltipTextRight25:Hide();
	GameTooltipTextRight26:Hide();
	GameTooltipTextRight27:Hide();
	GameTooltipTextRight28:Hide();
	GameTooltipTextRight29:Hide();
	GameTooltipTextRight30:Hide();
end

------------------------------------------------------------------------------------------------------------------
--					Tooltip Options Section                                                 --
------------------------------------------------------------------------------------------------------------------

function mrpTooltipEditorOnUpdate()

	FauxScrollFrame_Update(mrpTooltipScrollFrame, 30, 15, 16);

	local lineOffset = FauxScrollFrame_GetOffset(mrpTooltipScrollFrame);

	for line = 1, 30 do
		getglobal("mrpTooltipScrollFrameText" .. line):Hide();
		getglobal("mrpTooltipScrollFrameText" .. line):ClearAllPoints();
		if (line == 1) then
			getglobal("mrpTooltipScrollFrameText" .. line):SetPoint("TOPLEFT", "mrpTooltipScrollFrame", "TOPLEFT", 0, 17 * lineOffset);		
		else
			getglobal("mrpTooltipScrollFrameText" .. line):SetPoint("TOPLEFT", getglobal("mrpTooltipScrollFrameText" .. (line - 1)), "BOTTOMLEFT", 0, -2);
		end		
	end	

	for line = 1, 15 do
		getglobal("mrpTooltipScrollFrameText" .. (line + lineOffset)):Show();
	end

	mrpPrevOffset = lineOffset;
end

function mrpTooltipEditorUpdate(mrpOrderType)
	for i = 1, table.getn(MyRolePlay.Settings.Tooltip.Order[mrpOrderType]) do
		lineText = "";
		lineTextTwo = "";
		for j = 1, table.getn(MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i]) do
			if (MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j] == MRP_NEWLINE) then
				lineTextTwo = MRP_NEWLINE_STRING;
			end
			for newlineCheck = 1, table.getn(MRP_CONDITIONAL_NEWLINE) do
				if (type(MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j]) == "table" and MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j].Value ~= nil and MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j].Value[1] == MRP_CONDITIONAL_NEWLINE[newlineCheck].Value[1]) then
					lineTextTwo = MRP_NEWLINE_STRING;
					break;
				end
			end
			for textCheck = 1, table.getn(MyRolePlay.Settings.Tooltip.Order.MRP_TEXT) do
				if (type(MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j]) == "table" and MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j].Text == MyRolePlay.Settings.Tooltip.Order.MRP_TEXT[textCheck].Text) then
					lineTextTwo = MyRolePlay.Settings.Tooltip.Order.MRP_TEXT[textCheck].Text;
					break;
				end
			end
			if (MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j] == MRP_PREFIX) then
				lineTextTwo = MRP_PREFIX_STRING;
			end
			if (MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j] == MRP_FIRSTNAME) then
				lineTextTwo = MRP_FIRSTNAME_STRING;
			end
			if (MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j] == MRP_MIDDLENAME) then
				lineTextTwo = MRP_MIDDLENAME_STRING;
			end
			if (MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j] == MRP_SURNAME) then
				lineTextTwo = MRP_SURNAME_STRING;
			end
			if (MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j] == MRP_TITLE) then
				lineTextTwo = MRP_TITLE_STRING;
			end
			if (MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j] == MRP_HOUSENAME) then
				lineTextTwo = MRP_HOUSENAME_STRING;
			end
			if (MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j] == MRP_NICKNAME) then
				lineTextTwo = MRP_NICKNAME_STRING;
			end
			if (MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j] == MRP_GUILDRANK) then
				lineTextTwo = MRP_GUILDRANK_STRING;
			end
			if (MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j] == MRP_GUILD) then
				lineTextTwo = MRP_GUILD_STRING;
			end
			if (MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j] == MRP_PVPRANK) then
				lineTextTwo = MRP_PVPRANK_STRING;
			end
			if (MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j] == MRP_PVPSTATUS) then
				lineTextTwo = MRP_PVPSTATUS_STRING;
			end
			if (MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j] == MRP_LEVEL) then
				lineTextTwo = MRP_LEVEL_STRING;
			end
			if (MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j] == MRP_CLASS) then
				lineTextTwo = MRP_CLASS_STRING;
			end
			if (MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j] == MRP_RACE) then
				lineTextTwo = MRP_RACE_STRING;
			end
			if (MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j] == MRP_RPSTYLE) then
				lineTextTwo = MRP_RPSTYLE_STRING;
			end
			if (MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j] == MRP_CSSTATUS) then
				lineTextTwo = MRP_CSSTATUS_STRING;
			end
			if (MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j] == MRP_UNITNAME) then
				lineTextTwo = MRP_UNITNAME_STRING;
			end
			if (MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j] == MRP_EYECOLOUR) then
				lineTextTwo = MRP_EYECOLOUR_STRING;
			end
			if (MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j] == MRP_HEIGHT) then
				lineTextTwo = MRP_HEIGHT_STRING;
			end
			if (MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j] == MRP_WEIGHT) then
				lineTextTwo = MRP_WEIGHT_STRING;
			end
			if (MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j] == MRP_CURRENT_EMOTION) then
				lineTextTwo = MRP_CURRENT_EMOTION_STRING;
			end
			if (MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j] == MRP_HOMECITY) then
				lineTextTwo = MRP_HOMECITY_STRING;
			end
			if (MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j] == MRP_BIRTHCITY) then
				lineTextTwo = MRP_BIRTHCITY_STRING;
			end
			if (MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j] == MRP_AGE) then
				lineTextTwo = MRP_AGE_STRING;
			end
			if (MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j] == MRP_BIRTHDATE) then
				lineTextTwo = MRP_BIRTHDATE_STRING;
			end
			if (MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j] == MRP_MOTTO) then
				lineTextTwo = MRP_MOTTO_STRING;
			end

			lineText = lineText .. lineTextTwo;
		end
		getglobal("mrpTooltipScrollFrameText" .. i .. "String"):SetText(lineText);
	end
end

function mrpDisplayPreviewTooltip(mrpOrderType)
	for i = 1, table.getn(MyRolePlay.Settings.Tooltip.Order[mrpOrderType]) do
		lineText = "";
		lineTextTwo = "";
		for j = 1, table.getn(MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i]) do
			if (MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j] == MRP_NEWLINE) then
				lineTextTwo = MRP_NEWLINE_STRING;
			end
			for newlineCheck = 1, table.getn(MRP_CONDITIONAL_NEWLINE) do
				if (type(MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j]) == "table" and MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j].Value ~= nil and MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j].Value[1] == MRP_CONDITIONAL_NEWLINE[newlineCheck].Value[1]) then
					lineTextTwo = MRP_NEWLINE_STRING;
					break;
				end
			end
			for textCheck = 1, table.getn(MyRolePlay.Settings.Tooltip.Order.MRP_TEXT) do
				if (type(MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j]) == "table" and MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j].Text == MyRolePlay.Settings.Tooltip.Order.MRP_TEXT[textCheck].Text) then
					lineTextTwo = MyRolePlay.Settings.Tooltip.Order.MRP_TEXT[textCheck].Text;
					break;
				end
			end
			if (MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j] == MRP_PREFIX) then
				lineTextTwo = MRP_PREFIX_STRING;
			end
			if (MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j] == MRP_FIRSTNAME) then
				lineTextTwo = MRP_FIRSTNAME_STRING;
			end
			if (MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j] == MRP_MIDDLENAME) then
				lineTextTwo = MRP_MIDDLENAME_STRING;
			end
			if (MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j] == MRP_SURNAME) then
				lineTextTwo = MRP_SURNAME_STRING;
			end
			if (MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j] == MRP_TITLE) then
				lineTextTwo = MRP_TITLE_STRING;
			end
			if (MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j] == MRP_HOUSENAME) then
				lineTextTwo = MRP_HOUSENAME_STRING;
			end
			if (MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j] == MRP_NICKNAME) then
				lineTextTwo = MRP_NICKNAME_STRING;
			end
			if (MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j] == MRP_GUILDRANK) then
				lineTextTwo = MRP_GUILDRANK_STRING;
			end
			if (MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j] == MRP_GUILD) then
				lineTextTwo = MRP_GUILD_STRING;
			end
			if (MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j] == MRP_PVPRANK) then
				lineTextTwo = MRP_PVPRANK_STRING;
			end
			if (MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j] == MRP_PVPSTATUS) then
				lineTextTwo = MRP_PVPSTATUS_STRING;
			end
			if (MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j] == MRP_LEVEL) then
				lineTextTwo = MRP_LEVEL_STRING;
			end
			if (MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j] == MRP_CLASS) then
				lineTextTwo = MRP_CLASS_STRING;
			end
			if (MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j] == MRP_RACE) then
				lineTextTwo = MRP_RACE_STRING;
			end
			if (MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j] == MRP_RPSTYLE) then
				lineTextTwo = MRP_RPSTYLE_STRING;
			end
			if (MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j] == MRP_CSSTATUS) then
				lineTextTwo = MRP_CSSTATUS_STRING;
			end
			if (MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j] == MRP_UNITNAME) then
				lineTextTwo = MRP_UNITNAME_STRING;
			end
			if (MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j] == MRP_EYECOLOUR) then
				lineTextTwo = MRP_EYECOLOUR_STRING;
			end
			if (MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j] == MRP_HEIGHT) then
				lineTextTwo = MRP_HEIGHT_STRING;
			end
			if (MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j] == MRP_WEIGHT) then
				lineTextTwo = MRP_WEIGHT_STRING;
			end
			if (MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j] == MRP_CURRENT_EMOTION) then
				lineTextTwo = MRP_CURRENT_EMOTION_STRING;
			end
			if (MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j] == MRP_HOMECITY) then
				lineTextTwo = MRP_HOMECITY_STRING;
			end
			if (MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j] == MRP_BIRTHCITY) then
				lineTextTwo = MRP_BIRTHCITY_STRING;
			end
			if (MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j] == MRP_AGE) then
				lineTextTwo = MRP_AGE_STRING;
			end
			if (MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j] == MRP_BIRTHDATE) then
				lineTextTwo = MRP_BIRTHDATE_STRING;
			end
			if (MyRolePlay.Settings.Tooltip.Order[mrpOrderType][i][j] == MRP_MOTTO) then
				lineTextTwo = MRP_MOTTO_STRING;
			end

			lineText = lineText .. lineTextTwo;
		end
		GameTooltip:AddLine(lineText);
	end
	GameTooltip:Show();
end

function mrpEditTooltipOrder(row)
	mrpCurrentRowBeingEdited = row
	mrpTooltipOrderBuilderWhichRowString:SetText(MRP_LOCALE_Editing_Row_1_TT .. row .. MRP_LOCALE_Editing_Row_2_TT);
	mrpTooltipOrderBuilderEditBox:Show();
	mrpTooltipOrderBuilderSaveButton:Show();
	mrpTooltipOrderBuilderCreateRegularTooltipButton:Hide();
	mrpTooltipOrderBuilderSaveConditionalNewlineButton:Hide();
	mrpTooltipOrderBuilderConditionalNewlineTypeCheckButtonBefore:Hide();
	mrpTooltipOrderBuilderEditBox:SetText("");
	mrpTooltipOrderBuilder:Show();	

	for i = 1, table.getn(MyRolePlay.Settings.Tooltip.Order.MRP[row]) do
		local mrpNewlineExists = false;
		local mrpTextExists = false;

		if (i == 1) then
			for newlineCheck = 1, table.getn(MRP_CONDITIONAL_NEWLINE) do
				if (type(MyRolePlay.Settings.Tooltip.Order["MRP"][row][i]) == "table" and MyRolePlay.Settings.Tooltip.Order["MRP"][row][i].Value ~= nil and MyRolePlay.Settings.Tooltip.Order["MRP"][row][i].Value[1] == MRP_CONDITIONAL_NEWLINE[newlineCheck].Value[1]) then
					mrpTooltipOrderBuilderEditBox:Hide();
					mrpTooltipOrderBuilderSaveButton:Hide();
					mrpTooltipOrderBuilderCreateRegularTooltipButton:Show();
					mrpTooltipOrderBuilderSaveConditionalNewlineButton:Show();
					mrpTooltipOrderBuilderConditionalNewlineTypeCheckButtonBefore:Show();
					mrpTooltipOrderBuilderWhichRowString:SetText(MRP_LOCALE_Editing_Row_1_TT .. row .. MRP_LOCALE_Editing_Row_2_TT .. "\nThis is a conditional newline.");
					mrpNewlineExists = true;
				end
			end
			for textCheck = 1, table.getn(MyRolePlay.Settings.Tooltip.Order.MRP_TEXT) do
				if (type(MyRolePlay.Settings.Tooltip.Order["MRP"][row][i]) == "table" and MyRolePlay.Settings.Tooltip.Order["MRP"][row][i].Text == MyRolePlay.Settings.Tooltip.Order.MRP_TEXT[textCheck].Text) then
					mrpTooltipOrderBuilderEditBox:SetText("\"" .. MyRolePlay.Settings.Tooltip.Order.MRP_TEXT[textCheck].Text .. "\"");
					mrpTextExists = true;
				end
			end
			if (mrpNewlineExists ~= true and mrpTextExists ~= true) then
				mrpTooltipOrderBuilderEditBox:SetText(mrpConvertNumberToText(MyRolePlay.Settings.Tooltip.Order.MRP[row][i]));
			end			
		else
			for newlineCheck = 1, table.getn(MRP_CONDITIONAL_NEWLINE) do
				if (MyRolePlay.Settings.Tooltip.Order.MRP[row][i] == MRP_CONDITIONAL_NEWLINE[newlineCheck]) then
					mrpTooltipOrderBuilderEditBox:SetText(mrpTooltipOrderBuilderEditBox:GetText() .. " " .. "Conditional Newline, press new conditional newline to change the properties of this newline.");
					mrpNewlineExists = true;
				end
			end
			for textCheck = 1, table.getn(MyRolePlay.Settings.Tooltip.Order.MRP_TEXT) do
				if (MyRolePlay.Settings.Tooltip.Order.MRP[row][i] == MyRolePlay.Settings.Tooltip.Order.MRP_TEXT[textCheck]) then
					mrpTooltipOrderBuilderEditBox:SetText(mrpTooltipOrderBuilderEditBox:GetText() .. " \"" .. MyRolePlay.Settings.Tooltip.Order.MRP_TEXT[textCheck].Text .. "\"");
					mrpTextExists = true;
				end
			end
			if (mrpNewlineExists ~= true and mrpTextExists ~= true) then
				mrpTooltipOrderBuilderEditBox:SetText(mrpTooltipOrderBuilderEditBox:GetText() .. " " .. mrpConvertNumberToText(MyRolePlay.Settings.Tooltip.Order.MRP[row][i]));
			end
		end		
	end
end

function mrpConvertToString(stringToEdit)
	stringToEdit = string.gsub(stringToEdit, "\"", "\\\"");

	return (stringToEdit);
end

function mrpConvertFromString(stringToEdit)
	stringToEdit = string.gsub(stringToEdit, "\\\"", "\"");

	return (stringToEdit);
end

function mrpSaveTooltipOrder(row)
	local numOfNewCols = 1;
	local cols = {};
	local boxString = mrpTooltipOrderBuilderEditBox:GetText();
	local userTextEnabled = false;
	local curText = "";
	local backslashFlag = false;

	for i = 1, string.len(boxString) do
		local char = string.sub(boxString, i, i);

		if (userTextEnabled == false) then
			if (char == "\"") then
				curText = "";
				userTextEnabled = true;
				
				for textCheck = 1, table.getn(MyRolePlay.Settings.Tooltip.Order.MRP_TEXT) do
					if (MyRolePlay.Settings.Tooltip.Order.MRP[row][i] == MyRolePlay.Settings.Tooltip.Order.MRP_TEXT[textCheck]) then
						table.remove(MyRolePlay.Settings.Tooltip.Order.MRP_TEXT, textCheck);
					end
				end

				local tempTable = {};
				tempTable.Text = "";
				tempTable.BoA = MRP_TOOLTIP_TEXT_AFTER;
				tempTable.Colours = MyRolePlay.Settings.Colours.Nickname;

				table.insert(MyRolePlay.Settings.Tooltip.Order.MRP_TEXT, tempTable);

			elseif (char == " ") then
				cols[numOfNewCols] = mrpConvertTextToNumber(curText);
				numOfNewCols = numOfNewCols + 1;
				curText = "";
				table.setn(cols, numOfNewCols);
			else
				if (i == string.len(boxString)) then
					curText = curText .. char;
					cols[numOfNewCols] = mrpConvertTextToNumber(curText);
					curText = "";
				else
					curText = curText .. char;
				end				
			end			
		else
			if (char == "\\" and backslashFlag == false) then
				backslashFlag = true;
			elseif (char == "\\" and backslashFlag == true) then
				MyRolePlay.Settings.Tooltip.Order.MRP_TEXT[table.getn(MyRolePlay.Settings.Tooltip.Order.MRP_TEXT)].Text = MyRolePlay.Settings.Tooltip.Order.MRP_TEXT[table.getn(MyRolePlay.Settings.Tooltip.Order.MRP_TEXT)].Text .. char;	
				backslashFlag = false;
			elseif (char == "\"" and backslashFlag == true) then
				MyRolePlay.Settings.Tooltip.Order.MRP_TEXT[table.getn(MyRolePlay.Settings.Tooltip.Order.MRP_TEXT)].Text = MyRolePlay.Settings.Tooltip.Order.MRP_TEXT[table.getn(MyRolePlay.Settings.Tooltip.Order.MRP_TEXT)].Text .. char;
				backslashFlag = false;
			elseif (char == "\"" and backslashFlag == false) then
				userTextEnabled = false;

				if (i ~= string.len(boxString)) then
					cols[numOfNewCols] = MyRolePlay.Settings.Tooltip.Order.MRP_TEXT[table.getn(MyRolePlay.Settings.Tooltip.Order.MRP_TEXT)];
					numOfNewCols = numOfNewCols + 1;
					curText = "";
					table.setn(cols, numOfNewCols);
					i = i + 1;
				else
					cols[numOfNewCols] = MyRolePlay.Settings.Tooltip.Order.MRP_TEXT[table.getn(MyRolePlay.Settings.Tooltip.Order.MRP_TEXT)];
				end
				mrpDisplayMessage(numOfNewCols);
			else
				backslashFlag = false;
				MyRolePlay.Settings.Tooltip.Order.MRP_TEXT[table.getn(MyRolePlay.Settings.Tooltip.Order.MRP_TEXT)].Text = MyRolePlay.Settings.Tooltip.Order.MRP_TEXT[table.getn(MyRolePlay.Settings.Tooltip.Order.MRP_TEXT)].Text .. char;
			end			
		end
	end

	if (boxString == "") then
		cols[numOfNewCols] = mrpConvertTextToNumber(MRP_LOCALE_ELEMENT_EMPTY);
	end

	MyRolePlay.Settings.Tooltip.Order.MRP[row] = nil;
	MyRolePlay.Settings.Tooltip.Order.MRP[row] = {};
	table.setn(MyRolePlay.Settings.Tooltip.Order.MRP[row], 0);

	for i = 1, numOfNewCols do
		table.setn(MyRolePlay.Settings.Tooltip.Order.MRP[row], table.getn(MyRolePlay.Settings.Tooltip.Order.MRP[row]) + 1);
		MyRolePlay.Settings.Tooltip.Order.MRP[row][i] = cols[i];		
	end

	for i = row - 1, 1, -1 do
		if (MyRolePlay.Settings.Tooltip.Order.MRP[i][1] == MRP_EMPTY) then
			MyRolePlay.Settings.Tooltip.Order.MRP[i] = {};

			local values = {};
			for j = 1, table.getn(MyRolePlay.Settings.Tooltip.Order.MRP[row]) do
				values[j] = MyRolePlay.Settings.Tooltip.Order.MRP[row][j];
			end
			MyRolePlay.Settings.Tooltip.Order.MRP[i][1] = mrpCreateNewCONDITIONAL_NEWLINE(row - i, values, 1);
		end
	end
	
	mrpTooltipEditorUpdate("MRP")

	mrpTooltipOrderBuilder:Hide();
end

function mrpConvertTextToNumber(text)
	if (text == MRP_LOCALE_ELEMENT_EMPTY) then
		return (tonumber(MRP_EMPTY));
	elseif (text == MRP_LOCALE_ELEMENT_NEWLINE) then
		return (tonumber(MRP_NEWLINE));
	elseif (text == MRP_LOCALE_ELEMENT_PREFIX) then
		return (tonumber(MRP_PREFIX));
	elseif (text == MRP_LOCALE_ELEMENT_FIRSTNAME) then
		return (tonumber(MRP_FIRSTNAME));
	elseif (text == MRP_LOCALE_ELEMENT_MIDDLENAME) then
		return (tonumber(MRP_MIDDLENAME));
	elseif (text == MRP_LOCALE_ELEMENT_SURNAME) then
		return (tonumber(MRP_SURNAME));
	elseif (text == MRP_LOCALE_ELEMENT_TITLE) then
		return (tonumber(MRP_TITLE));
	elseif (text == MRP_LOCALE_ELEMENT_HOUSENAME) then
		return (tonumber(MRP_HOUSENAME));
	elseif (text == MRP_LOCALE_ELEMENT_NICKNAME) then
		return (tonumber(MRP_NICKNAME));
	elseif (text == MRP_LOCALE_ELEMENT_GUILDRANK) then
		return (tonumber(MRP_GUILDRANK));
	elseif (text == MRP_LOCALE_ELEMENT_PVPRANK) then
		return (tonumber(MRP_PVPRANK));
	elseif (text == MRP_LOCALE_ELEMENT_PVPSTATUS) then
		return (tonumber(MRP_PVPSTATUS));
	elseif (text == MRP_LOCALE_ELEMENT_LEVEL) then
		return (tonumber(MRP_LEVEL));
	elseif (text == MRP_LOCALE_ELEMENT_CLASS) then
		return (tonumber(MRP_CLASS));
	elseif (text == MRP_LOCALE_ELEMENT_RACE) then
		return (tonumber(MRP_RACE));
	elseif (text == MRP_LOCALE_ELEMENT_RPSTYLE) then
		return (tonumber(MRP_RPSTYLE));
	elseif (text == MRP_LOCALE_ELEMENT_CSTATUS) then
		return (tonumber(MRP_CSSTATUS));
	elseif (text == MRP_LOCALE_ELEMENT_UNITNAME) then
		return (tonumber(MRP_UNITNAME));
	elseif (text == MRP_LOCALE_ELEMENT_EYECOLOUR) then
		return (tonumber(MRP_EYECOLOUR));
	elseif (text == MRP_LOCALE_ELEMENT_HEIGHT) then
		return (tonumber(MRP_HEIGHT));
	elseif (text == MRP_LOCALE_ELEMENT_WEIGHT) then
		return (tonumber(MRP_WEIGHT));
	elseif (text == MRP_LOCALE_ELEMENT_CURRENTEMOTION) then
		return (tonumber(MRP_CURRENT_EMOTION));
	elseif (text == MRP_LOCALE_ELEMENT_HOME) then
		return (tonumber(MRP_HOMECITY));
	elseif (text == MRP_LOCALE_ELEMENT_BIRTHPLACE) then
		return (tonumber(MRP_BIRTHCITY));
	elseif (text == MRP_LOCALE_ELEMENT_AGE) then-- doesn't work yet
		return (tonumber(MRP_AGE)); -- doesn't work yet
	elseif (text == MRP_LOCALE_ELEMENT_BIRTHDATE) then-- doesn't work yet
		return (tonumber(MRP_BIRTHDATE));-- doesn't work yet
	elseif (text == MRP_LOCALE_ELEMENT_MOTTO) then
		return (tonumber(MRP_MOTTO));
	elseif (text == MRP_LOCALE_ELEMENT_GUILDNAME) then
		return (tonumber(MRP_GUILD));
	end

	return (tonumber(MRP_EMPTY));
end

function mrpConvertNumberToText(number)
	if (number == MRP_EMPTY) then
		return (MRP_LOCALE_ELEMENT_EMPTY);
	elseif (number == MRP_NEWLINE) then
		return (MRP_LOCALE_ELEMENT_NEWLINE);
	elseif (number == MRP_PREFIX) then
		return (MRP_LOCALE_ELEMENT_PREFIX);
	elseif (number == MRP_FIRSTNAME) then
		return (MRP_LOCALE_ELEMENT_FIRSTNAME);
	elseif (number == MRP_MIDDLENAME) then
		return (MRP_LOCALE_ELEMENT_MIDDLENAME);
	elseif (number == MRP_SURNAME) then
		return (MRP_LOCALE_ELEMENT_SURNAME);
	elseif (number == MRP_TITLE) then
		return (MRP_LOCALE_ELEMENT_TITLE);
	elseif (number == MRP_HOUSENAME) then
		return (MRP_LOCALE_ELEMENT_HOUSENAME);
	elseif (number == MRP_NICKNAME) then
		return (MRP_LOCALE_ELEMENT_NICKNAME);
	elseif (number == MRP_GUILDRANK) then
		return (MRP_LOCALE_ELEMENT_GUILDRANK);
	elseif (number == MRP_PVPRANK) then
		return (MRP_LOCALE_ELEMENT_PVPRANK);
	elseif (number == MRP_PVPSTATUS) then
		return (MRP_LOCALE_ELEMENT_PVPSTATUS);
	elseif (number == MRP_LEVEL) then
		return (MRP_LOCALE_ELEMENT_LEVEL);
	elseif (number == MRP_CLASS) then
		return (MRP_LOCALE_ELEMENT_CLASS);
	elseif (number == MRP_RACE) then
		return (MRP_LOCALE_ELEMENT_RACE);
	elseif (number == MRP_RPSTYLE) then
		return (MRP_LOCALE_ELEMENT_RPSTYLE);
	elseif (number == MRP_CSSTATUS) then
		return (MRP_LOCALE_ELEMENT_CSTATUS);
	elseif (number == MRP_UNITNAME) then
		return (MRP_LOCALE_ELEMENT_UNITNAME);
	elseif (number == MRP_EYECOLOUR) then
		return (MRP_LOCALE_ELEMENT_EYECOLOUR);
	elseif (number == MRP_HEIGHT) then
		return (MRP_LOCALE_ELEMENT_HEIGHT);
	elseif (number == MRP_WEIGHT) then
		return (MRP_LOCALE_ELEMENT_WEIGHT);
	elseif (number == MRP_CURRENT_EMOTION) then
		return (MRP_LOCALE_ELEMENT_CURRENTEMOTION);
	elseif (number == MRP_HOMECITY) then
		return (MRP_LOCALE_ELEMENT_HOME);
	elseif (number == MRP_BIRTHCITY) then
		return (MRP_LOCALE_ELEMENT_BIRTHPLACE);
	elseif (number == MRP_AGE) then-- doesn't work yet
		return (MRP_LOCALE_ELEMENT_AGE); -- doesn't work yet
	elseif (number == MRP_BIRTHDATE) then-- doesn't work yet
		return (MRP_LOCALE_ELEMENT_BIRTHDATE);-- doesn't work yet
	elseif (number == MRP_MOTTO) then
		return (MRP_LOCALE_ELEMENT_MOTTO);
	elseif (number == MRP_GUILD) then
		return (MRP_LOCALE_ELEMENT_GUILDNAME);
	end
end

function mrpSaveNewLineTooltipOrder(row)
	
end

function mrpCreateNewCONDITIONAL_NEWLINE(Distance, Values, Type)
	local newIndex = table.getn(MRP_CONDITIONAL_NEWLINE) + 1;

	table.setn(MRP_CONDITIONAL_NEWLINE, newIndex);

	MRP_CONDITIONAL_NEWLINE[newIndex] = {};
	MRP_CONDITIONAL_NEWLINE[newIndex].Distance = Distance;
	MRP_CONDITIONAL_NEWLINE[newIndex].Value = Values;
	MRP_CONDITIONAL_NEWLINE[newIndex].Type = Type;
	
	return (MRP_CONDITIONAL_NEWLINE[newIndex]);
end