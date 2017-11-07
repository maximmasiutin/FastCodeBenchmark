@echo off
set DCC="C:\Program Files\CodeGear\RAD Studio\5.0\bin\DCC32.exe"

%DCC% -b %1 %2 %3 %4  >nul:

if errorlevel 1 goto :Error

rem echo   OK
goto :End

:Error
echo   Failed ***

:End
