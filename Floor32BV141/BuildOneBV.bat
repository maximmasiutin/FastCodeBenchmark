@echo off
echo -------------------------------------------------------------------------------

set FILENAME=Floor32_D2005_%1.exe
echo Building %FILENAME% with D2005
call BuildD2005 Floor32 %2 %3 %4
rename Floor32.exe %FILENAME%

set FILENAME=Floor32_D2006_%1.exe
echo Building %FILENAME% with D2006
call BuildD2006 Floor32 %2 %3 %4
rename Floor32.exe %FILENAME%

set FILENAME=Floor32_D6_%1.exe
echo Building %FILENAME% with D6
call BuildD6 Floor32 %2 %3 %4
rename Floor32.exe %FILENAME%

set FILENAME=Floor32_D7_%1.exe
echo Building %FILENAME% with D7
call BuildD7 Floor32 %2 %3 %4
rename Floor32.exe %FILENAME%
