@echo off
echo -------------------------------------------------------------------------------

set FILENAME=CharPosIExBV_D7_%1.exe
echo Building %FILENAME% with D7
call BuildD7 CharPosIExBV %2 %3 %4
rename CharPosIExBV.exe %FILENAME%

set FILENAME=CharPosIExBV_D2005_%1.exe
echo Building %FILENAME% with D2005
call BuildD2005 CharPosIExBV %2 %3 %4
rename CharPosIExBV.exe %FILENAME%

set FILENAME=CharPosIExBV_D2006_%1.exe
echo Building %FILENAME% with D2006
call BuildD2006 CharPosIExBV %2 %3 %4
rename CharPosIExBV.exe %FILENAME%

