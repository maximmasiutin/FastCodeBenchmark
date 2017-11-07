@echo off
echo -------------------------------------------------------------------------------

set FILENAME=IDCTBV_D7_%1.exe
echo Building %FILENAME% with D7
call BuildD7 IDCTBV %2 %3 %4
rename IDCTBV.exe %FILENAME%

set FILENAME=IDCTBV_D2005_%1.exe
echo Building %FILENAME% with D2005
call BuildD2005 IDCTBV %2 %3 %4
rename IDCTBV.exe %FILENAME%

set FILENAME=IDCTBV_D2006_%1.exe
echo Building %FILENAME% with D2006
call BuildD2006 IDCTBV %2 %3 %4
rename IDCTBV.exe %FILENAME%

set FILENAME=IDCTBV_D2007_%1.exe
echo Building %FILENAME% with D2007
call BuildD2007 IDCTBV %2 %3 %4
rename IDCTBV.exe %FILENAME%