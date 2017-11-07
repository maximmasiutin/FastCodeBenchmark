@echo off
echo -------------------------------------------------------------------------------

set FILENAME=ArcCosBV_D2005_%1.exe
echo Building %FILENAME% with D2005
call BuildD2005 ArcCosBV %2 %3 %4
rename ArcCosBV.exe %FILENAME%

set FILENAME=ArcCosBV_D2006_%1.exe
echo Building %FILENAME% with D2006
call BuildD2006 ArcCosBV %2 %3 %4
rename ArcCosBV.exe %FILENAME%

set FILENAME=ArcCosBV_D7_%1.exe
echo Building %FILENAME% with D7
call BuildD7 ArcCosBV %2 %3 %4
rename ArcCosBV.exe %FILENAME%
