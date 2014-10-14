-- Show all toons on the same server
-- Stats to show: name, race, class, level, zone, guild, professions, gold, 
-- Bottom pane: show all stats for one toon

MAX_TOONS = 10;
TOONSTAB={};
TOONSVAR={};
ToonsServer={};
ToonsPage={};

TOONS_RACES = { ["HUMAN"]={id=1, color={r=0,g=.75,b=1}, fontcolor="|cff00c0ff",}, ["DWARF"]={id=2, color={r=.25,g=.25,b=1}, fontcolor="|cff4040ff",}, ["NIGHT ELF"]={id=3, color={r=.5,g=.5,b=1}, fontcolor="|cff8080ff",}, ["GNOME"]={id=4, color={r=.75,g=.75,b=1}, fontcolor="|cffc0c0ff",}, ["ORC"]={id=5, color={r=.5,g=0,b=0}, fontcolor="|cff800000",}, ["UNDEAD"]={id=6, color={r=1,g=.25,b=.25}, fontcolor="|cffff4040",}, ["TAUREN"]={id=7, color={r=1,g=.5,b=.5}, fontcolor="|cffff8080",}, ["TROLL"]={id=8, color={r=1,g=.75,b=.75}, fontcolor="|cffffc0c0",}, };

SKILL_RANK = { [75]="Apprentice", [90]="Apprentice", [150]="Journeyman", [165]="Journeyman", [225]="Expert", [240]="Expert", [300]="Artisan", [315]="Artisan", };

SKILL_TYPE = { ["Alchemy"]={id=1, color="HIGHLIGHT_FONT_COLOR"}, ["Blacksmithing"]={id=2, color="HIGHLIGHT_FONT_COLOR"}, ["Cooking"]={id=3, color="HIGHLIGHT_FONT_COLOR"}, ["Enchanting"]={id=4, color="RED_FONT_COLOR"}, ["Engineering"]={id=5, color="HIGHLIGHT_FONT_COLOR"}, ["First Aid"]={id=6, color="HIGHLIGHT_FONT_COLOR"}, ["Fishing"]={id=7, color="GREEN_FONT_COLOR"}, ["Herbalism"]={id=8, color="GREEN_FONT_COLOR"}, ["Leatherworking"]={id=9, color="HIGHLIGHT_FONT_COLOR"}, ["Mining"]={id=10, color="GREEN_FONT_COLOR"}, ["Skinning"]={id=11, color="GREEN_FONT_COLOR"}, ["Tailoring"]={id=12, color="HIGHLIGHT_FONT_COLOR"}, };

-- add font color codes to raid class
TOONS_CLASSES = { HUNTER={fontcolor="|cffaad372"}, WARLOCK={fontcolor="|cff9382c9"}, PRIEST={fontcolor="|cffffffff"}, PALADIN={fontcolor="|cfff48cba"}, MAGE={fontcolor="|cff4cccef"}, ROGUE={fontcolor="|cfffff468"}, DRUID={fontcolor="|cffff7c0a"}, SHAMAN={fontcolor="|cfff48cba"}, WARRIOR={fontcolor="|cffc69b6d"}, }

MoneyTypeInfo["ASSETS"] = {
	UpdateFunc = function()
		return this.staticMoney;
	end,
	collapse = 1,
	showSmallerCoins = "Backpack",
};

tinsert(FRIENDSFRAME_SUBFRAMES, "ToonsFrame");

function ToonsFrame_OnLoad()
	TOONSPAGES = { ["STATSFRAME"]={id=1, frame="ToonsFrameStatsFrame", name="Stats"}, ["PLAYEDFRAME"]={id=3, frame="ToonsFramePlayedFrame", name="Played"}, ["GUILDFRAME"]={id=4, frame="ToonsFrameGuildFrame", name="Guild"}, ["ASSETSFRAME"]={id=5, frame="ToonsFrameAssetsFrame", name="Assets"}, ["TRADESKILLFRAME"]={id=6, frame="ToonsFrameTradeskillFrame", name="Tradeskill"}, ["XPFRAME"]={id=2, frame="ToonsFrameXPFrame", name="Experience"}  };
	TOONSSORT = { ["NAME_UP"]=Toons_SortNameUp, ["NAME_DOWN"]=Toons_SortNameDown, ["LEVEL_UP"]=Toons_SortLevelUp, ["LEVEL_DOWN"]=Toons_SortLevelDown, ["RACE_UP"]=Toons_SortRaceUp, ["RACE_DOWN"]=Toons_SortRaceDown, ["CLASS_UP"]=Toons_SortClassUp, ["CLASS_DOWN"]=Toons_SortClassDown, ["ZONE_UP"]=Toons_SortZoneUp, ["ZONE_DOWN"]=Toons_SortZoneDown, ["TIMEPLAYED_UP"]=Toons_SortTimePlayedUp, ["TIMEPLAYED_DOWN"]=Toons_SortTimePlayedDown, ["TIMEATLEVEL_UP"]=Toons_SortTimeAtLevelUp, ["TIMEATLEVEL_DOWN"]=Toons_SortTimeAtLevelDown,  ["GUILDNAME_UP"]=Toons_SortGuildNameUp, ["GUILDNAME_DOWN"]=Toons_SortGuildNameDown,  ["GUILDRANK_UP"]=Toons_SortGuildRankUp,  ["GUILDRANK_DOWN"]=Toons_SortGuildRankDown,  ["GOLD_UP"]=Toons_SortGoldUp, ["GOLD_DOWN"]=Toons_SortGoldDown, ["BAGS_UP"]=Toons_SortBagsUp, ["BAGS_DOWN"]=Toons_SortBagsDown, ["BANK_UP"]=Toons_SortBankUp, ["BANK_DOWN"]=Toons_SortBankDown, ["TRADESKILL1_UP"]=Toons_SortTradeskill1Up, ["TRADESKILL1_DOWN"]=Toons_SortTradeskill1Down, ["TRADESKILL2_UP"]=Toons_SortTradeskill2Up, ["TRADESKILL2_DOWN"]=Toons_SortTradeskill2Down,  ["TRADESKILL1RANK_UP"]=Toons_SortTradeskill1RankUp, ["TRADESKILL1RANK_DOWN"]=Toons_SortTradeskill1RankDown, ["TRADESKILL2RANK_UP"]=Toons_SortTradeskill2RankUp, ["TRADESKILL2RANK_DOWN"]=Toons_SortTradeskill2RankDown, ["XP_UP"]=Toons_SortXPUp, ["XP_DOWN"]=Toons_SortXPDown, ["XPMAX_UP"]=Toons_SortXPMaxUp, ["XPMAX_DOWN"]=Toons_SortXPMaxDown, ["XPPERCENT_UP"]=Toons_SortXPPercentUp, ["XPPERCENT_DOWN"]=Toons_SortXPPercentDown, }

	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("PLAYER_LEAVING_WORLD");
	this:RegisterEvent("PLAYER_LOGOUT");
	this:RegisterEvent("ZONE_CHANGED_NEW_AREA");
	this:RegisterEvent("UNIT_PORTRAIT_UPDATE");
	this:RegisterEvent("PLAYER_LEVEL_UP");
	this:RegisterEvent("PLAYER_XP_UPDATE");
	this:RegisterEvent("PLAYER_MONEY");
	this:RegisterEvent("TIME_PLAYED_MSG");
	this:RegisterEvent("TRADE_SKILL_UPDATE");

	FriendsFrameToonsTab, ToonsTabFrame = FriendsFrameTab_CreateTab("ToonsFrame", TOONS);
	FriendsFrameToonsTab_Initialize( getglobal(ToonsTabFrame) );

	ChatFrame_DisplayTimePlayed = Toons_ChatFrame_DisplayTimePlayed;
