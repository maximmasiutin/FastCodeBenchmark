@echo off
echo -------------------------------------------------------------------------------

set FILENAME=PosIExBV_D2005_%1.exe
echo Building %FILENAME% with D2005
call BuildD2005 PosIExBV %2 %3 %4
rename PosIExBV.exe %FILENAME%

set FILENAME=PosIExBV_D2006_%1.exe
echo Building %FILENAME% with D2006
call BuildD2006 PosIExBV %2 %3 %4
rename PosIExBV.exe %FILENAME%

set FILENAME=PosIExBV_D6_%1.exe
echo Building %FILENAME% with D6
call BuildD6 PosIExBV %2 %3 %4
rename PosIExBV.exe %FILENAME%

set FILENAME=PosIExBV_D7_%1.exe
echo Building %FILENAME% with D7
call BuildD7 PosIExBV %2 %3 %4
rename PosIExBV.exe %FILENAME%
