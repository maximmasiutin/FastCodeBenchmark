@echo off
echo.

IF "%1"=="" GOTO CompilerError

set FILENAME=MMValidateDll_%1.exe
IF NOT EXIST %FILENAME% GOTO FileError

rem echo   %1 DLL valition - %date% %time%
echo   %date% %time%  DLL valition  %1
%FILENAME% -V 
GOTO Continue

:FileError
echo Not found.  Skipping %FILENAME%
GOTO Continue

:Continue

Call ValidateOne %1 BUCKETMM
Call ValidateOne %1 BUCKETMM_ASM
Call ValidateOne %1 BUCKETMMDKC_ASM

Call ValidateOne %1 EWCMM
Call ValidateOne %1 FASTMM2
Call ValidateOne %1 FASTMM3
Call ValidateOne %1 FASTMM4
Call ValidateOne %1 FASTMM4_16
Call ValidateOne %1 NEXUSMM
Call ValidateOne %1 RECYCLERMM
Call ValidateOne %1 RTLMM
Call ValidateOne %1 TOPMM
Call ValidateOne %1 WINMEM

rem Put this one at the end because it takes a while
Call ValidateOne %1 DKCIA32MM

GOTO Done

:CompilerError
echo *** No compiler specified - aborting...
GOTO Done

:Done