end

function ToonsFrame_OnShow()
	--GuildRoster();
	Toons_RequestTimePlayed();
	Toons_GetTradeskillInfo();
	SetPortraitTexture(ToonsFramePortrait, "player");
end

function ToonsFrame_OnHide()
	SetPortraitTexture(ToonsFramePortrait, "player");
end

function ToonsFrame_OnEvent()
	if (event=="BAG_UPDATE") then
		if ( arg1 <= NUM_BAG_SLOTS ) then
			Toons_BagsSizeUpdate();
		elseif ( BankFrame:IsVisible() and arg1 > NUM_BAG_SLOTS and arg1 < NUM_BAG_SLOTS+NUM_BANKBAGSLOTS ) then
			Toons_BankSizeUpdate();
		end
		ToonsFrame_Update();
	elseif (event=="ZONE_CHANGED_NEW_AREA") then
		ToonsTab_Update( "zone", GetZoneText() );
		ToonsFrame_Update();
		--ERR_GUILD_PLAYER_NOT_IN_GUILD = oldGuildErrorMsg;
	elseif (event=="PLAYER_MONEY") then
		ToonsTab_Update( "gold", GetMoney() );
		ToonsFrame_Update();
	elseif (event=="PLAYERBANKSLOTS_CHANGED") then
		Toons_BankSizeUpdate();
		ToonsFrame_Update();
	elseif (event=="TRADE_SKILL_UPDATE") then
		Toons_GetTradeskillInfo();
		ToonsFrame_Update();
	elseif (event=="PLAYER_LEVEL_UP") then
		ToonsTab_Update( "level", arg1 );
		ToonsFrame_Update();
	elseif (event=="PLAYER_XP_UPDATE") then
		ToonsTab_Update( "xp", UnitXP("player") );
		ToonsTab_Update( "xpmax", UnitXPMax("player") );
		ToonsFrame_Update();
	elseif (event=="GUILD_ROSTER_UPDATE") then
		local guild, rank, index = GetGuildInfo("player");
		local server = GetRealmName();
		local player = UnitName("player");
		if ( TOONSTAB and TOONSTAB[server] and TOONSTAB[server][player] ) then
			TOONSTAB[server][player].guild = guild or "";
			TOONSTAB[server][player].guildrank = rank or "";
			TOONSTAB[server][player].guildindex = index or "";
		end
		ToonsFrame_Update();
	elseif (event=="TIME_PLAYED_MSG") then
		--local totalplaytime, timeatcurrentlevel = arg1, arg2;
		--local d,h,m,s = ChatFrame_TimeBreakDown(totalTime);
		ToonsTab_Update( "timeplayed", arg1 );
		ToonsTab_Update( "timeatlevel", arg2 );
		ToonsFrame_Update();
	elseif ( event == "UNIT_PORTRAIT_UPDATE" ) then
		if ( arg1 == "player" ) then
			SetPortraitTexture(ToonsFramePortrait, arg1);
		end
	elseif (event=="PLAYER_ENTERING_WORLD") then
		oldGuildErrorMsg = ERR_GUILD_PLAYER_NOT_IN_GUILD;
		ERR_GUILD_PLAYER_NOT_IN_GUILD = "";
		this:RegisterEvent("BAG_UPDATE");
		this:RegisterEvent("PLAYERBANKSLOTS_CHANGED");
		this:RegisterEvent("GUILD_ROSTER_UPDATE");
		GuildRoster();
		Toons_RequestTimePlayed();
		ToonsTab_Update("xp", UnitXP("player"));
		ToonsTab_Update("xpmax", UnitXPMax("player"));
	elseif (event=="PLAYER_LEAVING_WORLD") then
		this:UnregisterEvent("BAG_UPDATE");
		this:UnregisterEvent("GUILD_ROSTER_UPDATE");
	elseif (event=="PLAYER_LOGOUT") then
		TOONSVAR.sortOrder = ToonsFrame.sortOrder;
		TOONSVAR.page = ToonsFrame.page;
	elseif (event=="VARIABLES_LOADED") then
		local server = GetRealmName();
		local player = UnitName("player");
		local race = UnitRace("player");
		local class = UnitClass("player");
		local level = UnitLevel("player");
		local gold = GetMoney();
		local zone = GetZoneText();
		if ( not TOONSTAB) then
			TOONSTAB = {};
		end
		if ( not TOONSTAB[server] ) then
			TOONSTAB[server] = {};
		end
		if ( not TOONSTAB[server][player] ) then
			TOONSTAB[server][player] = {};
		end
		TOONSTAB[server][player].name = player;
		TOONSTAB[server][player].race = race;
		TOONSTAB[server][player].class = class;
		TOONSTAB[server][player].level = level;
		TOONSTAB[server][player].gold = gold;
		TOONSTAB[server][player].zone = zone;

		if ( not TOONSVAR.sortOrder ) then
			TOONSVAR.sortOrder = "LEVEL_DOWN";
		end
		if ( not TOONSVAR.page ) then
			TOONSVAR.page = "STATSFRAME";
		end
		ToonsFrame.sortOrder = TOONSVAR.sortOrder;
		ToonsFrame.page = TOONSVAR.page;
		ToonsFrame.server = server;
		ToonsPage = ToonsPage_Sort();
		ToonsServer = ToonsServer_Sort();
	end
end

