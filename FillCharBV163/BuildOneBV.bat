@echo off
echo -------------------------------------------------------------------------------

set FILENAME=FillCharBV_D2005_%1.exe
echo Building %FILENAME% with D2005
call BuildD2005 FillCharBV %2 %3 %4
rename FillCharBV.exe %FILENAME%

set FILENAME=FillCharBV_D2006_%1.exe
echo Building %FILENAME% with D2006
call BuildD2006 FillCharBV %2 %3 %4
rename FillCharBV.exe %FILENAME%

set FILENAME=FillCharBV_D6_%1.exe
echo Building %FILENAME% with D6
call BuildD6 FillCharBV %2 %3 %4
rename FillCharBV.exe %FILENAME%

set FILENAME=FillCharBV_D7_%1.exe
echo Building %FILENAME% with D7
call BuildD7 FillCharBV %2 %3 %4
rename FillCharBV.exe %FILENAME%
