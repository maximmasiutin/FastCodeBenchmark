@echo off

IF "%1"=="" GOTO CompilerError

IF "%2"=="" GOTO MMError

set FILENAME=FastCodeMMChallengeBV_%1_%2_Benchmark.exe
IF NOT EXIST %FILENAME% GOTO FileError

echo   %date% %time%  Benchmark  %1 %2
%FILENAME% -B 

GOTO Done

:CompilerError
echo No compiler specified - aborting...
GOTO Done

:MMError
echo No memory manager specified - aborting...
GOTO Done

:FileError
echo Not found.  Skipping %FILENAME%
GOTO Done

:Done