@echo off
echo -------------------------------------------------------------------------------

set FILENAME=ArcSin_D2005_%1.exe
echo Building %FILENAME% with D2005
call BuildD2005 ArcSin %2 %3 %4
rename ArcSin.exe %FILENAME%

set FILENAME=ArcSin_D2006_%1.exe
echo Building %FILENAME% with D2006
call BuildD2006 ArcSin %2 %3 %4
rename ArcSin.exe %FILENAME%

set FILENAME=ArcSin_D7_%1.exe
echo Building %FILENAME% with D7
call BuildD7 ArcSin %2 %3 %4
rename ArcSin.exe %FILENAME%
