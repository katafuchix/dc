#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use Math::BigInt;
$bigv = Math::BigInt->new("-1.234567890e+500"); #Math::BigIntインスタンス
$bigv->blsft(2); #2進数で左2ビットシフト。4倍になる
print $bigv; #結果：-4938271560000000.....
print "</PRE></BODY></HTML>";