function ToonsFrame_Update( server, page )
	if ( not server ) then
		server = ToonsFrame.server;
	elseif ( TOONSTAB[server] ) then
		ToonsFrame.server = server;
	else
		server = GetRealmName();
		ToonsFrame.server = server;
	end
	if ( not page ) then
		page = ToonsFrame.page;
	elseif ( TOONSPAGES[page] ) then
		ToonsFrame.page = page;
	else
		page = "STATSFRAME";
		ToonsFrame.page = page;
	end

	ToonsTab_Update( "level", UnitLevel("player") );
	ToonsTab_Update( "zone", GetZoneText() );
	ToonsTab_Update( "gold", GetMoney() );

	local totalgold = 0;
	local totalplayed = 0;
	local sorted = ToonsFrame_Sort(TOONSSORT[ToonsFrame.sortOrder], server);
	local index = getn(sorted);
	for i=1, index do
		local stats=sorted[i];

		totalgold = totalgold + (stats.gold or 0);
		totalplayed = totalplayed + (stats.timeplayed or 0);
	end
	MoneyFrame_Update("ToonsFrameMoneyFrame", totalgold);
	ToonsFrameTotalPlayedText:SetText( ToonsFrame_FormatTimePlayed(totalplayed) );

	ToonsFramePlayedFrame:Hide();
	ToonsFrameStatsFrame:Hide();
	ToonsFrameGuildFrame:Hide();
	ToonsFrameAssetsFrame:Hide();
	ToonsFrameTradeskillFrame:Hide();
	ToonsFrameXPFrame:Hide();

	if ( page=="STATSFRAME" ) then
		ToonsFrameStatsFrame:Show();

		for i=1, index do
			if ( i > MAX_TOONS ) then
				break;
			end

			local stats=sorted[i];
			local color;
		--stats frame
			getglobal("ToonsFramePlayerButton"..i).player=stats.name;
			getglobal("ToonsFramePlayerButton"..i.."Name"):SetText(stats.name);
			getglobal("ToonsFramePlayerButton"..i.."Level"):SetText(stats.level);
			color = {r=(stats.level)/60, g=1-(stats.level)/60, b=0 };
			getglobal("ToonsFramePlayerButton"..i.."Level"):SetTextColor(color.r, color.g, color.b);
			getglobal("ToonsFramePlayerButton"..i.."Race"):SetText(stats.race);
			color = TOONS_RACES[strupper(stats.race)].color;
			getglobal("ToonsFramePlayerButton"..i.."Race"):SetTextColor(color.r, color.g, color.b);
			getglobal("ToonsFramePlayerButton"..i.."Class"):SetText(stats.class);
			color = RAID_CLASS_COLORS[strupper(stats.class)];
			getglobal("ToonsFramePlayerButton"..i.."Class"):SetTextColor(color.r, color.g, color.b);
			getglobal("ToonsFramePlayerButton"..i.."Zone"):SetText(stats.zone);

			-- Highlight the correct player
			local button = getglobal("ToonsFramePlayerButton"..i);
			button:Show();
			if ( ToonsFrame.selectedToon == i ) then
				button:LockHighlight();
			else
				button:UnlockHighlight();
			end
		end
		
		for i=index+1, MAX_TOONS do
			local button = getglobal("ToonsFramePlayerButton"..i);
			getglobal("ToonsFramePlayerButton"..i.."Name"):SetText("");
			getglobal("ToonsFramePlayerButton"..i.."Level"):SetText("");
			getglobal("ToonsFramePlayerButton"..i.."Race"):SetText("");
			getglobal("ToonsFramePlayerButton"..i.."Class"):SetText("");
			getglobal("ToonsFramePlayerButton"..i.."Zone"):SetText("");
			--button.player = nil;
			button:UnlockHighlight();
			button:Hide();
		end
	elseif ( page=="PLAYEDFRAME" ) then
		ToonsFramePlayedFrame:Show();

		for i=1, index do
			if ( i > MAX_TOONS ) then
				break;
			end

			local stats=sorted[i];
		--time played frame
			getglobal("ToonsFramePlayedButton"..i).player=stats.name;
			getglobal("ToonsFramePlayedButton"..i.."Name"):SetText(stats.name);
			getglobal("ToonsFramePlayedButton"..i.."TimePlayed"):SetText( ToonsFrame_FormatTimePlayed( stats.timeplayed) );
			getglobal("ToonsFramePlayedButton"..i.."TimeAtLevel"):SetText( ToonsFrame_FormatTimePlayed( stats.timeatlevel) );

			-- Highlight the correct player
			local button = getglobal("ToonsFramePlayedButton"..i);
			button:Show();
			if ( ToonsFrame.selectedToon == i ) then
				button:LockHighlight();
			else
				button:UnlockHighlight();
			end
		end
				
		for i=index+1, MAX_TOONS do
			local button = getglobal("ToonsFramePlayedButton"..i);
			getglobal("ToonsFramePlayedButton"..i.."Name"):SetText("");
			getglobal("ToonsFramePlayedButton"..i.."TimePlayed"):SetText("");
			getglobal("ToonsFramePlayedButton"..i.."TimeAtLevel"):SetText("");
			--button.player = nil;
			button:UnlockHighlight();
			button:Hide();
		end
	elseif ( page=="GUILDFRAME" ) then
		ToonsFrameGuildFrame:Show();
		for i=1, index do
			if ( i > MAX_TOONS ) then
				break;
			end

			local stats=sorted[i];
		--guild frame
			getglobal("ToonsFrameGuildButton"..i).player=stats.name;
			getglobal("ToonsFrameGuildButton"..i.."Name"):SetText(stats.name);
			getglobal("ToonsFrameGuildButton"..i.."GuildName"):SetText(stats.guild);
			getglobal("ToonsFrameGuildButton"..i.."GuildRank"):SetText(stats.guildrank);

			-- Highlight the correct player
			local button = getglobal("ToonsFrameGuildButton"..i);
			button:Show();
			if ( ToonsFrame.selectedToon == i ) then
				button:LockHighlight();
			else
				button:UnlockHighlight();
			end
		end
				
		for i=index+1, MAX_TOONS do
			local button = getglobal("ToonsFrameGuildButton"..i);
			getglobal("ToonsFrameGuildButton"..i.."Name"):SetText("");
			getglobal("ToonsFrameGuildButton"..i.."GuildName"):SetText("");
			getglobal("ToonsFrameGuildButton"..i.."GuildRank"):SetText("");
			--button.player = nil;
			button:UnlockHighlight();
			button:Hide();
		end
	elseif ( page=="ASSETSFRAME" ) then
		ToonsFrameAssetsFrame:Show();
		for i=1, index do
			if ( i > MAX_TOONS ) then
				break;
			end

			local stats=sorted[i];
		--assets frame
			getglobal("ToonsFrameAssetsButton"..i).player=stats.name;
			getglobal("ToonsFrameAssetsButton"..i.."Name"):SetText(stats.name);
			MoneyFrame_Update("ToonsFrameAssetsButton"..i.."Gold", stats.gold);
			getglobal("ToonsFrameAssetsButton"..i.."Bags"):SetText((stats.bagssize or 0).."/"..(stats.bagsmax or 0));
			getglobal("ToonsFrameAssetsButton"..i.."Bank"):SetText((stats.banksize or 0).."/"..(stats.bankmax or 0));

			-- Highlight the correct player
			local button = getglobal("ToonsFrameAssetsButton"..i);
			button:Show();
			if ( ToonsFrame.selectedToon == i ) then
				button:LockHighlight();
			else
				button:UnlockHighlight();
			end
		end
				
		for i=index+1, MAX_TOONS do
			local button = getglobal("ToonsFrameAssetsButton"..i);
			getglobal("ToonsFrameAssetsButton"..i.."Name"):SetText("");
			MoneyFrame_Update("ToonsFrameAssetsButton"..i.."Gold", 0);
			--button.player = nil;
			button:UnlockHighlight();
			button:Hide();
		end
	elseif ( page=="TRADESKILLFRAME" ) then
		ToonsFrameTradeskillFrame:Show();
		for i=1, index do
			if ( i > MAX_TOONS ) then
				break;
			end

			local stats=sorted[i];
		--tradeskill frame
			local color, text;
			getglobal("ToonsFrameTradeskillButton"..i).player=stats.name;
			getglobal("ToonsFrameTradeskillButton"..i.."Name"):SetText(stats.name);

			getglobal("ToonsFrameTradeskillButton"..i.."Tradeskill1"):SetText(stats.tradeskill1);
			color = getglobal(SKILL_TYPE[stats.tradeskill1] and SKILL_TYPE[stats.tradeskill1].color) or NORMAL_FONT_COLOR;

			getglobal("ToonsFrameTradeskillButton"..i.."Tradeskill1"):SetTextColor(color.r, color.g, color.b);
			if ( stats.tradeskill1rank ) then
				text = stats.tradeskill1rank.."/"..stats.tradeskill1max;
			else
				text = "";
			end
			getglobal("ToonsFrameTradeskillButton"..i.."Tradeskill1Rank"):SetText(text);
			color = {r=(stats.tradeskill1rank or 0)/300, g=.5+(stats.tradeskill1rank or 0)/600, b=(stats.tradeskill1rank or 0)/300 };

			getglobal("ToonsFrameTradeskillButton"..i.."Tradeskill1Rank"):SetTextColor(color.r, color.g, color.b);
			getglobal("ToonsFrameTradeskillButton"..i.."Tradeskill2"):SetText(stats.tradeskill2);
			color = getglobal(SKILL_TYPE[stats.tradeskill2] and SKILL_TYPE[stats.tradeskill2].color) or NORMAL_FONT_COLOR;
			getglobal("ToonsFrameTradeskillButton"..i.."Tradeskill2"):SetTextColor(color.r, color.g, color.b);

			if ( stats.tradeskill2rank ) then
				text = stats.tradeskill2rank.."/"..stats.tradeskill2max;
			else
				text = "";
			end
			getglobal("ToonsFrameTradeskillButton"..i.."Tradeskill2Rank"):SetText(text);
			color = {r=(stats.tradeskill2rank or 0)/300, g=.5+(stats.tradeskill2rank or 0)/600, b=(stats.tradeskill2rank or 0)/300 };
			getglobal("ToonsFrameTradeskillButton"..i.."Tradeskill2Rank"):SetTextColor(color.r, color.g, color.b);

			-- Highlight the correct player
			local button = getglobal("ToonsFrameTradeskillButton"..i);
			button:Show();
			if ( ToonsFrame.selectedToon == i ) then
				button:LockHighlight();
			else
				button:UnlockHighlight();
			end
		end
				
		for i=index+1, MAX_TOONS do
			local button = getglobal("ToonsFrameTradeskillButton"..i);
			getglobal("ToonsFrameTradeskillButton"..i.."Name"):SetText("");
			--button.player = nil;
			button:UnlockHighlight();
			button:Hide();
		end
	elseif ( page=="XPFRAME" ) then
		ToonsFrameXPFrame:Show();
		for i=1, index do
			if ( i > MAX_TOONS ) then
				break;
			end

			local stats=sorted[i];
		--experience frame
			getglobal("ToonsFrameXPButton"..i).player=stats.name;
			getglobal("ToonsFrameXPButton"..i.."Name"):SetText(stats.name);
			getglobal("ToonsFrameXPButton"..i.."XP"):SetText(stats.xp);
			getglobal("ToonsFrameXPButton"..i.."XPMax"):SetText(stats.xpmax);
			if ( stats.xp ) then
				getglobal("ToonsFrameXPButton"..i.."XPPercent"):SetText(floor((stats.xp / stats.xpmax)*100));
			else
				getglobal("ToonsFrameXPButton"..i.."XPPercent"):SetText("");
			end

			-- Highlight the correct player
			local button = getglobal("ToonsFrameXPButton"..i);
			button:Show();
			if ( ToonsFrame.selectedToon == i ) then
				button:LockHighlight();
			else
				button:UnlockHighlight();
			end
		end
				
		for i=index+1, MAX_TOONS do
			local button = getglobal("ToonsFrameXPButton"..i);
			getglobal("ToonsFrameXPButton"..i.."Name"):SetText("");
			getglobal("ToonsFrameXPButton"..i.."XP"):SetText("");
			getglobal("ToonsFrameXPButton"..i.."XPMax"):SetText("");
			getglobal("ToonsFrameXPButton"..i.."XPPercent"):SetText("");
			--button.player = nil;
			button:UnlockHighlight();
			button:Hide();
		end
	end
	--show individual info for selected toon
	local stats=sorted[ToonsFrame.selectedToon];
	if ( stats ) then
		ToonsFrameIndividualFrame:Show();
		ToonsFrameIndividualGoldFrame:Hide();
		local text, font = "";

		-- stats
		font = ToonsFrameIndividualStatsText;
		text = NORMAL_FONT_COLOR_CODE..stats.name.."|r ";
		text = text..", Level "..stats.level.." ";
		text = text..TOONS_RACES[strupper(stats.race)].fontcolor..stats.race.."|r ";
		text = text..TOONS_CLASSES[strupper(stats.class)].fontcolor..stats.class.."|r ";
		text = text.." @ "..stats.zone.." ";
		font:SetText(text);
		
		-- experience
		font = ToonsFrameIndividualXPText;
		text = NORMAL_FONT_COLOR_CODE..EXPERIENCE_COLON.."|r ";
		if ( stats.xp ) then
			text = text..stats.xp.." / "..stats.xpmax.." @ "..(floor((stats.xp / stats.xpmax)*100)).."%";
		end
		font:SetText(text);

		-- played
		font = ToonsFrameIndividualPlayedText;
		text = NORMAL_FONT_COLOR_CODE..TIMEPLAYED..":|r ";
		text = text..ToonsFrame_FormatTimePlayed(stats.timeplayed).." ";
		text = text..NORMAL_FONT_COLOR_CODE..THISLEVEL..":|r ";
		text = text..ToonsFrame_FormatTimePlayed(stats.timeatlevel).." ";
		font:SetText(text);

		-- guild
		font = ToonsFrameIndividualGuildText;
		if ( stats.guild ) then
			text = NORMAL_FONT_COLOR_CODE..GUILD..":|r ";
			text = text..stats.guild.."   ";
			text = text..NORMAL_FONT_COLOR_CODE..RANK..":|r ";
			text = text..stats.guildrank.." ";
		else
			text = oldGuildErrorMsg;
		end
		font:SetText(text);

		-- assets
		MoneyFrame_Update("ToonsFrameIndividualGoldFrame", stats.gold);
		ToonsFrameIndividualGoldFrame:Show();
		font = ToonsFrameIndividualAssetsText;
		text = NORMAL_FONT_COLOR_CODE..BAGS.."|r ";
		text = text..(stats.bagssize or 0).."/"..(stats.bagsmax or 0).." ";
		text = text..NORMAL_FONT_COLOR_CODE..BANK.."|r ";
		text = text..(stats.banksize or 0).."/"..(stats.bankmax or 0).." ";
		font:SetText(text);

		-- tradeskills
		font = ToonsFrameIndividualTradeskillText;
		if ( not stats.tradeskill1 ) then
			text = NO_PROFESSIONS;
		else
			text = NORMAL_FONT_COLOR_CODE..TRADE_SKILL.." 1:|r ";
			local color = getglobal(SKILL_TYPE[stats.tradeskill1].color.."_CODE");
			text = text..color..stats.tradeskill1.."|r  ";
			color=format("|cff%2x%2x%2x", stats.tradeskill1rank/300*255, (.5+stats.tradeskill1rank/600)*255, stats.tradeskill1rank/300*255);
			text = text..color..stats.tradeskill1rank.."/"..stats.tradeskill1max.." "..SKILL_RANK[stats.tradeskill1max].."|r ";

			if (stats.tradeskill2 ) then
				text = text.."\n"..NORMAL_FONT_COLOR_CODE..TRADE_SKILL.." 2:|r ";
				color = getglobal(SKILL_TYPE[stats.tradeskill2].color.."_CODE");
				text = text..color..stats.tradeskill2.."|r  ";
				color=format("|cff%2x%2x%2x", stats.tradeskill2rank/300*255, (.5+stats.tradeskill2rank/600)*255, stats.tradeskill2rank/300*255);
				text = text..color..stats.tradeskill2rank.."/"..stats.tradeskill2max.." "..SKILL_RANK[stats.tradeskill2max].."|r ";
			end
		end
		font:SetText(text);
	else
		ToonsFrameIndividualFrame:Hide();		
	end
	
