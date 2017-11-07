@echo off
cls
del IsPrimeB*.exe /q

call BuildOneBV RangeOffOverflowOnOptOff -$R- -$Q+ -$O-
call BuildOneBV RangeOffOverflowOffOptOff -$R- -$Q- -$O-
call BuildOneBV RangeOffOverflowOnOptOn -$R- -$Q+ -$O+
call BuildOneBV RangeOffOverflowOffOptOn -$R- -$Q- -$O+

call BuildOneBV RangeOnOverflowOnOptOff -$R+ -$Q+ -$O-
call BuildOneBV RangeOnOverflowOffOptOff -$R+ -$Q- -$O-
call BuildOneBV RangeOnOverflowOnOptOn -$R+ -$Q+ -$O+
call BuildOneBV RangeOnOverflowOffOptOn -$R+ -$Q- -$O+
