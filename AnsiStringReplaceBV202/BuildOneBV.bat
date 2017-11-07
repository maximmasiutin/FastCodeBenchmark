@echo off
echo -------------------------------------------------------------------------------

set FILENAME=AnsiStringReplaceBV_D2005_%1.exe
echo Building %FILENAME% with D2005
call BuildD2005 AnsiStringReplaceBV %2 %3 %4
rename AnsiStringReplaceBV.exe %FILENAME%

set FILENAME=AnsiStringReplaceBV_D2006_%1.exe
echo Building %FILENAME% with D2006
call BuildD2006 AnsiStringReplaceBV %2 %3 %4
rename AnsiStringReplaceBV.exe %FILENAME%

set FILENAME=AnsiStringReplaceBV_D7_%1.exe
echo Building %FILENAME% with D7
call BuildD7 AnsiStringReplaceBV %2 %3 %4
rename AnsiStringReplaceBV.exe %FILENAME%
