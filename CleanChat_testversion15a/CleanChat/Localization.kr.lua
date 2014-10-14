--
-- Korean
--
--
-- Thx to gygabyte
--

function CleanChat_Korean_StripRealm(name)
  -- Player names from other realms on battleground have this format in Europe:
  -- <Playername>-<Realm>, eg. Dadude-Frostmoure
  --
  -- This func should strip the Realm part if variable 'name' contains one, otherwise leave untouched.
  --
  --if string.find(name, "%-") then
  --  _, _, name = string.find(name, "(.-)%-");
  --end
  --return name;
  --
  -- 
  -- I have no clue how cross realm name looks in Korean version,
  -- please fill in the code if possible.
  -- Thank you very much.
  --
  if string.find(name, "%-") then
    _, _, name = string.find(name, "(.-)%-");
  end
  return name;
end

function CleanChat_Korean_EscapeRealm(name)
  -- Variable 'name' is used in a regex, so if it is a cross realm name we need to escape the '-' sign within it.
  -- As it is a special regex instruction, we need to escape otherwise will not work.
  --
  -- This func should escape any characters in the name which are special regex instructions.
  --
  --return string.gsub(name, "%-", "%%%-");
  --
  --
  -- I have no clue how cross realm name looks in Korean version,
  -- please fill in the code if possible.
  -- Thank you very much.
  --
  return string.gsub(name, "%-", "%%%-");
end


