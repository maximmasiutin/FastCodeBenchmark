@echo off
echo.
echo.
echo Benchmarks
echo ---------------------------------------------------------------

del MMBench_*.csv /q
del BVSummary_*.txt /q

rem call BenchmarkD6
call BenchmarkD7
call BenchmarkD2005
call BenchmarkD2006
