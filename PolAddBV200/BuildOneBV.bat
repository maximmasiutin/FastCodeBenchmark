@echo off
echo -------------------------------------------------------------------------------

set FILENAME=ComplexPolAddBV_D2005_%1.exe
echo Building %FILENAME% with D2005
call BuildD2005 ComplexPolAddBV %2 %3 %4
rename ComplexPolAddBV.exe %FILENAME%

set FILENAME=ComplexPolAddBV_D2006_%1.exe
echo Building %FILENAME% with D2006
call BuildD2006 ComplexPolAddBV %2 %3 %4
rename ComplexPolAddBV.exe %FILENAME%

set FILENAME=ComplexPolAddBV_D6_%1.exe
echo Building %FILENAME% with D6
call BuildD6 ComplexPolAddBV %2 %3 %4
rename ComplexPolAddBV.exe %FILENAME%

set FILENAME=ComplexPolAddBV_D7_%1.exe
echo Building %FILENAME% with D7
call BuildD7 ComplexPolAddBV %2 %3 %4
rename ComplexPolAddBV.exe %FILENAME%
