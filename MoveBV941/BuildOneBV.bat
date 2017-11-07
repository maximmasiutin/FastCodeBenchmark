@echo off
echo -------------------------------------------------------------------------------

set FILENAME=MoveValidateBenchmark_D2005_%1.exe
echo Building %FILENAME% with D2005
call BuildD2005 MoveValidateBenchmark %2 %3 %4
rename MoveValidateBenchmark.exe %FILENAME%

set FILENAME=MoveValidateBenchmark_D2006_%1.exe
echo Building %FILENAME% with D2006
call BuildD2006 MoveValidateBenchmark %2 %3 %4
rename MoveValidateBenchmark.exe %FILENAME%

set FILENAME=MoveValidateBenchmark_D6_%1.exe
echo Building %FILENAME% with D6
call BuildD6 MoveValidateBenchmark %2 %3 %4
rename MoveValidateBenchmark.exe %FILENAME%

set FILENAME=MoveValidateBenchmark_D7_%1.exe
echo Building %FILENAME% with D7
call BuildD7 MoveValidateBenchmark %2 %3 %4
rename MoveValidateBenchmark.exe %FILENAME%
