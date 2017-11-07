@echo off
echo -------------------------------------------------------------------------------

set FILENAME=MinInt64BV_D2005_%1.exe
echo Building %FILENAME% with D2005
call BuildD2005 MinInt64BV %2 %3 %4
rename MinInt64BV.exe %FILENAME%

set FILENAME=MinInt64BV_D2006_%1.exe
echo Building %FILENAME% with D2006
call BuildD2006 MinInt64BV %2 %3 %4
rename MinInt64BV.exe %FILENAME%

set FILENAME=MinInt64BV_D6_%1.exe
echo Building %FILENAME% with D6
call BuildD6 MinInt64BV %2 %3 %4
rename MinInt64BV.exe %FILENAME%

set FILENAME=MinInt64BV_D7_%1.exe
echo Building %FILENAME% with D7
call BuildD7 MinInt64BV %2 %3 %4
rename MinInt64BV.exe %FILENAME%