end

function FriendsFrameTab_OnLoad()
	local parent = FriendsFrame;
	local numTabs = parent.numTabs+1;
	PanelTemplates_SetNumTabs(parent, numTabs);
	PanelTemplates_EnableTab(parent, numTabs);
end

function FriendsFrameTab_CreateTab( subframe, subtext )
	local n=FriendsFrame.numTabs+1;
	local framename = "FriendsFrameTab"..n;
	frame = CreateFrame("Button", framename, FriendsFrame);
	frame:SetWidth(115);
	frame:SetHeight(32);
	frame:SetID(n);
	frame:SetPoint("LEFT", getglobal("FriendsFrameTab"..n-1), "RIGHT", -14, 0);
	frame:SetFrameLevel(FriendsFrame:GetFrameLevel() + 4);

	frame:SetScript("ONCLICK", function()
		PanelTemplates_Tab_OnClick(FriendsFrame);
		FriendsFrame_OnShow();
		GuildControlPopupFrame:Hide();
		GuildMemberDetailFrame:Hide();
		GuildInfoFrame:Hide();
		GuildFrame:Hide();
	end );
	frame:SetScript("ONSHOW", function()
		PanelTemplates_TabResize(0);
		getglobal(this:GetName().."HighlightTexture"):SetWidth(this:GetTextWidth() + 30);
	end );

	-- textures
	local texture;
	
	texture = frame:CreateTexture(framename.."LeftDisabled", "BACKGROUND");
	texture:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-ActiveTab");
	texture:SetWidth(20);
	texture:SetHeight(32);
	texture:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 5);
	texture:SetTexCoord( 0, 0.15625, 0, 1.0 );
	
	texture = frame:CreateTexture(framename.."MiddleDisabled", "BACKGROUND");
	texture:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-ActiveTab");
	texture:SetWidth(88);
	texture:SetHeight(32);
	texture:SetPoint("LEFT", framename.."LeftDisabled", "RIGHT");
	texture:SetTexCoord( 0.15625, 0.84375, 0, 1.0 );
	
	texture = frame:CreateTexture(framename.."RightDisabled", "BACKGROUND");
	texture:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-ActiveTab");
	texture:SetWidth(20);
	texture:SetHeight(32);
	texture:SetPoint("LEFT", framename.."MiddleDisabled", "RIGHT");
	texture:SetTexCoord( 0.84375, 1.0, 0, 1.0 );
	
	texture = frame:CreateTexture(framename.."Left", "BACKGROUND");
	texture:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-InActiveTab");
	texture:SetWidth(20);
	texture:SetHeight(32);
	texture:SetPoint("TOPLEFT", frame, "TOPLEFT");
	texture:SetTexCoord( 0, 0.15625, 0, 1.0 );
	
	texture = frame:CreateTexture(framename.."Middle", "BACKGROUND");
	texture:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-InActiveTab");
	texture:SetWidth(88);
	texture:SetHeight(32);
	texture:SetPoint("LEFT", framename.."Left", "RIGHT");
	texture:SetTexCoord( 0.15625, 0.84375, 0, 1.0 );
	
	texture = frame:CreateTexture(framename.."Right", "BACKGROUND");
	texture:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-InActiveTab");
	texture:SetWidth(20);
	texture:SetHeight(32);
	texture:SetPoint("LEFT", framename.."Middle", "RIGHT");
	texture:SetTexCoord( 0.84375, 1.0, 0, 1.0 );
	
	texture = frame:CreateTexture(framename.."HighlightTexture");
	texture:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-Tab-Highlight");
	texture:SetPoint("LEFT", framename, "LEFT", 10, 2);
	texture:SetPoint("RIGHT", framename, "RIGHT", -10, 2);
	texture:SetBlendMode("ADD");
	frame:SetHighlightTexture(texture);
	
	-- texts
	local font;
	
	font = frame:CreateFontString(framename.."Text");
	font:SetFontObject(GameFontNormalSmall);
	font:SetPoint("CENTER", frame, "CENTER", 0, 2);
	frame:SetTextFontObject(font:GetFontObject());
	font:SetText(subtext);

	font = frame:CreateFontString(framename.."HighlightText");
	font:SetFontObject(GameFontHighlightSmall);
	font:SetPoint("CENTER", frame, "CENTER", 0, 2);
	frame:SetHighlightFontObject(font:GetFontObject());

	font = frame:CreateFontString(framename.."DisabledText");
	font:SetFontObject(GameFontDisabledSmall);
	font:SetPoint("CENTER", frame, "CENTER", 0, 2);
	frame:SetDisabledFontObject(font:GetFontObject());

	FriendsFrameTab_OnLoad(); -- add to panel of tabs
	return frame, framename;
