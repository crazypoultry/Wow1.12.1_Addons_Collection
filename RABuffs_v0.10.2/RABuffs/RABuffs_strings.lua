-- RABuffs_strings.lua
--  Non-code storage for various code/title strings. Do not localize this file.
-- Version 0.10.2

sRAB_DownloadURL = "http://www.curse-gaming.com/";

sRAB_Settings_UIHeader = "RABuffs";
sRAB_Settings_ReleaseNotes = "<h2 align=\"left\">Release notes</h2><p>- Issue: GoTW is mis-identified as MoTW on non-enUS clients.</p><p>- Issue: Failed casting of resurrection spells bans the target from further attempts for 70 seconds.</p><br/><br/>";

sRAB_LOCALIZATION, sRAB_Localization_UI, sRAB_Localization_Output, sRAB_Localization_SpellLayer = {}, "", "", "|c00ff9922Automatic spellbook|r";

sRAB_ChangeLog2 =     [[<html><body>
			<h1 align="center">RABuffs Version 0.10.2</h1>
			<h2>General</h2>
			<p> - Flagged as 1.12 compatible.</p>
			<p> - Experimental Battleground support.</p>
			<h2>Fixed Issues</h2>
			<p> - [1.12] RAB_Versions table initialized after savedvariables load (SVs are now explicitly declared nil if nil at exit).</p>
			<br/><br/></body></html>]];

sRAB_SpellNames = {};
sRAB_SpellIDs = {};

function sRAB_Localize(strings, spells)
 if (strings) then
  sRAB_LOCALIZATION_vui = "enUS";
  sRAB_LOCALIZATION_out = "enUS";
  sRAB_LOCALIZATION["enUS"](true,true,(GetLocale() == "enUS"));
  if (RABui_Settings.uilocale ~= "enUS" and sRAB_LOCALIZATION[RABui_Settings.uilocale] ~= nil) then
   sRAB_LOCALIZATION[RABui_Settings.uilocale](true, false);
   sRAB_LOCALIZATION_vui = RABui_Settings.uilocale;
  end
  if (RABui_Settings.outlocale ~= "enUS" and sRAB_LOCALIZATION[RABui_Settings.outlocale] ~= nil) then
   sRAB_LOCALIZATION[RABui_Settings.outlocale](false, true);
   sRAB_LOCALIZATION_out = RABui_Settings.outlocale;
  end
  if (RABui_Localize ~= nil) then
   RABui_Localize();
  end
 end
 if (spells) then
  sRAB_PseudoLocalize(true);
  if (sRAB_LOCALIZATION[GetLocale()] ~= nil) then
   sRAB_LOCALIZATION[GetLocale()](false, false, true);
  end
 end
end

function sRAB_PseudoLocalize(forceful)
 if (forceful) then 
  sRAB_SpellLayerLocale = "auto";
 end
 local _, _, i = GetSpellTabInfo(2);
 if (i == 0 or i == nil) then
  return; -- There is only one tab, "General", so no spells for us.
 end
 local sName, sTex, sArr, sManaCost = "", "", {}, {};
 local mana = 0;
 while true do
  i = i + 1;
  sName, sRank = GetSpellName(i,BOOKTYPE_SPELL)
  if (sName == nil) then break; end
  sTex = GetSpellTexture(i,BOOKTYPE_SPELL);
  sTex = strsub(sTex,1+strlen("Interface/Icons/"));
  mana = RAB_SpellManaCost(i);
  if ((sArr[sTex] == nil) or (mana > sManaCost[sTex])) then
   sArr[sTex] = i;
   sManaCost[sTex] = mana;
  end
 end
 local key, val, mc, key2, val2;
 mc = RAB_UnitClass("player");
 for key, val in RAB_Buffs do
  if (val.castClass == mc and val.textures ~= nil) then
    sName = GetSpellName(i, BOOKTYPE_SPELL);
    if (sArr[val.textures[1]] ~= nil) then 
     if (forceful or sRAB_SpellNames[key] == nil) then sRAB_SpellNames[key] = GetSpellName(sArr[val.textures[1]],BOOKTYPE_SPELL);  end
     sRAB_SpellIDs[key] = sArr[val.textures[1]], sManaCost[val.textures[1]];
    end
    if (sArr[val.textures[2]] ~= nil and val.bigcast ~= nil) then 
     if (forceful or sRAB_SpellNames[val.bigcast] == nil) then sRAB_SpellNames[val.bigcast] = GetSpellName(sArr[val.textures[2]], BOOKTYPE_SPELL); end
     sRAB_SpellIDs[val.bigcast] = sArr[val.textures[2]], sManaCost[val.textures[2]];
    end
  end
 end
end
function sRAB_FindSpellId(SpellName)
 local _, _, i = GetSpellTabInfo(2);
 if (i == 0 or i == nil) then
  return 0; -- There is only one tab, "General", so no spells for us.
 end
 local sName, iManaCost, sId = "", 0, 0;
 while true do
  i = i + 1;
  sName = GetSpellName(i, BOOKTYPE_SPELL);
  if (sName == nil) then
   break;
  elseif (sName == SpellName) then
   sId = i;
  elseif (sId ~= 0) then
   return sId;
  end
 end
 return sId;
end
function RAB_SpellManaCost(spell,book)
 RAB_Spelltip:SetOwner(RABFrame, "ANCHOR_LEFT");
 RAB_Spelltip:ClearLines();
 RAB_Spelltip:SetSpell(spell,book ~= nil and book or BOOKTYPE_SPELL);
 local t = RAB_SpelltipTextLeft2:GetText();
 local _,_, mana = string.find(t ~= nil and t or "","(%d+) ");
 RAB_Spelltip:Hide();
 return (mana ~= nil and tonumber(mana) or 0);
end