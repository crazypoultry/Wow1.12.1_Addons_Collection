--[[
  Guild Event Manager by Kiki of European Cho'gall (Alliance)
  Default values initialized by Guild Leaders

]]


-- Default channel to join
GEM_DEFAULT_CHANNEL = "GEMChannelDefault";
-- Password string for default channel (nil if none)
GEM_DEFAULT_PASSWORD = nil;
-- Alias string for default channel (nil if none)
GEM_DEFAULT_ALIAS = nil;
-- slash command string for default channel (nil if none) without the leading '/'
GEM_DEFAULT_SLASH = nil;


-- Auto banned people
GEM_Defaults_Banned = {
  --[[
  ["Your Realm Name"] = {
    ["dummy_player"] = true,
    ["dummy_player_2"] = true,
  },
  ["Your other Realm Name"] = {
    ["dummy_player"] = true,
  },
  ]]
};
