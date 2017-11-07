@echo off

echo Everything off
call :BuildAndValidate "-$O- -$Q- -$R- -$W-" "None"

echo Optimization on
call :BuildAndValidate "-$O+ -$Q- -$R- -$W-" "Optimization"

echo Overflow checking on
call :BuildAndValidate "-$O- -$Q+ -$R- -$W-" "Overflow"

echo Range checking on
call :BuildAndValidate "-$O- -$Q- -$R+ -$W-" "Range"

echo Stack frames on
call :BuildAndValidate "-$O- -$Q- -$R- -$W+" "Stackframes"

echo Building normal edition
echo.
del IntToStrBV.exe > NUL 2> NUL
dcc32 -B -H -W IntToStrBV.dpr -$O+ -$Q- -$R- -$W-

goto :EOF



:BuildAndValidate

echo Building 
del IntToStrBV.exe > NUL 2> NUL
dcc32 -B IntToStrBV.dpr %~1 > NUL
echo Validating
IntToStrBV.exe -v -rv ReportValidation_%~2.txt
echo.

goto :EOF
