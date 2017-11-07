@echo off
echo -------------------------------------------------------------------------------

set FILENAME=ComplexRegtSubBV_D2005_%1.exe
echo Building %FILENAME% with D2005
call BuildD2005 ComplexRegtSubBV %2 %3 %4
rename ComplexRegtSubBV.exe %FILENAME%

set FILENAME=ComplexRegtSubBV_D2006_%1.exe
echo Building %FILENAME% with D2006
call BuildD2006 ComplexRegtSubBV %2 %3 %4
rename ComplexRegtSubBV.exe %FILENAME%

set FILENAME=ComplexRegtSubBV_D6_%1.exe
echo Building %FILENAME% with D6
call BuildD6 ComplexRegtSubBV %2 %3 %4
rename ComplexRegtSubBV.exe %FILENAME%

set FILENAME=ComplexRegtSubBV_D7_%1.exe
echo Building %FILENAME% with D7
call BuildD7 ComplexRegtSubBV %2 %3 %4
rename ComplexRegtSubBV.exe %FILENAME%
