@echo off
echo.

rem Not currently supporting Delphi 5
rem set FILENAME=MMUsageDLL_D5_%1.dll
rem echo Building %FILENAME% with D5
rem call BuildD5 MMUsageDLL -DMM_%1 -U.\NxDelphi5
rem rename MMUsageDLL.dll %FILENAME%

set FILENAME=MMUsageDLL_D6_%1.dll
echo Building %FILENAME% with D6
call BuildD6 MMUsageDLL -DMM_%1 -U.\NxDelphi6
rename MMUsageDLL.dll %FILENAME%

set FILENAME=MMUsageDLL_D7_%1.dll
echo Building %FILENAME% with D7
call BuildD7 MMUsageDLL -DMM_%1 -U.\NxDelphi7
rename MMUsageDLL.dll %FILENAME%

set FILENAME=MMUsageDLL_D2005_%1.dll
echo Building %FILENAME% with D2005
call BuildD2005 MMUsageDLL -DMM_%1 -U.\NxDelphi9
rename MMUsageDLL.dll %FILENAME%


rem Not currently supporting Delphi 5
rem set FILENAME=FastcodeMMChallengeBV_D5_%1.exe
rem echo Building %FILENAME% with D5
rem call BuildD5 -$R+ -$Q+ FastcodeMMChallengeBV -DMM_%1 -U.\NxDelphi5
rem rename FastcodeMMChallengeBV.exe %FILENAME%

set FILENAME=FastcodeMMChallengeBV_D6_%1
echo Building %FILENAME% with D6
call BuildD6 -$R+ -$Q+ FastcodeMMChallengeBV -DMM_%1 -U.\NxDelphi6
rename FastcodeMMChallengeBV.exe %FILENAME%.exe
call BuildD6 -$R- -$Q- FastcodeMMChallengeBV -DMM_%1 -U.\NxDelphi6
rename FastcodeMMChallengeBV.exe %FILENAME%_Benchmark.exe

set FILENAME=FastcodeMMChallengeBV_D7_%1
echo Building %FILENAME% with D7
call BuildD7 -$R+ -$Q+ FastcodeMMChallengeBV -DMM_%1 -U.\NxDelphi7
rename FastcodeMMChallengeBV.exe %FILENAME%.exe
call BuildD7 -$R- -$Q- FastcodeMMChallengeBV -DMM_%1 -U.\NxDelphi7
rename FastcodeMMChallengeBV.exe %FILENAME%_Benchmark.exe

set FILENAME=FastcodeMMChallengeBV_D2005_%1
echo Building %FILENAME% with D2005
call BuildD2005 -$R+ -$Q+ FastcodeMMChallengeBV -DMM_%1 -U.\NxDelphi9
rename FastcodeMMChallengeBV.exe %FILENAME%.exe
call BuildD2005 -$R- -$Q- FastcodeMMChallengeBV -DMM_%1 -U.\NxDelphi9
rename FastcodeMMChallengeBV.exe %FILENAME%_Benchmark.exe
