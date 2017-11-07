@echo off
echo -------------------------------------------------------------------------------

set FILENAME=PosEXBV_D2005_%1.exe
echo Building %FILENAME% with D2005
call BuildD2005 PosEXBV %2 %3 %4
rename PosEXBV.exe %FILENAME%

set FILENAME=PosEXBV_D2006_%1.exe
echo Building %FILENAME% with D2006
call BuildD2006 PosEXBV %2 %3 %4
rename PosEXBV.exe %FILENAME%

set FILENAME=PosEXBV_D6_%1.exe
echo Building %FILENAME% with D6
call BuildD6 PosEXBV %2 %3 %4
rename PosEXBV.exe %FILENAME%

set FILENAME=PosEXBV_D7_%1.exe
echo Building %FILENAME% with D7
call BuildD7 PosEXBV %2 %3 %4
rename PosEXBV.exe %FILENAME%
