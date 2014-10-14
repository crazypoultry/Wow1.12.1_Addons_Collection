--
-- Configuration file to highlight custom text in chat messages.
--
-- To be successful:
-- * You need a understanding of RGB color system.
-- * You need a understanding of hex numbers.
-- * You have patience.
-- * You have minimal knowledge of regular expressions (to escape the special characters).
-- * Optional you have minimal LUA knowledge to better understand syntax errors [just in case].
-- * Optional you have good knowledge of regular expressions.
--
-- I am sorry, but I can not explain all that in an easy and short way.
--
-- Warning: You can mess up your chat if you do something wrong.
--          Take your time and don't rush through it.
--          If you don't have time right now, close this file.
--
--
--
-- Lets look at a few examples:
--
-- I want that my Guild name is blue in chat messages:
-- ["Aces of the Pacific from Dynamix"] = "|cff0000ff",
--
-- You can force a color on a name, if he writes message that color is applied.
-- If someone else writes his name it is also colorized:
-- ["MyFriendsName"] = "|cff0000ff";
--
-- You can colorize channel names, I want that '1. General' appears in yellow:
-- ["%[1. General%]"] = "|cffffff00",
-- or if you have channel name set to not show:
-- ["%[1.%]"] = "|cffffff00",
-- You have to write % before [ and ], because the string is actually a regex.
-- (if you don't know regex just accept it)

-- Hint: Color format is "|cff<red in hex><green in hex><blue in hex>";
--       It is the Blizzard standard way to colorize parts of a message.

-- Here are few common colors to use:
-- White: "|cffffffff"
-- Red: "|cffff0000"
-- Brigher Red: "|cffff5050";
-- Blue: "|cff0000ff"
-- Brighter Blue: "|cff5050ff"
-- Green: "|cffff0000"
-- Yellow: "|cffffff00"
-- Black: "|cff000000"
-- Gray: "|cffA0A0A0"

-- Please terminate every line with a comma, otherwise you get a syntax error message.

CleanChat_HighlightText = {
  --["test"] = "|cffffff00",  --test entry
  -- Enter here your own custom highlight rules:


};