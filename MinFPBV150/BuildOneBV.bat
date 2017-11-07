@echo off
echo -------------------------------------------------------------------------------

set FILENAME=MinFPBenchValid_D2005_%1.exe
echo Building %FILENAME% with D2005
call BuildD2005 MinFPBenchValid %2 %3 %4
rename MinFPBenchValid.exe %FILENAME%

set FILENAME=MinFPBenchValid_D2006_%1.exe
echo Building %FILENAME% with D2006
call BuildD2006 MinFPBenchValid %2 %3 %4
rename MinFPBenchValid.exe %FILENAME%

set FILENAME=MinFPBenchValid_D7_%1.exe
echo Building %FILENAME% with D7
call BuildD7 MinFPBenchValid %2 %3 %4
rename MinFPBenchValid.exe %FILENAME%
