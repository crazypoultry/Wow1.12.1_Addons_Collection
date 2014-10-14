--[[
	ImmersionRP Alpha 4 Social tooltip modifier mini-plugin file.
	Purpose: Display Social information in the GameTooltip and serve as an example tooltip plugin.
	Author: Seagale.
	Last update: March 10th, 2007.
]]

local OldProcessPostHook = ImmersionRPTooltipHandler.ProcessPostHook; -- Make sure it's LOCAL!
ImmersionRPTooltipHandler.ProcessPostHook = function (player, token)
												if (ImmersionRPSocialPlayers[player] ~= nil) then
													local status = ImmersionRPSocialPlayers[player]["STATUS"];
													ImmersionRPTooltipHandler.ProcessAddLine(ImmersionRPSocialHandler.SocialStatusText[status], IRP_SOCIAL_STATUSCOLORS[status].r, IRP_SOCIAL_STATUSCOLORS[status].g, IRP_SOCIAL_STATUSCOLORS[status].b);
												end
												OldProcessPostHook(); -- For compatibility with other plugins.
											end;

local OldGetPlayerNameLine = ImmersionRPTooltipHandler.GetPlayerNameLine; -- Make sure it's LOCAL!
ImmersionRPTooltipHandler.GetPlayerNameLine = function (player)
													local nameline = OldGetPlayerNameLine(player); -- For compatibility with other plugins.
													if (nameline == IRP_STRING_UNKNOWNPLAYER_TOOLTIP) then 
														if (ImmersionRPSocialPlayers[player] == nil) then
															return IRP_STRING_UNKNOWNPLAYER_TOOLTIP;
														else
															return ImmersionRPDatabaseHandler.GetPlayerName(player);
														end
													else return nameline; end
												end;

local OldGetPlayerTitleLine = ImmersionRPTooltipHandler.GetPlayerTitleLine; -- Make sure it's LOCAL!
ImmersionRPTooltipHandler.GetPlayerTitleLine = function (player)
													local titleline = OldGetPlayerTitleLine(player); -- For compatibility with other plugins.
													if (titleline == nil) then
														if (ImmersionRPSocialPlayers[player] == nil) then
															return nil;
														else
															return ImmersionRPDatabaseHandler.GetPlayerTitle(player);
														end
													else return titleline; end 
												end;

ImmersionRPTooltipHandler.GetPlayerPvPLine = function (player, token) -- Broke compatibility here, sorry.
													local pvpline = string.gsub(UnitPVPName(token), player, "");
													if (pvpline == nil or pvpline == "") then return nil; end
													if (ImmersionRPSettings["SHOW_RANKS"] == 1) then return pvpline;
													elseif (ImmersionRPSettings["SHOW_RANKS"] == 3) then
														if (ImmersionRPSocialPlayers[player] == nil) then
															return nil;
														else
															return pvpline;
														end
													end
												end;

ImmersionRPTooltipHandler.GetPlayerGuildKnownLine = function (player, token) -- Broke compatibility here, sorry.
														if (ImmersionRPSocialPlayers[player] == nil) then
															return nil;
														else
															return "<" .. (GetGuildInfo(token)) .. ">";
														end
													end;

local OldGetPlayerGuildColor = ImmersionRPTooltipHandler.GetPlayerGuildColor; -- Make sure it's LOCAL!
ImmersionRPTooltipHandler.GetPlayerGuildColor = function (guild)
													if (ImmersionRPSocialGuilds[guild] ~= nil) then
														local status = ImmersionRPSocialGuilds[guild]["STATUS"];
														if (status ~= 1) then
															return IRP_SOCIAL_STATUSCOLORS[status].r, IRP_SOCIAL_STATUSCOLORS[status].g, IRP_SOCIAL_STATUSCOLORS[status].b;
														else
															return OldGetPlayerGuildColor(); -- For compatibility with other plugins.
														end
													else
														return OldGetPlayerGuildColor(); -- For compatibility with other plugins.
													end
												end;
