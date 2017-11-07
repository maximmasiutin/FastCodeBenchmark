@echo off
echo -------------------------------------------------------------------------------

set FILENAME=PosBV_D2005_%1.exe
echo Building %FILENAME% with D2005
call BuildD2005 PosBV %2 %3 %4
rename PosBV.exe %FILENAME%

set FILENAME=PosBV_D2006_%1.exe
echo Building %FILENAME% with D2006
call BuildD2006 PosBV %2 %3 %4
rename PosBV.exe %FILENAME%

set FILENAME=PosBV_D7_%1.exe
echo Building %FILENAME% with D7
call BuildD7 PosBV %2 %3 %4
rename PosBV.exe %FILENAME%
