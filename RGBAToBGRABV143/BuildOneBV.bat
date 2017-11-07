@echo off
echo -------------------------------------------------------------------------------

set FILENAME=RGBAToBGRABV_D2005_%1.exe
echo Building %FILENAME% with D2005
call BuildD2005 RGBAToBGRABV %2 %3 %4
rename RGBAToBGRABV.exe %FILENAME%

set FILENAME=RGBAToBGRABV_D2006_%1.exe
echo Building %FILENAME% with D2006
call BuildD2006 RGBAToBGRABV %2 %3 %4
rename RGBAToBGRABV.exe %FILENAME%

set FILENAME=RGBAToBGRABV_D6_%1.exe
echo Building %FILENAME% with D6
call BuildD6 RGBAToBGRABV %2 %3 %4
rename RGBAToBGRABV.exe %FILENAME%

set FILENAME=RGBAToBGRABV_D7_%1.exe
echo Building %FILENAME% with D7
call BuildD7 RGBAToBGRABV %2 %3 %4
rename RGBAToBGRABV.exe %FILENAME%
