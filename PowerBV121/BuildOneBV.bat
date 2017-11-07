@echo off
echo -------------------------------------------------------------------------------

set FILENAME=PowerBV_D2005_%1.exe
echo Building %FILENAME% with D2005
call BuildD2005 PowerBV %2 %3 %4
rename PowerBV.exe %FILENAME%

set FILENAME=PowerBV_D2006_%1.exe
echo Building %FILENAME% with D2006
call BuildD2006 PowerBV %2 %3 %4
rename PowerBV.exe %FILENAME%

set FILENAME=PowerBV_D7_%1.exe
echo Building %FILENAME% with D7
call BuildD7 PowerBV %2 %3 %4
rename PowerBV.exe %FILENAME%
