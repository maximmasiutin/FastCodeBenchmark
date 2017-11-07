@echo off
echo -------------------------------------------------------------------------------

set FILENAME=TrimBV_D7_%1.exe
echo Building %FILENAME% with D7
call BuildD7 TrimBV %2 %3 %4
rename TrimBV.exe %FILENAME%

set FILENAME=TrimBV_D2005_%1.exe
echo Building %FILENAME% with D2005
call BuildD2005 TrimBV %2 %3 %4
rename TrimBV.exe %FILENAME%

set FILENAME=TrimBV_D2006_%1.exe
echo Building %FILENAME% with D2006
call BuildD2006 TrimBV %2 %3 %4
rename TrimBV.exe %FILENAME%

set FILENAME=TrimBV_D2007_%1.exe
echo Building %FILENAME% with D2007
call BuildD2007 TrimBV %2 %3 %4
rename TrimBV.exe %FILENAME%