@echo off
echo -------------------------------------------------------------------------------

set FILENAME=StrToInt32BV_D7_%1.exe
echo Building %FILENAME% with D7
call BuildD7 StrToInt32BV %2 %3 %4
rename StrToInt32BV.exe %FILENAME%

set FILENAME=StrToInt32BV_D2005_%1.exe
echo Building %FILENAME% with D2005
call BuildD2005 StrToInt32BV %2 %3 %4
rename StrToInt32BV.exe %FILENAME%

set FILENAME=StrToInt32BV_D2006_%1.exe
echo Building %FILENAME% with D2006
call BuildD2006 StrToInt32BV %2 %3 %4
rename StrToInt32BV.exe %FILENAME%