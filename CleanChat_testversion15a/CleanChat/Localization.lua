CLEANCHAT_NAME = "CleanChat";
CLEANCHAT_VERSION = "testversion15a";
CLEANCHAT_CHATMESSAGE = NORMAL_FONT_COLOR_CODE .. CLEANCHAT_NAME .. ": " .. LIGHTYELLOW_FONT_COLOR_CODE .. "%s";

BINDING_HEADER_CLEANCHAT = CLEANCHAT_NAME;

CLEANCHAT_CHATPATTERN1 = "(.-)%s-: (.- .-) ([^<%-]*) ";


function CleanChat_Europe_StripRealm(name)
  -- Player names from other realms in BG have this format:
  -- <Playername>-<Realm>, eg. Dadude-Frostmoure
  -- This func should strip the Realm part if variable 'name' contains one, otherwise leave untouched.
  if string.find(name, "%-") then
    _, _, name = string.find(name, "(.-)%-");
  end
  return name;
end

function CleanChat_Europe_EscapeRealm(name)
  -- Variable 'name' is used in a regex, so if it is a cross realm name we need to escape the '-' sign within it.
  -- As it is a special regex instruction, we need to escape otherwise will not work.
  -- This func should escape the Realm part in variable 'name' contains one, otherwise leave untouched.
  return string.gsub(name, "%-", "%%%-");
end

CleanChat_StripRealm = CleanChat_Europe_StripRealm;
CleanChat_EscapeRealm = CleanChat_Europe_EscapeRealm;