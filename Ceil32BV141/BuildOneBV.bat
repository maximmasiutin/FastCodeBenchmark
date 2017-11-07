@echo off
echo -------------------------------------------------------------------------------

set FILENAME=Ceil32_D2005_%1.exe
echo Building %FILENAME% with D2005
call BuildD2005 Ceil32 %2 %3 %4
rename Ceil32.exe %FILENAME%

set FILENAME=Ceil32_D2006_%1.exe
echo Building %FILENAME% with D2006
call BuildD2006 Ceil32 %2 %3 %4
rename Ceil32.exe %FILENAME%

set FILENAME=Ceil32_D6_%1.exe
echo Building %FILENAME% with D6
call BuildD6 Ceil32 %2 %3 %4
rename Ceil32.exe %FILENAME%

set FILENAME=Ceil32_D7_%1.exe
echo Building %FILENAME% with D7
call BuildD7 Ceil32 %2 %3 %4
rename Ceil32.exe %FILENAME%
