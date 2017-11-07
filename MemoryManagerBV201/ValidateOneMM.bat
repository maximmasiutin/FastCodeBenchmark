@echo off

IF "%1"=="" GOTO MMError

rem Call ValidateOne D6 %1
Call ValidateOne D7 %1
Call ValidateOne D2005 %1
Call ValidateOne D2006 %1

GOTO Done

:MMError
echo *** No memory manager specified - aborting...
GOTO Done

:Done