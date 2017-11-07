@echo off

IF "%1"=="" GOTO MMError

Call BenchmarkOne D6 %1%
Call BenchmarkOne D7 %1%
Call BenchmarkOne D2005 %1%

GOTO Done

:MMError
echo *** No memory manager specified - aborting...
GOTO Done

:Done