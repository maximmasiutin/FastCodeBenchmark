@echo off
echo -------------------------------------------------------------------------------

set FILENAME=Int64DivBV_D2005_%1.exe
echo Building %FILENAME% with D2005
call BuildD2005 Int64DivBV %2 %3 %4
rename Int64DivBV.exe %FILENAME%

set FILENAME=Int64DivBV_D2006_%1.exe
echo Building %FILENAME% with D2006
call BuildD2006 Int64DivBV %2 %3 %4
rename Int64DivBV.exe %FILENAME%

set FILENAME=Int64DivBV_D7_%1.exe
echo Building %FILENAME% with D7
call BuildD7 Int64DivBV %2 %3 %4
rename Int64DivBV.exe %FILENAME%
