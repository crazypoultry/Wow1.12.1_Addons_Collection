--[[
	ImmersionRP Alpha 4 tooltip modifier.
	Purpose: Handle destruction and reconstruction of the GameTooltip.
	Author: Seagale.
	Last update: March 10th, 2007.
	
	NOTE: GameTooltip:ClearLines() also clears the health bar, so we have to clear
		  the tooltip manually.
]]

ImmersionRPTooltipHandler = {
	TooltipLines = {},
	
	NewTable = function (tbl) 
					local key;
					for key in ipairs(tbl) do
						tbl[key] = nil;
					end
					return tbl;
			   end,
			   
	ProcessSetLine = function (position, textleft, r, g, b, textright)
						local positionline = ImmersionRPTooltipHandler.TooltipLines[position];
						positionline.lefttext, positionline.righttext = textleft, textright;
						if (r ~= nil) then
							positionline.r, positionline.g, positionline.b = r, g, b;
						end
					 end,
	
	ProcessAddLine = function (textleft, r, g, b, textright)
						if (textleft == "") then return; end
						table.insert(ImmersionRPTooltipHandler.TooltipLines, {});
						local lastline = ImmersionRPTooltipHandler.TooltipLines[table.getn(ImmersionRPTooltipHandler.TooltipLines)];
						lastline.lefttext, lastline.righttext, lastline.r, lastline.g, lastline.b = textleft, textright, r, g, b;
					 end,
					 
	ProcessInsertLine = function (position, textleft, r, g, b, textright)
							if (textleft == "") then return; end
							table.insert(ImmersionRPTooltipHandler.TooltipLines, position ,{});
							local positionline = ImmersionRPTooltipHandler.TooltipLines[position];
							positionline.lefttext, positionline.righttext, positionline.r, positionline.g, positionline.b = textleft, textright, r, g, b;
						end,
						
	ProcessPreHook = function (player, token) end,
	ProcessPostHook = function (player, token) end,
			   
	GetPlayerNameLine = function (player)
							if (ImmersionRPSettings["HIDE_UNKNOWN_PLAYERS"] == 1) then return IRP_STRING_UNKNOWNPLAYER_TOOLTIP; end
							return ImmersionRPDatabaseHandler.GetPlayerName(player);
						end,
	
	GetPlayerNameColor = function (token)
							if (not UnitIsPVP(token)) then
								return IRP_TOOLTIP_NOPVPNAME_COLORR, IRP_TOOLTIP_NOPVPNAME_COLORG, IRP_TOOLTIP_NOPVPNAME_COLORB;
							end
						end,
						
	GetPlayerTitleLine = function (player)
							if (ImmersionRPSettings["HIDE_UNKNOWN_PLAYERS"] == 1) then return nil; end
							return ImmersionRPDatabaseHandler.GetPlayerTitle(player);
						end,
	
	GetPlayerTitleColor = function ()
							return IRP_TOOLTIP_TITLE_COLORR, IRP_TOOLTIP_TITLE_COLORG, IRP_TOOLTIP_TITLE_COLORB;
						end,
						
	GetPlayerPvPLine = function (player, token)
							if (ImmersionRPSettings["SHOW_RANKS"] ~= 1 or string.gsub(UnitPVPName(token), player, "") == "") then return nil; end
							return string.gsub(UnitPVPName(token), player, "");
						end,
	
	GetPlayerPvPColor = function (token)
							return IRP_TOOLTIP_RANK_COLORR, IRP_TOOLTIP_RANK_COLORG, IRP_TOOLTIP_RANK_COLORB;
						end,
						
	GetPlayerGuildLine = function (player, token)
								local guildline = ImmersionRPTooltipHandler.GetPlayerGuildRawLine(player, token);
								if (guildline == nil) then return nil; end
								if (ImmersionRPSettings["SHOW_GUILDS"] == 1) then return "<" .. guildline .. ">";
								elseif (ImmersionRPSettings["SHOW_GUILDS"] == 3) then return ImmersionRPTooltipHandler.GetPlayerGuildKnownLine(player, token); end
						end,
						
	GetPlayerGuildRawLine = function (player, token)
								return (GetGuildInfo(token));
							end,
	
	GetPlayerGuildKnownLine = function (player, token)
								return nil;
							  end,
	
	GetPlayerGuildColor = function (guild)
							return IRP_TOOLTIP_GUILD_COLORR, IRP_TOOLTIP_GUILD_COLORG, IRP_TOOLTIP_GUILD_COLORB;
						end,
						
	GetPlayerLevelLine = function (token)
							if (ImmersionRPSettings["SHOW_RELATIVE_LEVELS"] == 1) then
								if (UnitLevel(token) == -1) then
									return string.format(IRP_STRING_ALTLEVEL_TOOLTIP, UnitRace(token), UnitClass(token), IRP_STRING_DELTA10_TOOLTIP);
								else
									local leveldelta = UnitLevel(token) -  UnitLevel("player");
									return string.format(IRP_STRING_ALTLEVEL_TOOLTIP, UnitRace(token), UnitClass(token), ImmersionRPTooltipHandler.GetLevelDeltaString(leveldelta));
								end
							else
								return string.gsub(string.format(PLAYER_LEVEL, UnitLevel(token), UnitRace(token), UnitClass(token)), "-1", "??");
							end
						end,
	
	GetPlayerLevelColor = function ()
							return IRP_TOOLTIP_LEVEL_COLORR, IRP_TOOLTIP_LEVEL_COLORG, IRP_TOOLTIP_LEVEL_COLORB;
						end,
			   
	DestroyTooltip = function ()
						-- This will empty and hide all visible fontstrings, leaving the tooltip completely blank.
						-- As of 2.0 the tooltip lines are created only when they are needed.
						for linecounter = 1, GameTooltip:NumLines() do
							getglobal("GameTooltipTextLeft" .. linecounter):SetText(nil);
							getglobal("GameTooltipTextLeft" .. linecounter):Hide();
							
							getglobal("GameTooltipTextRight" .. linecounter):SetText(nil);
							getglobal("GameTooltipTextRight" .. linecounter):Hide();
						end
					 end,


	ConstructTooltip = function ()
						local linecounter = 1;
						while ImmersionRPTooltipHandler.TooltipLines[linecounter] ~= nil do
							if (ImmersionRPTooltipHandler.TooltipLines[linecounter].lefttext ~= "") then
								if (linecounter <= GameTooltip:NumLines()) then
									local tooltiplabel = getglobal("GameTooltipTextLeft" .. linecounter);
									tooltiplabel:SetText(ImmersionRPTooltipHandler.TooltipLines[linecounter].lefttext);
									tooltiplabel:Show();
									tooltiplabel:SetTextColor(ImmersionRPTooltipHandler.TooltipLines[linecounter].r,ImmersionRPTooltipHandler.TooltipLines[linecounter].g,ImmersionRPTooltipHandler.TooltipLines[linecounter].b);
								else
									GameTooltip:AddLine(ImmersionRPTooltipHandler.TooltipLines[linecounter].lefttext,ImmersionRPTooltipHandler.TooltipLines[linecounter].r,ImmersionRPTooltipHandler.TooltipLines[linecounter].g,ImmersionRPTooltipHandler.TooltipLines[linecounter].b);	
								end
							end
							linecounter = linecounter + 1;
						end
						GameTooltip:SetHeight(0);
						GameTooltip:Show();
					end,

	ProcessTooltip = function (token)

						if (token == nil or token == "") then token = "mouseover"; end
						local unitname = UnitName(token);
						if (unitname == nil or unitname == "") then return; end
						
						ImmersionRPTooltipHandler.TooltipLines = ImmersionRPTooltipHandler.NewTable(ImmersionRPTooltipHandler.TooltipLines);
						
						local linecounter;
						local addedline = 0;
						
						for linecounter = 1, GameTooltip:NumLines() do
							local leftlabel = getglobal("GameTooltipTextLeft" .. linecounter);
							local rightlabel = getglobal("GameTooltipTextRight" .. linecounter);
							if (leftlabel:GetText() ~= nil and leftlabel:GetText() ~= "") then
								local r, g, b = leftlabel:GetTextColor();
								ImmersionRPTooltipHandler.ProcessAddLine(leftlabel:GetText(), r, g, b, leftlabel:GetText());
							end
						end
						
						ImmersionRPTooltipHandler.ProcessPreHook(unitname, token);
						
						linecounter = 1;
						
						while ImmersionRPTooltipHandler.TooltipLines[linecounter] ~= nil do 
							if (linecounter == 1) then
								ImmersionRPTooltipHandler.ProcessSetLine(1, ImmersionRPTooltipHandler.GetPlayerNameLine(unitname), ImmersionRPTooltipHandler.GetPlayerNameColor(token));
								if (ImmersionRPTooltipHandler.GetPlayerTitleLine(unitname) ~= nil) then
									ImmersionRPTooltipHandler.ProcessInsertLine(2, ImmersionRPTooltipHandler.GetPlayerTitleLine(unitname), ImmersionRPTooltipHandler.GetPlayerTitleColor());
									addedline = 1;
								end
								
								if (ImmersionRPTooltipHandler.GetPlayerPvPLine(unitname, token) ~= nil) then
									ImmersionRPTooltipHandler.ProcessInsertLine(linecounter + addedline + 1, ImmersionRPTooltipHandler.GetPlayerPvPLine(unitname, token), ImmersionRPTooltipHandler.GetPlayerPvPColor());
									addedline = addedline + 1;
								end
								
								if (ImmersionRPTooltipHandler.GetPlayerGuildLine(unitname, token) ~= nil) then
									ImmersionRPTooltipHandler.ProcessInsertLine(linecounter + addedline + 1, ImmersionRPTooltipHandler.GetPlayerGuildLine(unitname, token), ImmersionRPTooltipHandler.GetPlayerGuildColor(ImmersionRPTooltipHandler.GetPlayerGuildRawLine(unitname, token)));
									addedline = addedline + 1;
								end
							elseif (string.find(string.lower(ImmersionRPTooltipHandler.TooltipLines[linecounter].lefttext), string.lower(LEVEL)) and string.find(string.lower(ImmersionRPTooltipHandler.TooltipLines[linecounter].lefttext), string.lower(PLAYER))) then
								if (ImmersionRPTooltipHandler.GetPlayerLevelLine(token) ~= nil) then
									ImmersionRPTooltipHandler.ProcessSetLine(linecounter, ImmersionRPTooltipHandler.GetPlayerLevelLine(token), ImmersionRPTooltipHandler.GetPlayerLevelColor());
								end
								
								ImmersionRPTooltipHandler.ProcessInsertLine(linecounter + 1, ImmersionRPDatabaseHandler.GetRPStyleString(unitname), IRP_TOOLTIP_RPSTYLE_COLORR, IRP_TOOLTIP_RPSTYLE_COLORG, IRP_TOOLTIP_RPSTYLE_COLORB);
								
								ImmersionRPTooltipHandler.ProcessInsertLine(linecounter + 2, ImmersionRPDatabaseHandler.GetRPStatusString(unitname), IRP_TOOLTIP_RPSTATUS_COLORR, IRP_TOOLTIP_RPSTATUS_COLORG, IRP_TOOLTIP_RPSTATUS_COLORB);
							end
							
							linecounter = linecounter + 1;
						end
						
						ImmersionRPTooltipHandler.ProcessPostHook(unitname, token);
					end,

	GetLevelDeltaString = function (numdelta)
								if (numdelta > 7) then
									return IRP_STRING_DELTA10_TOOLTIP;
								elseif (numdelta > 5 and numdelta <= 7) then
									return IRP_STRING_DELTA7_TOOLTIP;
								elseif (numdelta > 2 and numdelta <= 5) then
									return IRP_STRING_DELTA5_TOOLTIP;
								elseif (numdelta <= 2 and numdelta > -2) then
									return IRP_STRING_DELTA2_TOOLTIP;
								elseif (numdelta <= -2 and numdelta >= -5) then
									return IRP_STRING_DELTAMINUS5_TOOLTIP;
								elseif (numdelta < -5 and numdelta >= -7) then
									return IRP_STRING_DELTAMINUS7_TOOLTIP;
								elseif (numdelta < -7) then
									return IRP_STRING_DELTAMINUS10_TOOLTIP;
								end
							end,

	ShowOwnTooltip = function ()
							GameTooltip_SetDefaultAnchor(GameTooltip,UIParent);
							GameTooltip:SetUnit("player");
							ImmersionRPTooltipHandler.ProcessTooltip("player");
							ImmersionRPTooltipHandler.DestroyTooltip();
							ImmersionRPTooltipHandler.ConstructTooltip();
							GameTooltip:Show();
					end
};