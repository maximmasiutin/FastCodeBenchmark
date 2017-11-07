@echo off
echo -------------------------------------------------------------------------------

set FILENAME=StrLenBV_D2005_%1.exe
echo Building %FILENAME% with D2005
call BuildD2005 StrLenBV %2 %3 %4
rename StrLenBV.exe %FILENAME%

set FILENAME=StrLenBV_D2006_%1.exe
echo Building %FILENAME% with D2006
call BuildD2006 StrLenBV %2 %3 %4
rename StrLenBV.exe %FILENAME%

set FILENAME=StrLenBV_D6_%1.exe
echo Building %FILENAME% with D6
call BuildD6 StrLenBV %2 %3 %4
rename StrLenBV.exe %FILENAME%

set FILENAME=StrLenBV_D7_%1.exe
echo Building %FILENAME% with D7
call BuildD7 StrLenBV %2 %3 %4
rename StrLenBV.exe %FILENAME%
