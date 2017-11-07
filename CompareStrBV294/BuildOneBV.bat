@echo off
echo -------------------------------------------------------------------------------

set FILENAME=CompareStrBV_D2005_%1.exe
echo Building %FILENAME% with D2005
call BuildD2005 CompareStrBV %2 %3 %4
rename CompareStrBV.exe %FILENAME%

set FILENAME=CompareStrBV_D2006_%1.exe
echo Building %FILENAME% with D2006
call BuildD2006 CompareStrBV %2 %3 %4
rename CompareStrBV.exe %FILENAME%

set FILENAME=CompareStrBV_D6_%1.exe
echo Building %FILENAME% with D6
call BuildD6 CompareStrBV %2 %3 %4
rename CompareStrBV.exe %FILENAME%

set FILENAME=CompareStrBV_D7_%1.exe
echo Building %FILENAME% with D7
call BuildD7 CompareStrBV %2 %3 %4
rename CompareStrBV.exe %FILENAME%
