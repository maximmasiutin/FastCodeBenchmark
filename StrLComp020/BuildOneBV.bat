@echo off
echo -------------------------------------------------------------------------------

set FILENAME=StrLCompBV_D2005_%1.exe
echo Building %FILENAME% with D2005
call BuildD2005 StrLCompBV %2 %3 %4
rename StrLCompBV.exe %FILENAME%

set FILENAME=StrLCompBV_D2006_%1.exe
echo Building %FILENAME% with D2006
call BuildD2006 StrLCompBV %2 %3 %4
rename StrLCompBV.exe %FILENAME%

set FILENAME=StrLCompBV_D7_%1.exe
echo Building %FILENAME% with D7
call BuildD7 StrLCompBV %2 %3 %4
rename StrLCompBV.exe %FILENAME%