end

function FriendsFrameToonsTab_Initialize( frame )
	frame:SetScript("ONEVENT", FriendsFrame_Update);
	frame:SetScript("ONENTER", function()
		GameTooltip_AddNewbieTip(MicroButtonTooltipText(TEXT(TOONS), "TOGGLETOONSTAB"), 1.0, 1.0, 1.0, NEWBIE_TOOLTIP_TOONSTAB, 1);
	end );
	frame:SetScript("ONLEAVE", function()
		GameTooltip:Hide();
	end );
end

local oldFriendsFrame_Update = FriendsFrame_Update;
function FriendsFrame_Update()
	local frame=getglobal(ToonsTabFrame);
	if ( FriendsFrame.selectedTab == frame:GetID() ) then
		FriendsFrameTopLeft:SetTexture("Interface\\ClassTrainerFrame\\UI-ClassTrainer-TopLeft");
		FriendsFrameTopRight:SetTexture("Interface\\ClassTrainerFrame\\UI-ClassTrainer-TopRight");
		FriendsFrameBottomLeft:SetTexture("Interface\\FriendsFrame\\WhoFrame-BotLeft");
		FriendsFrameBottomRight:SetTexture("Interface\\FriendsFrame\\WhoFrame-BotRight");

		FriendsFrameTitleText:SetText(TOONS);
		FriendsFrame_ShowSubFrame("ToonsFrame");
		ToonsFrame_Update();
	else
		oldFriendsFrame_Update();
	end
