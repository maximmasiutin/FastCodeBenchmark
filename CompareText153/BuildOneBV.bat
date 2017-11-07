@echo off
echo -------------------------------------------------------------------------------

set FILENAME=CompareTextBV_D2005_%1.exe
echo Building %FILENAME% with D2005
call BuildD2005 CompareTextBV %2 %3 %4
rename CompareTextBV.exe %FILENAME%

set FILENAME=CompareTextBV_D2006_%1.exe
echo Building %FILENAME% with D2006
call BuildD2006 CompareTextBV %2 %3 %4
rename CompareTextBV.exe %FILENAME%

set FILENAME=CompareTextBV_D6_%1.exe
echo Building %FILENAME% with D6
call BuildD6 CompareTextBV %2 %3 %4
rename CompareTextBV.exe %FILENAME%

set FILENAME=CompareTextBV_D7_%1.exe
echo Building %FILENAME% with D7
call BuildD7 CompareTextBV %2 %3 %4
rename CompareTextBV.exe %FILENAME%
