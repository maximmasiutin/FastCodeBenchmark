@echo off
echo -------------------------------------------------------------------------------

set FILENAME=CompareMemBV_D2005_%1.exe
echo Building %FILENAME% with D2005
call BuildD2005 CompareMemBV %2 %3 %4
rename CompareMemBV.exe %FILENAME%

set FILENAME=CompareMemBV_D2006_%1.exe
echo Building %FILENAME% with D2006
call BuildD2006 CompareMemBV %2 %3 %4
rename CompareMemBV.exe %FILENAME%

set FILENAME=CompareMemBV_D6_%1.exe
echo Building %FILENAME% with D6
call BuildD6 CompareMemBV %2 %3 %4
rename CompareMemBV.exe %FILENAME%

set FILENAME=CompareMemBV_D7_%1.exe
echo Building %FILENAME% with D7
call BuildD7 CompareMemBV %2 %3 %4
rename CompareMemBV.exe %FILENAME%