if GetLocale() == "koKR" then

  CleanChat_StripRealm = CleanChat_Korean_StripRealm;
  CleanChat_EscapeRealm = CleanChat_Korean_EscapeRealm;

  CLEANCHAT_WHO_RESULTS_PATTERN = "모두 %d+명의 플레이어";

  CLEANCHAT_TRANSLATE_CLASS = {
    ["사냥꾼"] = 1,
    ["흑마법사"] = 2,
    ["사제"] = 3,
    ["성기사"] = 4,
    ["마법사"] = 5,
    ["도적"] = 6,
    ["드루이드"] = 7,
    ["주술사"] = 8,
    ["전사"] = 9
  };

  CLEANCHAT_LOADED = " 불러옴.";
  CLEANCHAT_LOADED_CACHE = CLEANCHAT_VERSION .. " 불러옴 (%d names cached)."

  CLEANCHAT_MYADDONS_DESCRIPTION = "채팅 메시지에서 [파티], [공격대], [길드관리자], [길드]의 접두어를 제거합니다.";
  CLEANCHAT_MYADDONS_RELEASEDATE = "October 13, 2006";

  CLEANCHAT_CHANNELS = {
    {},
    { ["__PREFIX"] = "\. ",
      ["공개"] = "",
      ["거래"] = "" },
    { ["__PREFIX"] = "\. ",
      ["공개"] = "",
      ["거래"] = "",
      ["수비"] = "",
      ["수비"] = "",
      ["파티찾기"] = "",
      ["길드모집"] = "" },
    { ["__PREFIX"] = "\. ",
      ["공개"] = "",
      ["거래"] = "",
      ["수비"] = "",
      ["수비"] = "",
      ["파티찾기"] = "",
      ["길드모집"] = "" },
    { ["__PREFIX"] = "%d\. ",
      ["공개"] = "G",
      ["거래"] = "T",
      ["수비"] = "L",
      ["수비"] = "W",
      ["파티찾기"] = "LFG",
      ["길드모집"] = "GR" },
    { ["__PREFIX"] = "%d\. ",
      ["공개"] = "G",
      ["거래"] = "T",
      ["수비"] = "L",
      ["수비"] = "W",
      ["파티찾기"] = "LFG",
      ["길드모집"] = "GR" } };

  CLEANCHAT_PREFIX_RAID = {
    [false] = CHAT_RAID_GET,
    [true] = "%s:\32" };

  CLEANCHAT_PREFIX_PARTY = {
    [false] = CHAT_PARTY_GET,
    [true] = "%s:\32" };

  CLEANCHAT_PREFIX_OFFICER = {
    [false] = CHAT_OFFICER_GET,
    [true] = "%s:\32" };

  CLEANCHAT_PREFIX_GUILD = {
    [false] = CHAT_GUILD_GET,
    [true] = "%s:\32" };

  CLEANCHAT_PREFIX_RAIDLEADER = {
    [false] = CHAT_RAID_LEADER_GET,
    [true] = "[RL] %s:\32" };

  CLEANCHAT_PREFIX_RAIDWARNING = {
    [false] = CHAT_RAID_WARNING_GET,
    [true] = "[RW] %s:\32" };

  CLEANCHAT_PREFIX_BG = {
    [false] = CHAT_BATTLEGROUND_GET,
    [true]  = "[BG] %s:\32"
  };
  
  CLEANCHAT_PREFIX_BGLEADER = {
    [false] = CHAT_BATTLEGROUND_LEADER_GET,
    [true]  = "[BGL] %s:\32"
  };

  CLEANCHAT_HELP = { HIGHLIGHT_FONT_COLOR_CODE .. "/cleanchat" .. LIGHTYELLOW_FONT_COLOR_CODE .. "- 설정창을 엽니다.",
  HIGHLIGHT_FONT_COLOR_CODE .. "/cleanchat status" .. LIGHTYELLOW_FONT_COLOR_CODE .. "- 현재 설정을 보여줍니다. " };

  CLEANCHAT_STATUSMSG = "상태%d: " .. HIGHLIGHT_FONT_COLOR_CODE .. "%s";

  CLEANCHAT_STATUS1 = {
    [true] = "채팅창 접두어를 보이지 않게합니다.",
    [false] = "채팅창 접두어를 보여줍니다." };

  CLEANCHAT_STATUS2A = {
    [true] = "대화명의 색상을 변경합니다.",
    [false] = "대화명의 색상을 변경하지 않습니다." };
  
  CLEANCHAT_STATUS2B = {
    [true] = { [true] = "직업별 색상을 사용합니다.",
    [false] = "직업별 색상을 사용하지 않습니다." },
    [false] = { [true] = "",
    [false] = "" } };

  CLEANCHAT_STATUS3 = {
    "채널명을 보여줍니다.",
    "공개, 거래 채널명을 보여주지 않습니다.",
    "공개, 거래, 수비, 파티찾기 채널명을 보여주지 않습니다.",
    "모든 채널명을 숨깁니다.",
    "약어 사용: G - 공개, T - 거래, LFG - 파티찾기, GR - 길드모집.",
    "약어를 사용하고 다른 채널명을 숨깁니다." };

  CLEANCHAT_STATUS4 = "%s%s %s%s 색상 설정";
  CLEANCHAT_STATUS5 = { "길드원의", "친구의", "기타", "파티원의", "공격대원의", "직업 정보가 없는 이름의", "자신의" };
  CLEANCHAT_STATUS6 = "만약에 대화명이 위의 기준에 맞지 않는다면 임위적인 색상을 사용합니다."

  -- GUI
  BINDING_NAME_CLEANCHAT_GUI = "설정창 토글";
  CLEANCHAT_CHECKBOX_PREFIX = "[파티], [공격대], [길드], [길드관리자] 채널의 채팅창 접두어를 숨기고\n[공격대장]과 [공격대 경고]를 생략합니다.";
  CLEANCHAT_CHANNELS_LABEL = "채널명:";
  CLEANCHAT_COLORIZE_NICKS = "채팅 메시지에서 대화명의 색상을 변경시킵니다.";
  CLEANCHAT_USE_CLASS_COLORS = "직업별 색상 사용";
  CLEANCHAT_USE_CURSORKEYS = "메시지를 입력하는 동안 커서 키를 활성화합니다 (ALT 키 없이)";
  CLEANCHAT_HIDE_CHATBUTTONS = "채팅 버튼 숨김.";
  CLEANCHAT_COLLECTDATA = "/누구 명령어를 사용하여 데이터 수집";--"Allow addon to use /who command.";
  CLEANCHAT_PERSISTENT = "수집된 자료 저장.";
  CLEANCHAT_SHOWLEVEL = "채팅창에 레벨 표시.";
  CLEANCHAT_MOUSEWHEEL = "마우스 휠을 이용하여 스크롤.";
  CLEANCHAT_POPUP = "Show chat message on screen if it contains your name.";
  CLEANCHAT_IGNORE_EMOTES = "Do not colorize names in emotes."

end