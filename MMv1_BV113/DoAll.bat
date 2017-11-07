@echo off

rem call BuildAll > BuildLog.txt
call BuildAll

call ValidateAll

call BenchmarkAll