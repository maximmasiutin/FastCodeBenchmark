@echo off
echo -------------------------------------------------------------------------------

set FILENAME=CharPosRevBV_D7_%1.exe
echo Building %FILENAME% with D7
call BuildD7 CharPosRevBV %2 %3 %4
rename CharPosRevBV.exe %FILENAME%

set FILENAME=CharPosRevBV_D2005_%1.exe
echo Building %FILENAME% with D2005
call BuildD2005 CharPosRevBV %2 %3 %4
rename CharPosRevBV.exe %FILENAME%

set FILENAME=CharPosRevBV_D2006_%1.exe
echo Building %FILENAME% with D2006
call BuildD2006 CharPosRevBV %2 %3 %4
rename CharPosRevBV.exe %FILENAME%

