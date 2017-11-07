@echo off
echo -------------------------------------------------------------------------------

set FILENAME=ComplexRegtDivBV_D2005_%1.exe
echo Building %FILENAME% with D2005
call BuildD2005 ComplexRegtDivBV %2 %3 %4
rename ComplexRegtDivBV.exe %FILENAME%

set FILENAME=ComplexRegtDivBV_D2006_%1.exe
echo Building %FILENAME% with D2006
call BuildD2006 ComplexRegtDivBV %2 %3 %4
rename ComplexRegtDivBV.exe %FILENAME%

set FILENAME=ComplexRegtDivBV_D6_%1.exe
echo Building %FILENAME% with D6
call BuildD6 ComplexRegtDivBV %2 %3 %4
rename ComplexRegtDivBV.exe %FILENAME%

set FILENAME=ComplexRegtDivBV_D7_%1.exe
echo Building %FILENAME% with D7
call BuildD7 ComplexRegtDivBV %2 %3 %4
rename ComplexRegtDivBV.exe %FILENAME%
