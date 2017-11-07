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

rem Not currently supporting Delphi 6
rem echo Building MMValidateDll with D6
rem call BuildD6 MMValidateDll
rem rename MMValidateDll.exe MMValidateDll_D6.exe

echo Building MMValidateDll with D7
call BuildD7 MMValidateDll
rename MMValidateDll.exe MMValidateDll_D7.exe

echo Building MMValidateDll with D2005
call BuildD2005 MMValidateDll
rename MMValidateDll.exe MMValidateDll_D2005.exe

echo Building MMValidateDll with D2006
call BuildD2006 MMValidateDll
rename MMValidateDll.exe MMValidateDll_D2006.exe


call BuildOneMM BUCKETMM
call BuildOneMM BUCKETMM_ASM
call BuildOneMM BUCKETMMDKC_ASM
call BuildOneMM DKCIA32MM
call BuildOneMM EWCMM
call BuildOneMM FASTMM2
call BuildOneMM FASTMM3
call BuildOneMM FASTMM4
call BuildOneMM FASTMM4_16
call BuildOneMM NEXUSMM
call BuildOneMM QMEMORY
call BuildOneMM RECYCLERMM
call BuildOneMM RTLMM
call BuildOneMM TOPMM
call BuildOneMM WINMEM