end

function FriendsFrameToonsPlayerButton_OnClick(button)
	if ( button == "LeftButton" ) then
		ToonsFrame.selectedToon = this:GetID();
		ToonsFrame_Update();
	end
end

function ToonsFrameDeleteButton_OnClick(button)
	if ( ToonsFrame.selectedToon ) then
		local player = getglobal("ToonsFramePlayerButton"..ToonsFrame.selectedToon).player;
		local server = ToonsFrame.server;
		if ( player~=UnitName("player") and TOONSTAB[server][player] ) then
			TOONSTAB[server][player]=nil;
			ToonsFrame.selectedToon = nil;
		end
	end
	ToonsFrame_Update();
end

function ToonsTab_Update( key, value )
	local server = GetRealmName();
	local player = UnitName("player");
	if ( TOONSTAB and TOONSTAB[server] and TOONSTAB[server][player] ) then
		TOONSTAB[server][player][key] = value;
		return key, value;
	end
end

function ToonsTab_UpdateAll()
	local level = UnitLevel("player");
	TOONSTAB[server][player].level = level;
	local gold = GetMoney();
	TOONSTAB[server][player].gold = gold;
	local zone = GetZoneText();
	TOONSTAB[server][player].zone = zone;
end

function ToonsFrameServerDropDown_OnLoad()
	UIDropDownMenu_Initialize(this, ToonsFrameServerDropDown_Initialize);
	UIDropDownMenu_SetWidth(130);
end

function ToonsFrameServerDropDown_Initialize()
	local info;
	for i=1, getn(ToonsServer) do
		info = {};
		info.text = ToonsServer[i];
		if ( info.text==ToonsFrame.server ) then
			info.checked = 1;
		end
		info.owner = ToonsFrameServerDropDown;
		info.func = ToonsFrameServerButton_OnClick;
		UIDropDownMenu_AddButton(info);
	end
end

function ToonsFrameServerButton_OnClick()
	UIDropDownMenu_SetSelectedID(ToonsFrameServerDropDown, this:GetID());
	ToonsFrame_Update(this:GetText());
end

function ToonsFramePageDropDown_OnLoad()
	UIDropDownMenu_Initialize(this, ToonsFramePageDropDown_Initialize);
	UIDropDownMenu_SetWidth(80);
end

function ToonsFramePageDropDown_Initialize()
	local info;
	for i=1, getn(ToonsPage) do
		info = {};
		info.text = TOONSPAGES[ToonsPage[i]].name;
		if ( info.text==ToonsFrame.page ) then
			info.checked = 1;
		end
		info.owner = ToonsFramePageDropDown;
		info.func = ToonsFramePageButton_OnClick;
		UIDropDownMenu_AddButton(info);
	end
end

function ToonsFramePageButton_OnClick(arg1, arg2)
	UIDropDownMenu_SetSelectedID(ToonsFramePageDropDown, this:GetID());
	ToonsFrame_Update(nil, ToonsPage[this:GetID()]);
end

function ToonsFrame_Sort( sortfunc, server )
	local t={};
	for player,v in TOONSTAB[server] do
		table.insert(t, player);
	end
	sort(t, function(a,b)
		local c,d=TOONSTAB[server][a], TOONSTAB[server][b];
		return sortfunc(c,d);
		end
	);
	local s={};
	for i=1, getn(t) do
		tinsert(s,TOONSTAB[server][t[i]]);
	end
	return s;
end

function Toons_SortLevelUp( player1, player2 )
	if ( player1 and player2 ) then
		return player1.level < player2.level;
	end
