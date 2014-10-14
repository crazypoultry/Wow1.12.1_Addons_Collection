--  = \195\164 (z.B. Jger = J\195\164ger)
--  = \195\132 (z.B. rger = \195\132rger)
--  = \195\182 (z.B. schn = sch\195\182n)
--  = \195\150 (z.B. dipus = \195\150dipus)
--  = \195\188 (z.B. Rstung = R\195\188stung)
--  = \195\156 (z.B. bung = \195\156bung)
--  = \195\159 (z.B. Strae = Stra\195\159e)
-------------------------------------------------------------------------------
-- German localization
-------------------------------------------------------------------------------

if (GetLocale() == "deDE") then

	SHIELDSUP_MANASHIELD = "Manaschild";
	SHIELDSUP_FROSTWARD = "Frostzauberschutz";
	SHIELDSUP_FIREWARD = "Feuerzauberschutz";
	SHIELDSUP_ICEBARRIER = "Eisbarriere";
	SHIELDSUP_COLDSNAP = "K\195\164lteeinbruch";
	SHIELDSUP_ICEBLOCK = "Eisblock";

-------------------------------------------------------------------------------
-- French localization
-------------------------------------------------------------------------------

elseif (GetLocale() == "frFR") then


	SHIELDSUP_MANASHIELD = "Bouclier de mana";
	SHIELDSUP_FROSTWARD = "Gardien de givre";
	SHIELDSUP_FIREWARD = "Gardien de feu";
	SHIELDSUP_ICEBARRIER = "Barri\195\168re de glace";
	SHIELDSUP_COLDSNAP = "Morsure de glace";
	SHIELDSUP_ICEBLOCK = "Bloc de glace";

-------------------------------------------------------------------------------
-- Simplified Chinese localization
-------------------------------------------------------------------------------

elseif (GetLocale() == "zhCN") then


	SHIELDSUP_MANASHIELD = "法力护盾";
	SHIELDSUP_FROSTWARD = "防护冰霜结界";
	SHIELDSUP_FIREWARD = "防护火焰结界";
	SHIELDSUP_ICEBARRIER = "寒冰护体";
	SHIELDSUP_COLDSNAP = "急速冷却";
	SHIELDSUP_ICEBLOCK = "寒冰屏障";
	
-------------------------------------------------------------------------------
-- Traditional Chinese localization
-------------------------------------------------------------------------------

elseif (GetLocale() == "zhTW") then


	SHIELDSUP_MANASHIELD = "法力護盾";
	SHIELDSUP_FROSTWARD = "防護冰霜結界";
	SHIELDSUP_FIREWARD = "防護火焰結界";
	SHIELDSUP_ICEBARRIER = "寒冰護體";
	SHIELDSUP_COLDSNAP = "急速冷卻";
	SHIELDSUP_ICEBLOCK = "寒冰屏障";

-------------------------------------------------------------------------------
-- Korea localization
-------------------------------------------------------------------------------

elseif (GetLocale() == "koKR") then

	SHIELDSUP_MANASHIELD = "마나 보호막";
	SHIELDSUP_FROSTWARD = "냉기계 수호";
	SHIELDSUP_FIREWARD = "화염계 수호";
	SHIELDSUP_ICEBARRIER = "얼음 보호막";
	SHIELDSUP_COLDSNAP = "매서운 한파";
	SHIELDSUP_ICEBLOCK = "얼음 방패";

-------------------------------------------------------------------------------
-- English localization (default)
-------------------------------------------------------------------------------

else

	SHIELDSUP_MANASHIELD = "Mana Shield";
	SHIELDSUP_FROSTWARD = "Frost Ward";
	SHIELDSUP_FIREWARD = "Fire Ward";
	SHIELDSUP_ICEBARRIER = "Ice Barrier";
	SHIELDSUP_COLDSNAP = "Cold Snap";
	SHIELDSUP_ICEBLOCK = "Ice Block";

end