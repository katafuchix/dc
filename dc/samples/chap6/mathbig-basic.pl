#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use Math::BigInt;
$bigv = Math::BigInt->new('1.234567890e+500'); #Math::BigIntインスタンス
$bigv2 = Math::BigInt->new('5.0e+500'); #Math::BigIntインスタンス
print $bigv->badd($bigv2); #加算。結果：623456789000000000000000000000000...
print "\n";
print $bigv->bpow(10); #べき乗。結果：88728590907617398926106457639559958...
print "\n";
print $bigv->bone()->binc(); #1をインクリメント。結果：2
print "</PRE></BODY></HTML>";
