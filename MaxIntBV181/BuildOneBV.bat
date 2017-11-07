@echo off
echo -------------------------------------------------------------------------------

set FILENAME=MaxIntBenchValid_D2005_%1.exe
echo Building %FILENAME% with D2005
call BuildD2005 MaxIntBenchValid %2 %3 %4
rename MaxIntBenchValid.exe %FILENAME%

set FILENAME=MaxIntBenchValid_D2006_%1.exe
echo Building %FILENAME% with D2006
call BuildD2006 MaxIntBenchValid %2 %3 %4
rename MaxIntBenchValid.exe %FILENAME%

set FILENAME=MaxIntBenchValid_D7_%1.exe
echo Building %FILENAME% with D7
call BuildD7 MaxIntBenchValid %2 %3 %4
rename MaxIntBenchValid.exe %FILENAME%
