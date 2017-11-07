@echo off
echo.

IF "%1"=="" GOTO CompilerError

Call BenchmarkOne %1% BUCKETMM
Call BenchmarkOne %1% BUCKETMM_ASM
Call BenchmarkOne %1% BUCKETMMDKC_ASM

Call BenchmarkOne %1% EWCMM
Call BenchmarkOne %1% FASTMM2
Call BenchmarkOne %1% FASTMM3
Call BenchmarkOne %1% FASTMM4
Call BenchmarkOne %1% FASTMM4_16
Call BenchmarkOne %1% NEXUSMM
Call BenchmarkOne %1% RECYCLERMM
Call BenchmarkOne %1% RTLMM
Call BenchmarkOne %1% TOPMM
Call BenchmarkOne %1% WINMEM

rem Put this one at the end because it takes a while
Call BenchmarkOne %1% DKCIA32MM

GOTO Done

:CompilerError
echo *** No compiler specified - aborting...
GOTO Done

:Done
