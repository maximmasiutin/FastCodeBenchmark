@echo off
echo -------------------------------------------------------------------------------

set FILENAME=Int64MulBV_D2005_%1.exe
echo Building %FILENAME% with D2005
call BuildD2005 Int64MulBV %2 %3 %4
rename Int64MulBV.exe %FILENAME%

set FILENAME=Int64MulBV_D2006_%1.exe
echo Building %FILENAME% with D2006
call BuildD2006 Int64MulBV %2 %3 %4
rename Int64MulBV.exe %FILENAME%

set FILENAME=Int64MulBV_D7_%1.exe
echo Building %FILENAME% with D7
call BuildD7 Int64MulBV %2 %3 %4
rename Int64MulBV.exe %FILENAME%
