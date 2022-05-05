#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use Math::BigInt;
$bigv = Math::BigInt->new("-1.234567890e+500"); #Math::BigIntインスタンス
print $bigv->is_even();#偶数判定。結果：1
print "\n";
print $bigv->is_pos(); #正数判定。結果：0
print "\n";
$sign = $bigv * -2;    #-2を掛けて正数にする
print $sign->sign();   #符号取得。結果：+
print "</PRE></BODY></HTML>";