end

function Toons_SortLevelDown( player1, player2 )
	if ( player1 and player2 ) then
		return player1.level > player2.level;
	end
end

function Toons_SortNameUp( player1, player2 )
	if ( player1 and player2 ) then
		return player1.name < player2.name;
	end
end

function Toons_SortNameDown( player1, player2 )
	if ( player1 and player2 ) then
		return player1.name > player2.name;
	end
end


function Toons_SortRaceUp( player1, player2 )
	if ( player1 and player2 ) then
		return TOONS_RACES[strupper(player1.race)].id < TOONS_RACES[strupper(player2.race)].id;
	end
end

function Toons_SortRaceDown( player1, player2 )
	if ( player1 and player2 ) then
		return TOONS_RACES[strupper(player1.race)].id > TOONS_RACES[strupper(player2.race)].id;
	end
end

function Toons_SortClassUp( player1, player2 )
	if ( player1 and player2 ) then
		return player1.class < player2.class;
	end
end

function Toons_SortClassDown( player1, player2 )
	if ( player1 and player2 ) then
		return player1.class > player2.class;
	end
end

function Toons_SortZoneUp( player1, player2 )
	if ( player1 and player2 ) then
		return player1.zone < player2.zone;
	end
end

function Toons_SortZoneDown( player1, player2 )
	if ( player1 and player2 ) then
		return player1.zone > player2.zone;
	end
end

function Toons_SortTimePlayedUp( player1, player2 )
	if ( player1 and player2 ) then
		return player1.timeplayed < player2.timeplayed;
	end
end

function Toons_SortTimePlayedDown( player1, player2 )
	if ( player1 and player2 ) then
		return player1.timeplayed > player2.timeplayed;
	end
end

function Toons_SortTimeAtLevelUp( player1, player2 )
	if ( player1 and player2 ) then
		return player1.timeatlevel < player2.timeatlevel;
	end
end

function Toons_SortTimeAtLevelDown( player1, player2 )
	if ( player1 and player2 ) then
		return player1.timeatlevel > player2.timeatlevel;
	end
end

function Toons_SortGuildNameUp( player1, player2 )
	if ( player1 and player2 ) then
		return (player1.guild or "") < (player2.guild or "");
	end
end

function Toons_SortGuildNameDown( player1, player2 )
	if ( player1 and player2 ) then
		return (player1.guild or "") > (player2.guild or "");
	end
end

function Toons_SortGuildRankUp( player1, player2 )
	if ( player1 and player2 ) then
		return (player1.guildrank or "") < (player2.guildrank or "");
	end
end

function Toons_SortGuildRankDown( player1, player2 )
	if ( player1 and player2 ) then
		return (player1.guildrank or "") > (player2.guildrank or "");
	end
end

function Toons_SortXPUp( player1, player2 )
	if ( player1 and player2 ) then
		return (player1.xp or -1) < (player2.xp or -1);
	end
end

function Toons_SortXPDown( player1, player2 )
	if ( player1 and player2 ) then
		return (player1.xp or -1) > (player2.xp or -1);
	end
end

function Toons_SortXPMaxUp( player1, player2 )
	if ( player1 and player2 ) then
		return (player1.xpmax or -1) < (player2.xpmax or -1);
	end
end

function Toons_SortXPMaxDown( player1, player2 )
	if ( player1 and player2 ) then
		return (player1.xpmax or -1) > (player2.xpmax or -1);
	end
end

function Toons_SortXPPercentUp( player1, player2 )
	if ( player1 and player2 ) then
		return (player1.xp and player1.xp/player1.xpmax or -1) < (player2.xp and player2.xp/player2.xpmax or -1);
	end
end

function Toons_SortXPPercentDown( player1, player2 )
	if ( player1 and player2 ) then
		return (player1.xp and player1.xp/player1.xpmax or -1) > (player2.xp and player2.xp/player2.xpmax or -1);
	end
end

function Toons_SortGoldUp( player1, player2 )
	if ( player1 and player2 ) then
		return (player1.gold or 0) < (player2.gold or 0);
	end
end

function Toons_SortGoldDown( player1, player2 )
	if ( player1 and player2 ) then
		return (player1.gold or 0) > (player2.gold or 0);
	end
end

function Toons_SortBagsUp( player1, player2 )
	if ( player1 and player2 ) then
		local s1= player1.bagsmax or 0;
		local s2= player2.bagsmax or 0;
		if ( s1 < s2 ) then
			return true;
		elseif ( s1==s2 ) then
			s1= player1.bagssize or 0;
			s2= player2.bagssize or 0;
			if ( s1 < s2 ) then
				return true;
			end
		end
	end
end

function Toons_SortBagsDown( player1, player2 )
	if ( player1 and player2 ) then
		local s1= player1.bagsmax or 0;
		local s2= player2.bagsmax or 0;
		if ( s1 > s2 ) then
			return true;
		elseif ( s1==s2 ) then
			s1= player1.bagssize or 0;
			s2= player2.bagssize or 0;
			if ( s1 > s2 ) then
				return true;
			end
		end
	end
end

function Toons_SortBankUp( player1, player2 )
	if ( player1 and player2 ) then
		local s1= player1.bankmax or 0;
		local s2= player2.bankmax or 0;
		if ( s1 < s2 ) then
			return true;
		elseif ( s1==s2 ) then
			s1= player1.banksize or 0;
			s2= player2.banksize or 0;
			if ( s1 < s2 ) then
				return true;
			end
		end
	end
end

function Toons_SortBankDown( player1, player2 )
	if ( player1 and player2 ) then
		local s1= player1.bankmax or 0;
		local s2= player2.bankmax or 0;
		if ( s1 > s2 ) then
			return true;
		elseif ( s1==s2 ) then
			s1= player1.banksize or 0;
			s2= player2.banksize or 0;
			if ( s1 > s2 ) then
				return true;
			end
		end
	end
end

function Toons_SortTradeskill1Up( player1, player2 )
	if ( player1 and player2 ) then
		local s1= player1.tradeskill1 and SKILL_TYPE[player1.tradeskill1].id or 99;
		local s2= player2.tradeskill1 and SKILL_TYPE[player2.tradeskill1].id or 99;
		if ( s1 < s2 ) then
			return true;
		end
	end
end

function Toons_SortTradeskill1Down( player1, player2 )
	if ( player1 and player2 ) then
		local s1= player1.tradeskill1 and SKILL_TYPE[player1.tradeskill1].id or 0;
		local s2= player2.tradeskill1 and SKILL_TYPE[player2.tradeskill1].id or 0;
		if ( s1 > s2 ) then
			return true;
		end
	end
