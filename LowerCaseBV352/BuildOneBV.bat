@echo off
echo -------------------------------------------------------------------------------

set FILENAME=LowerCaseBV_D2005_%1.exe
echo Building %FILENAME% with D2005
call BuildD2005 LowerCaseBV %2 %3 %4
rename LowerCaseBV.exe %FILENAME%

set FILENAME=LowerCaseBV_D2006_%1.exe
echo Building %FILENAME% with D2006
call BuildD2006 LowerCaseBV %2 %3 %4
rename LowerCaseBV.exe %FILENAME%

set FILENAME=LowerCaseBV_D6_%1.exe
echo Building %FILENAME% with D6
call BuildD6 LowerCaseBV %2 %3 %4
rename LowerCaseBV.exe %FILENAME%

set FILENAME=LowerCaseBV_D7_%1.exe
echo Building %FILENAME% with D7
call BuildD7 LowerCaseBV %2 %3 %4
rename LowerCaseBV.exe %FILENAME%
