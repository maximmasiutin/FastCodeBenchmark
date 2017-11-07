@echo off
echo -------------------------------------------------------------------------------

set FILENAME=MaxFPBenchValid_D2005_%1.exe
echo Building %FILENAME% with D2005
call BuildD2005 MaxFPBenchValid %2 %3 %4
rename MaxFPBenchValid.exe %FILENAME%

set FILENAME=MaxFPBenchValid_D2006_%1.exe
echo Building %FILENAME% with D2006
call BuildD2006 MaxFPBenchValid %2 %3 %4
rename MaxFPBenchValid.exe %FILENAME%

set FILENAME=MaxFPBenchValid_D7_%1.exe
echo Building %FILENAME% with D7
call BuildD7 MaxFPBenchValid %2 %3 %4
rename MaxFPBenchValid.exe %FILENAME%
