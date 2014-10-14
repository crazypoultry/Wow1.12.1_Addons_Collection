@echo off
if exist %windir%\fonts\MSUIgothic.ttf goto install
:else
	echo Unicode Font not found.
	echo please download from http://ayu.commun.jp/wow/chatassist/fonts/
	goto end
:install
	copy %windir%\fonts\MSUIgothic.ttf font01.ttf
	echo Complete!
:end
pause
