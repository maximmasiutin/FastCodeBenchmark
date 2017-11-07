@echo off
echo -------------------------------------------------------------------------------

set FILENAME=StrCompBV_D2005_%1.exe
echo Building %FILENAME% with D2005
call BuildD2005 StrCompBV %2 %3 %4
rename StrCompBV.exe %FILENAME%

set FILENAME=StrCompBV_D2006_%1.exe
echo Building %FILENAME% with D2006
call BuildD2006 StrCompBV %2 %3 %4
rename StrCompBV.exe %FILENAME%

set FILENAME=StrCompBV_D6_%1.exe
echo Building %FILENAME% with D6
call BuildD6 StrCompBV %2 %3 %4
rename StrCompBV.exe %FILENAME%

set FILENAME=StrCompBV_D7_%1.exe
echo Building %FILENAME% with D7
call BuildD7 StrCompBV %2 %3 %4
rename StrCompBV.exe %FILENAME%
