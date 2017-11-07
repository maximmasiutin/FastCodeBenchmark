@echo off
echo -------------------------------------------------------------------------------

set FILENAME=UpperCaseBV_D2005_%1.exe
echo Building %FILENAME% with D2005
call BuildD2005 UpperCaseBV %2 %3 %4
rename UpperCaseBV.exe %FILENAME%

set FILENAME=UpperCaseBV_D2006_%1.exe
echo Building %FILENAME% with D2006
call BuildD2006 UpperCaseBV %2 %3 %4
rename UpperCaseBV.exe %FILENAME%

set FILENAME=UpperCaseBV_D6_%1.exe
echo Building %FILENAME% with D6
call BuildD6 UpperCaseBV %2 %3 %4
rename UpperCaseBV.exe %FILENAME%

set FILENAME=UpperCaseBV_D7_%1.exe
echo Building %FILENAME% with D7
call BuildD7 UpperCaseBV %2 %3 %4
rename UpperCaseBV.exe %FILENAME%