end

function Toons_SortTradeskill2Up( player1, player2 )
	if ( player1 and player2 ) then
		local s1= player1.tradeskill2 and SKILL_TYPE[player1.tradeskill2].id or 99;
		local s2= player2.tradeskill2 and SKILL_TYPE[player2.tradeskill2].id or 99;
		if ( s1 < s2 ) then
			return true;
		elseif ( s1==s2) then
			s1= player1.tradeskill1 and SKILL_TYPE[player1.tradeskill1].id or 99;
			s2= player2.tradeskill1 and SKILL_TYPE[player2.tradeskill1].id or 99;
			if ( s1 < s2 ) then
				return true;
			end
		end
	end
end

function Toons_SortTradeskill2Down( player1, player2 )
	if ( player1 and player2 ) then
		local s1= player1.tradeskill2 and SKILL_TYPE[player1.tradeskill2].id or 0;
		local s2= player2.tradeskill2 and SKILL_TYPE[player2.tradeskill2].id or 0;
		if ( s1 > s2 ) then
			return true;
		elseif ( s1==s2 ) then
			s1= player1.tradeskill1 and SKILL_TYPE[player1.tradeskill1].id or 0;
			s2= player2.tradeskill1 and SKILL_TYPE[player2.tradeskill1].id or 0;
			if ( s1 > s2 ) then
				return true;
			end
		end
	end
end

function Toons_SortTradeskill1RankUp( player1, player2 )
	if ( player1 and player2 ) then
		local s1= player1.tradeskill1rank or 999;
		local s2= player2.tradeskill1rank or 999;
		if ( s1 < s2 ) then
			return true;
		end
	end
end

function Toons_SortTradeskill1RankDown( player1, player2 )
	if ( player1 and player2 ) then
		local s1= player1.tradeskill1rank or 0;
		local s2= player2.tradeskill1rank or 0;
		if ( s1 > s2 ) then
			return true;
		end
	end
end

function Toons_SortTradeskill2RankUp( player1, player2 )
	if ( player1 and player2 ) then
		local s1= player1.tradeskill2rank or 999;
		local s2= player2.tradeskill2rank or 999;
		if ( s1 < s2 ) then
			return true;
		elseif ( s1==s2 ) then
			s1= player1.tradeskill1rank or 999;
			s2= player2.tradeskill1rank or 999;
			if ( s1 < s2 ) then
				return true;
			end
		end
	end
end

function Toons_SortTradeskill2RankDown( player1, player2 )
	if ( player1 and player2 ) then
		local s1= player1.tradeskill2rank or 0;
		local s2= player2.tradeskill2rank or 0;
		if ( s1 > s2 ) then
			return true;
		elseif ( s1==s2 ) then
			s1= player1.tradeskill1rank or 0;
			s2= player2.tradeskill1rank or 0;
			if ( s1 > s2 ) then
				return true;
			end
		end
	end
end

function ToonsServer_Sort()
	local t={};
	for server, v in TOONSTAB do
		tinsert(t,server);
	end
	sort(t);
	return t;
end

function ToonsServer_GetID( server )
	for i=1, getn(ToonsServer) do
		if ( ToonsServer[i]==server ) then
			return i;
		end
	end
end

function ToonsPage_GetID( page )
	for i=1, getn(ToonsPage) do
		if ( ToonsPage[i]==page ) then
			return i;
		end
	end
end

function ToonsPage_Sort()
	local t={};
	local i=1;
	for page, v in TOONSPAGES do
		tinsert(t, min(v.id,i), page);
		i=i+1;
	end
	return t;
end

function ToonsFrame_FormatTimePlayed( played )
	return format(TIMEPLAYEDFORMAT, ChatFrame_TimeBreakDown(played or 0) )
end

function Toons_RequestTimePlayed()
	Toons_RequestTime = 1;
	RequestTimePlayed();
end

local old_ChatFrame_DisplayTimePlayed = ChatFrame_DisplayTimePlayed;
function Toons_ChatFrame_DisplayTimePlayed(totalTime, levelTime)
	if ( Toons_RequestTime ) then
		Toons_RequestTime = nil;
		return;
	else
		old_ChatFrame_DisplayTimePlayed(totalTime, levelTime);
	end
end

function Toons_BagsSizeUpdate()
	local size, max = 0, 0;
	for bag=0,4 do
		max = max+GetContainerNumSlots(bag);
		for slot=1, GetContainerNumSlots(bag) do
			local texture, itemCount = GetContainerItemInfo(bag, slot);
			if ( itemCount ) then
				size = size + 1;
			end
		end
	end
	ToonsTab_Update( "bagssize", size );
	ToonsTab_Update( "bagsmax", max );
	return size, max;
end

function Toons_BankSizeUpdate()
	local size, max = 0, 24;
	for slotId=40,63 do -- bank slots as inventory ids
		if ( GetInventoryItemLink("player", slotId) ) then
			size = size + 1;
		end
	end
	for bag=NUM_BAG_SLOTS+1, NUM_BAG_SLOTS+GetNumBankSlots() do
		max = max+GetContainerNumSlots(bag);
		for slot=1, GetContainerNumSlots(bag) do
			if ( GetContainerItemLink(bag, slot) ) then
				size = size + 1;
			end
		end
	end
	ToonsTab_Update( "banksize", size );
	ToonsTab_Update( "bankmax", max );
	return size, max;
end

function Toons_GetTradeskillInfo()
	local profIndex=0;
	for j=5,7 do
		if ( GetSkillLineInfo(j)==TRADE_SKILLS ) then
			profIndex = j;
			break;
		end
	end
	local server, player = GetRealmName(), UnitName("player");
	for i=1,2 do
		local skill, header, _, curr, _, _, max = GetSkillLineInfo(i+profIndex);
		local oldskill, oldrank = TOONSTAB[server][player]["tradeskill"..i], TOONSTAB[server][player]["tradeskill"..i.."rank"];
		local newskill = SKILL_TYPE[skill] and skill;
		if ( newskill and (newskill~=oldskill or not oldrank or curr>oldrank) ) then
			ToonsTab_Update( "tradeskill"..i, skill );
			ToonsTab_Update( "tradeskill"..i.."rank", curr );
			ToonsTab_Update( "tradeskill"..i.."max", max );
		elseif ( not newskill ) then
			ToonsTab_Update( "tradeskill"..i, nil );
			ToonsTab_Update( "tradeskill"..i.."rank", nil );
			ToonsTab_Update( "tradeskill"..i.."max", nil );
		end
	end
end