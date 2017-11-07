@echo off
echo -------------------------------------------------------------------------------

set FILENAME=CharPosBV_D2005_%1.exe
echo Building %FILENAME% with D2005
call BuildD2005 CharPosBV %2 %3 %4
rename CharPosBV.exe %FILENAME%

set FILENAME=CharPosBV_D2006_%1.exe
echo Building %FILENAME% with D2006
call BuildD2006 CharPosBV %2 %3 %4
rename CharPosBV.exe %FILENAME%

set FILENAME=CharPosBV_D6_%1.exe
echo Building %FILENAME% with D6
call BuildD6 CharPosBV %2 %3 %4
rename CharPosBV.exe %FILENAME%

set FILENAME=CharPosBV_D7_%1.exe
echo Building %FILENAME% with D7
call BuildD7 CharPosBV %2 %3 %4
rename CharPosBV.exe %FILENAME%
