#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
print log 2;                         #2の自然対数。結果：0.693147180559945
print "\n";
print log exp 1;                     #eの自然対数。結果：1
print "\n";
print logn(8,2);                     #2を底とする8の対数。結果：3
sub logn { log($_[0]) / log($_[1]) } #nを底とする対数計算サブルーチン
print "</PRE></BODY></HTML>";
