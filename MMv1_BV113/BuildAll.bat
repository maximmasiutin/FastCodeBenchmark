@echo off
cls
echo FastCode MM Challenge
echo ===============================================================

del MMValidateDll*.exe /q
del MMUsageDll*.dll /q
del FastcodeMMChallengeBV*.exe /q

echo.
echo.
echo Build
echo ---------------------------------------------------------------

rem Not currently supporting Delphi 5
rem echo Building MMValidateDll with D5
rem call BuildD5 MMValidateDll
rem rename MMValidateDll.exe MMValidateDll_D5.exe

echo Building MMValidateDll with D6
call BuildD6 MMValidateDll
rename MMValidateDll.exe MMValidateDll_D6.exe

echo Building MMValidateDll with D7
call BuildD7 MMValidateDll
rename MMValidateDll.exe MMValidateDll_D7.exe

echo Building MMValidateDll with D2005
call BuildD2005 MMValidateDll
rename MMValidateDll.exe MMValidateDll_D2005.exe


call BuildOneMM BUCKETMM
call BuildOneMM BUCKETMM_ASM
call BuildOneMM BUCKETMMDKC_ASM
call BuildOneMM DKCIA32MM
call BuildOneMM EWCMM


rem removed because it freezes on validation.
rem call BuildOneMM FASTMM2

call BuildOneMM FASTMM3

call BuildOneMM FASTMM4
call BuildOneMM FASTMM4_16

rem removed because it freezes on benchmarks.
rem call BuildOneMM NEXUSMM

rem removed because it causes exceptions on startup of the B&V
rem call BuildOneMM QMEMORY

rem removed because it freezes on validation.
rem call BuildOneMM RECYCLERMM

call BuildOneMM RTLMM

rem removed because it causes MMValidateDLL to disappear.
rem call BuildOneMM TOPMM

rem removed because it fails validations and throws at least one exception in validation.
rem call BuildOneMM WINMEM
