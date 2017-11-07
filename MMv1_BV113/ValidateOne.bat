@echo off

IF "%1"=="" GOTO CompilerError

IF "%2"=="" GOTO MMError

set FILENAME=FastCodeMMChallengeBV_%1_%2.exe
IF NOT EXIST %FILENAME% GOTO FileError

echo   %date% %time%  Regular valition  %1 %2
%FILENAME% -RV 
echo   %date% %time%  Extra valition  %1 %2
%FILENAME% -EV 

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