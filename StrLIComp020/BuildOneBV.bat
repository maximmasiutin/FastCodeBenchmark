@echo off
echo -------------------------------------------------------------------------------

set FILENAME=StrLICompBV_D2005_%1.exe
echo Building %FILENAME% with D2005
call BuildD2005 StrLICompBV %2 %3 %4
rename StrLICompBV.exe %FILENAME%

set FILENAME=StrLICompBV_D2006_%1.exe
echo Building %FILENAME% with D2006
call BuildD2006 StrLICompBV %2 %3 %4
rename StrLICompBV.exe %FILENAME%

set FILENAME=StrLICompBV_D7_%1.exe
echo Building %FILENAME% with D7
call BuildD7 StrLICompBV %2 %3 %4
rename StrLICompBV.exe %FILENAME%
