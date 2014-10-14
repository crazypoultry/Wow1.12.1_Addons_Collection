@ECHO OFF
@echo.
@echo flagRSP uninstaller
@echo -----------------------------
@ECHO This file uninstalls flagRSP.
@ECHO.
@ECHO To cancel uninstallation of flagRSP close this window without 
@ECHO pressing a button. To continue press any key.
pause
@ECHO.
@ECHO Uninstalling flagRSP...
del /q /s "Interface\AddOns\flagRSP\*"
rmdir "Interface\AddOns\flagRSP\artwork"
rmdir "Interface\AddOns\flagRSP\Art"
rmdir "Interface\AddOns\flagRSP\documentation"
rmdir "Interface\AddOns\flagRSP"
@ECHO.
@ECHO Uninstalling Friendlist...
del /q /s "Interface\AddOns\FriendList\*"
rmdir "Interface\AddOns\FriendList\Art"
rmdir "Interface\AddOns\FriendList"
@ECHO.
@ECHO Uninstalling flagRSPLoader...
del /q /s "Interface\AddOns\flagRSPLoader\*"
rmdir "Interface\AddOns\flagRSPLoader"
@ECHO.
@ECHO Uninstalling info files...
del "Interface\AddOns\FriendList.nopatch"
del "Interface\AddOns\flagRSP.nopatch"
del "Interface\AddOns\flagRSPLoader.nopatch"
del "flagRSP_changelog.txt"
del "Friendlist_changelog.txt"
del "flagRSP&Friendlist_readme_DE.txt"
del "flagRSP&Friendlist_readme_EN.txt"
del "flagRSP_readme_DE.txt"
del "flagRSP_readme_EN.txt"
del "flagRSP&Friendlist_readme.txt"
del "flagRSP_FAQ_DE.txt"
del "flagRSP_FAQ_EN.txt"
del "flagRSP_contributors.txt"
del "flagRSP homepage.url"
del "flagRSP&Friendlist_knownIssues.txt"
del "flagRSP readme has been moved.txt"
del "NOTE ABOUT PREVIEW RELEASES.txt"
del "flagRSP&Friendlist_uninstall.bat"
del "flagRSP&Friendlist_uninstall.bat"
@ECHO.
@ECHO If you have not experienced any error messages until here flagRSP
@ECHO has been successfully uninstalled.
@echo.
pause
del "flagRSP_uninstall.bat"