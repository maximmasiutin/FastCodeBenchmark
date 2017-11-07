@echo off
echo -------------------------------------------------------------------------------

set FILENAME=StrCopyBenchValid_D2005_%1.exe
echo Building %FILENAME% with D2005
call BuildD2005 StrCopyBenchValid %2 %3 %4
rename StrCopyBenchValid.exe %FILENAME%

set FILENAME=StrCopyBenchValid_D2006_%1.exe
echo Building %FILENAME% with D2006
call BuildD2006 StrCopyBenchValid %2 %3 %4
rename StrCopyBenchValid.exe %FILENAME%

set FILENAME=StrCopyBenchValid_D7_%1.exe
echo Building %FILENAME% with D7
call BuildD7 StrCopyBenchValid %2 %3 %4
rename StrCopyBenchValid.exe %FILENAME%
