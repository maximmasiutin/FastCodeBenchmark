@echo off
echo -------------------------------------------------------------------------------

set FILENAME=MaxInt64BV_D2005_%1.exe
echo Building %FILENAME% with D2005
call BuildD2005 MaxInt64BV %2 %3 %4
rename MaxInt64BV.exe %FILENAME%

set FILENAME=MaxInt64BV_D2006_%1.exe
echo Building %FILENAME% with D2006
call BuildD2006 MaxInt64BV %2 %3 %4
rename MaxInt64BV.exe %FILENAME%

set FILENAME=MaxInt64BV_D6_%1.exe
echo Building %FILENAME% with D6
call BuildD6 MaxInt64BV %2 %3 %4
rename MaxInt64BV.exe %FILENAME%

set FILENAME=MaxInt64BV_D7_%1.exe
echo Building %FILENAME% with D7
call BuildD7 MaxInt64BV %2 %3 %4
rename MaxInt64BV.exe %FILENAME%
