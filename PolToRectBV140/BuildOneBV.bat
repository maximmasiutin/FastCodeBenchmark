@echo off
echo -------------------------------------------------------------------------------

set FILENAME=ComplexPolToRectBV_D2005_%1.exe
echo Building %FILENAME% with D2005
call BuildD2005 ComplexPolToRectBV %2 %3 %4
rename ComplexPolToRectBV.exe %FILENAME%

set FILENAME=ComplexPolToRectBV_D2006_%1.exe
echo Building %FILENAME% with D2006
call BuildD2006 ComplexPolToRectBV %2 %3 %4
rename ComplexPolToRectBV.exe %FILENAME%

set FILENAME=ComplexPolToRectBV_D6_%1.exe
echo Building %FILENAME% with D6
call BuildD6 ComplexPolToRectBV %2 %3 %4
rename ComplexPolToRectBV.exe %FILENAME%

set FILENAME=ComplexPolToRectBV_D7_%1.exe
echo Building %FILENAME% with D7
call BuildD7 ComplexPolToRectBV %2 %3 %4
rename ComplexPolToRectBV.exe %FILENAME%
