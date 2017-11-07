@echo off
echo -------------------------------------------------------------------------------

set FILENAME=IsPrimeBV_D2005_%1.exe
echo Building %FILENAME% with D2005
call BuildD2005 IsPrimeBV %2 %3 %4
rename IsPrimeBV.exe %FILENAME%

set FILENAME=IsPrimeBV_D2006_%1.exe
echo Building %FILENAME% with D2006
call BuildD2006 IsPrimeBV %2 %3 %4
rename IsPrimeBV.exe %FILENAME%

set FILENAME=IsPrimeBV_D7_%1.exe
echo Building %FILENAME% with D7
call BuildD7 IsPrimeBV %2 %3 %4
rename IsPrimeBV.exe %FILENAME%
