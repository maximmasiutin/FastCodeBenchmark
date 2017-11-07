@echo off
echo -------------------------------------------------------------------------------

set FILENAME=MinIntBenchValid_D2005_%1.exe
echo Building %FILENAME% with D2005
call BuildD2005 MinIntBenchValid %2 %3 %4
rename MinIntBenchValid.exe %FILENAME%

set FILENAME=MinIntBenchValid_D2006_%1.exe
echo Building %FILENAME% with D2006
call BuildD2006 MinIntBenchValid %2 %3 %4
rename MinIntBenchValid.exe %FILENAME%

set FILENAME=MinIntBenchValid_D6_%1.exe
echo Building %FILENAME% with D6
call BuildD6 MinIntBenchValid %2 %3 %4
rename MinIntBenchValid.exe %FILENAME%

set FILENAME=MinIntBenchValid_D7_%1.exe
echo Building %FILENAME% with D7
call BuildD7 MinIntBenchValid %2 %3 %4
rename MinIntBenchValid.exe %FILENAME%
