#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use Math::BigInt;
$bigv = Math::BigInt->new("4"); #Math::BigIntインスタンス
$bigv2 = Math::BigInt->new("6"); #Math::BigIntインスタンス
print $bigv->band($bigv2); #100 & 110 = 100。結果：4
print "\n";
print $bigv->bxor($bigv2); #100 ^ 110 = 010。結果：2
print "</PRE></BODY></HTML>";
