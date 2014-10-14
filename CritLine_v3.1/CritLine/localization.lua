-------------------------------------------------------------------------------
--                               CritLine                               --
-------------------------------------------------------------------------------

if ( GetLocale() == "deDE" ) then
	CritLine_LocalizeDE();
elseif ( GetLocale() == "frFR" ) then
	CritLine_LocalizeFR();
elseif ( GetLocale() == "zhCN" ) then
	CritLine_LocalizeCN();
else		
	CritLine_LocalizeEN();	
end